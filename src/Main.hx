package;


import trImpl.World;
import trImpl.UnitRadius;
import flash.Lib;
import traectory.LineBuilder;
import renderer.Renderer;
import renderer.CircleRenderer;
import flash.events.KeyboardEvent;
import flash.events.Event;
import renderer.CommonRenderer;
import math.Rect;
import minject.Injector;
import openfl.display.Sprite;


class Main extends Sprite {
	var world:World;
	var lineBuilder:LineBuilder;

	public function new() {
		super();
		var injector = new Injector();

		var margin = 5;
		injector.mapValue(UnitRadius, new UnitRadius(15));

		var dRend = new CommonRenderer();
		addChild(dRend);
		var unitRenderer = injector.instantiate(CircleRenderer);
		addChild(unitRenderer);

		var worldRect = new Rect(margin, margin, stage.stageWidth - margin * 2, stage.stageHeight - margin * 2);

		trace(dRend.x  + " " + dRend.y);

		dRend.drawRect(worldRect);

		injector.mapClass(TraectoryResolver, TraectoryResolver);
		injector.mapValue(Rect, worldRect);
		injector.mapValue(Renderer, unitRenderer);
		injector.mapValue(CommonRenderer, dRend);
		injector.mapClass(LineBuilder, LineBuilder);
		injector.mapClass(World, World);

		lineBuilder = injector.instantiate(LineBuilder);
		this.world = injector.instantiate(World);

		stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
	}

	var t:Float;
	function enterFrameHandler(e:Event) {
		t = Lib.getTimer() / 1000;
		world.update(t);
	}

	function keyboardHandler(e:KeyboardEvent) {
		world.add(lineBuilder.init(t));
	}


}