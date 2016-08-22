package;


import trajectory.RandomTrajectoryBuilder;
import trajectory.circle.CircleBuilder;
import renderer.DebugRenderer;
import info.StatsRenderer;
import trajectory.TrajectoryBuilder;
import info.Stats;
import impl.TrajectoryResolver;
import openfl.StatsRendererOFL;
import flash.ui.Keyboard;
import data.Speed;
import impl.TrajectorySpawner;
import impl.DebugSystem;
import impl.World;
import data.UnitRadius;
import flash.Lib;
import trajectory.line.LineBuilder;
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

	inline static var RADIUS = 6;
	inline static var SPEED = 80;

	var injector:Injector;

	var world:World;
	var unitRenderer:CircleRenderer;
	var debugSystem:DebugSystem;
	var trajectorySpawner:TrajectorySpawner;
	var worldRect:Rect;
	var stats:Stats;
	var debugRenderer:DebugRendererOFL;

	public function new() {
		super();
		injector = new Injector();

		injector.mapValue(UnitRadius, new UnitRadius(RADIUS));
		injector.mapValue(Speed, new Speed(SPEED));

		worldRect = new Rect(RADIUS, -RADIUS, stage.stageWidth - RADIUS * 2, stage.stageHeight + RADIUS); // баунд строго под размеры экрана
		worldRect = new Rect(100, 100, 700, 500);

		debugRenderer = new DebugRendererOFL();
		injector.mapValue(DebugRenderer, debugRenderer);
		var info = new StatsRendererOFL();
		injector.mapValue(StatsRenderer, info);
		stats = injector.instantiate(Stats);
		stats.delay = delay;
		injector.mapValue(Stats, stats);
		injector.mapSingleton(TrajectoryResolver);
		world = injector.instantiate(World);
		injector.mapValue(World, world);
		injector.mapValue(Rect, worldRect);
		unitRenderer = injector.instantiate(CircleRenderer);
		injector.mapValue(ItemRenderer, unitRenderer);
		debugSystem = injector.instantiate(DebugSystem);

// Вот здесь можно как угодно фантазировать на предмет вариантов траекторий, которые будут спаунится, вероятности и пр.
		var builder = new RandomTrajectoryBuilder();
		builder.addBuilder(injector.instantiate(LineBuilder));
		builder.addBuilder(injector.instantiate(CircleBuilder));

		injector.mapValue(TrajectoryBuilder, builder);
		trajectorySpawner = injector.instantiate(TrajectorySpawner);

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
		var tr = trajectorySpawner.choose(t);
		if (tr != null) {
			world.add(tr);
		}
	}

	function keyboardHandler(e:KeyboardEvent) {
		switch (e.keyCode) {
			case Keyboard.SPACE : world.add(trajectorySpawner.choose(t));
			case Keyboard.MINUS : {
				delay = Math.max(delay - 0.001, 0.001);
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