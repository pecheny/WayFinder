package impl;
import renderer.DebugRenderer;
import info.Stats;
import data.UnitRadius;
import traectory.Traectory;
class DebugSystem {
	@inject public var stats:Stats;
	@inject public var world:World;
	@inject public var debugRenderer:DebugRenderer;
	@inject public var unitRadius:UnitRadius;

	inline static var periodforVis = 1;


	var detected:Array<Traectory> = [];
	public function update(t:Float):Void {
		debugRenderer.clear();
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
					if (detected.indexOf(tr)<0) {
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

	private inline function drawPath(tr:Traectory, t:Float):Void {
		debugRenderer.drawLine(
			tr.getX(t - periodforVis),
			tr.getY(t - periodforVis),
			tr.getX(t + periodforVis),
			tr.getY(t + periodforVis)
		);
	}

}
