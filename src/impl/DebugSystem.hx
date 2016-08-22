package impl;
import math.Rect;
import renderer.DebugRenderer;
import info.Stats;
import data.UnitRadius;
import traectory.Traectory;
class DebugSystem {
	@inject public var stats:Stats;
	@inject public var world:World;
	@inject public var debugRenderer:DebugRenderer;
	@inject public var unitRadius:UnitRadius;
	@inject public var worldRect:Rect;

	inline static var periodforVis = 2;
	inline static var visStep = 0.25;


	var detected:Array<Traectory> = [];

	public function update(t:Float):Void {
		debugRenderer.clear();
		debugRenderer.drawRect(worldRect);
		var i = 0;
		var traectories = world.traectories;
		while (i < traectories.length) {
			var tr = traectories[i];
			drawPath(tr, t);
			var j:Int = i + 1;
			while (j < traectories.length) {
				var tr2 = traectories[j];
				var dx = tr2.getX(t) - tr.getX(t);
				var dy = tr2.getY(t) - tr.getY(t);
				var intersects:Bool = (dx * dx + dy * dy) < (unitRadius.value * unitRadius.value * 4);
				if (intersects) {
					if (detected.indexOf(tr) < 0) {
						detected.push(tr);
						stats.objectHits++;
						trace("Cross!111");
						trace(tr);
						trace(tr2);
					}
					debugRenderer.drawCircle(tr.getX(t) + dx / 2, tr.getY(t) + dy / 2, 16);
				}
				j++;
			}
			i++;
		}
	}

	private inline function drawPath(tr:Traectory, t0:Float):Void {
		var t = t0 - periodforVis;

		while (t < t0 + periodforVis - visStep) {
			debugRenderer.drawLine(
				tr.getX(t),
				tr.getY(t),
				tr.getX(t + visStep),
				tr.getY(t + visStep)
			);
			t += visStep;
		}
	}

}
