package;


import renderer.DebugRenderer;
import info.StatsRenderer;
import traectory.TraectoryBuilder;
import info.Stats;
import impl.TraectoryResolver;
import openfl.StatsRendererOFL;
import flash.ui.Keyboard;
import math.Range;
import traectory.line.LineTraectory;
import data.Speed;
import impl.TraectorySpawner;
import impl.DebugSystem;
import impl.World;
import data.UnitRadius;
import flash.Lib;
import traectory.line.LineBuilder;
import renderer.ItemRenderer;
import openfl.CircleRenderer;
import flash.events.KeyboardEvent;
import flash.events.Event;
import openfl.DebugRendererOFL;
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
	var traectorySpawner:TraectorySpawner;
	var injector:Injector;
	var worldRect:Rect;
	var stats:Stats;
	var debugRenderer:DebugRendererOFL;

	public function new() {
		super();
		injector = new Injector();
		var radius = 5;
		injector.mapValue(UnitRadius, new UnitRadius(radius));
		injector.mapValue(Speed, new Speed(60));
		worldRect = new Rect(radius, -radius, stage.stageWidth - radius * 2, stage.stageHeight + radius);
		debugRenderer = new DebugRendererOFL();
		injector.mapValue(DebugRenderer, debugRenderer);
		var info = new StatsRendererOFL();
		injector.mapValue(StatsRenderer, info);
		stats = injector.instantiate(Stats);
		stats.delay = delay;
		injector.mapValue(Stats, stats);
		injector.mapSingleton(TraectoryResolver);
		world = injector.instantiate(World);
		injector.mapValue(World, world);
		injector.mapValue(Rect, worldRect);
		injector.mapValue(ItemRenderer, unitRenderer);
		injector.mapSingletonOf(TraectoryBuilder, LineBuilder);
		debugSystem = injector.instantiate(DebugSystem);
		traectorySpawner = injector.instantiate(TraectorySpawner);
		unitRenderer = injector.instantiate(CircleRenderer);

		addChild(unitRenderer);
		addChild(debugRenderer);
		addChild(info);

		stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);

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
		var tr = traectorySpawner.choose(t);
		if (tr != null) {
			world.add(tr);
		}
	}

	function keyboardHandler(e:KeyboardEvent) {
		switch (e.keyCode) {
			case Keyboard.SPACE : world.add(traectorySpawner.choose(t));
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