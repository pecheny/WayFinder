package;


import trImpl.stats.Stats;
import trImpl.TraectoryResolver;
import trImpl.stats.StatsRenderer;
import flash.ui.Keyboard;
import math.Range;
import traectory.LineTraectory;
import trImpl.data.Speed;
import trImpl.TraectorySpawner;
import trImpl.DebugSystem;
import trImpl.World;
import trImpl.data.UnitRadius;
import flash.Lib;
import traectory.LineBuilder;
import renderer.Renderer;
import renderer.CircleRenderer;
import flash.events.KeyboardEvent;
import flash.events.Event;
import renderer.DebugRenderer;
import math.Rect;
import minject.Injector;
import openfl.display.Sprite;

/**
 В точке входа свинарник, но для прототипа это относительно безобидно.
 получилось достаточно многуфункциональное место: помимо иницилизации всего и вся, обработка клавиатуры и вызов update() всем, кому требуется.
 По-хорошему, это нужно разностить на отдельные сущности, а для апдейтера вообще задействовать какой-нибудь движок, работающий с системами.
 Хотя можно просто обойтись Updater/Updateble. Но здесь kiss/yagni победил solid.
  */
class Main extends Sprite {
	var world:World;
	var unitRenderer:CircleRenderer;
	var debugSystem:DebugSystem;
	var lineBuilder:LineBuilder;
	var traectoryChooser:TraectorySpawner;
	var injector:Injector;
	var worldRect:Rect;
	var stats:Stats;
	var debugRenderer:DebugRenderer;

	public function new() {
		super();
		injector = new Injector();
		var radius = 5;
		injector.mapValue(UnitRadius, new UnitRadius(radius));
		injector.mapValue(Speed, new Speed(60));
		worldRect = new Rect(radius, -radius, stage.stageWidth - radius * 2, stage.stageHeight + radius);
		debugRenderer = new DebugRenderer();
		injector.mapValue(DebugRenderer, debugRenderer);
		var info = new StatsRenderer();
		injector.mapValue(StatsRenderer, info);
		stats = injector.instantiate(Stats);
		stats.delay = delay;
		injector.mapValue(Stats, stats);
		injector.mapSingleton(TraectoryResolver);
		world = injector.instantiate(World);
		injector.mapValue(World, world);
		injector.mapValue(Rect, worldRect);
		injector.mapValue(Renderer, unitRenderer);
		injector.mapClass(LineBuilder, LineBuilder);
		lineBuilder = injector.instantiate(LineBuilder);
		debugSystem = injector.instantiate(DebugSystem);
		traectoryChooser = injector.instantiate(TraectorySpawner);
		unitRenderer = injector.instantiate(CircleRenderer);

		addChild(unitRenderer);
		addChild(debugRenderer);
		addChild(info);

		stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);

//		test();
	}


	function test() {
//      на TDD не сподобился, здесь были всякие сурогаты
//		var l1 = LineBuilder.buildLine(100, 100, 1, worldRect, 150, true);
//		var l2 = LineBuilder.buildLine(100, 100, 1, worldRect, 150, false);

//		var l1 = LineBuilder.buildLine(110, 400, 1, worldRect, 150, true);
//		var l2 = LineBuilder.buildLine(410, 100, 1, worldRect, 150, false);

//		var l2 = new LineTraectory(541.8676825705916, 5, 6.722771694409815, 149.84927207278935, new Range(4.164, 8.067922868012573));
//		var l1 = new LineTraectory(643.433392830193, 590, -59.65803674556757, -137.62601008408444, new Range(6.789, 11.03965000171542));

		var l2 = new LineTraectory( 732.9454936739057, 590, -43.438209627315025, -41.389877317690086, new Range (2.123, 16.25689064939244));
		var l1 = new LineTraectory( 572.7470487239771, 590, -2.05583441552381, -59.96476919705393, new Range (3.423, 13.178728369062764));

		var res:TraectoryResolver = injector.instantiate(TraectoryResolver);
		trace(res.cross(l1, l2));
//		trace(res.cross(l2, l1));
		world.add(l1);
		world.add(l2);
	}

	var t:Float = 0;
	var delay = 0.15;
	var nextSpawn:Float = 0;

	var lastTime:Float = 0;
	var paused:Bool;
	var debugging:Bool = true;

	function enterFrameHandler(e:Event) {
		var dt = Lib.getTimer() / 1000 - lastTime;
		lastTime = Lib.getTimer() / 1000;
		if (paused) return;
		t += dt;
		if (t > nextSpawn) {
			nextSpawn = t + delay;
			spawn();
		}
		world.update(t);
		unitRenderer.update(t);
		if (debugging) {
			debugSystem.update(t);
		}
	}

	function spawn() {
		var tr = traectoryChooser.choose(t);
		if (tr != null) {
			world.add(tr);
		}
	}

	function keyboardHandler(e:KeyboardEvent) {
		switch (e.keyCode) {
			case Keyboard.SPACE : world.add(traectoryChooser.choose(t));
			case Keyboard.MINUS : {
				delay = Math.max(delay - 0.01, 0.01);
				stats.delay = delay;
			}
			case Keyboard.EQUAL : {
				delay += 0.01;
				stats.delay = delay;
			}

			case Keyboard.P : paused = !paused;
			case Keyboard.R : world.reset();
			case Keyboard.D : {
				debugging = !debugging;
				debugRenderer.clear();
			}
		}

	}


}