package impl;
import renderer.DebugRenderer;
import data.Speed;
import data.UnitRadius;
import math.Range;
import traectory.Traectory;
class TraectoryResolver {
	@inject public var unitRadius:UnitRadius;
	@inject public var speed:Speed;
	@inject public var debugRenderer:DebugRenderer;

	var timeStep:Float;

	public function new() {
	}

	@post public function init():Void {
		timeStep =  unitRadius.value / speed.value;
	}

	public function cross(tra:Traectory, trb:Traectory):Bool {
		var sharedTime = tra.period.cross(trb.period);
		if (sharedTime == null) return false;
//      предположим, что направление вдоль y не может меняться (не будем ориентироваться на синусоиды с уклоном оси более 45)
		var yRangeA = new Range(tra.getY(sharedTime.t1), tra.getY(sharedTime.t2));
		yRangeA.t1 -= unitRadius.value;
		yRangeA.t2 += unitRadius.value;
//		trace("yRangeA: " + yRangeA);
		var yRangeB = new Range(trb.getY(sharedTime.t1), trb.getY(sharedTime.t2));
		yRangeB.t1 -= unitRadius.value;
		yRangeB.t2 += unitRadius.value;
//		trace("yRangeB: " + yRangeB);

		var sharedY = yRangeA.cross(yRangeB);
//		trace("sharedY: " + sharedY);

		if (sharedY == null) return false;
		var t = tra.getTbyY(sharedY.t2);
		var t2 = tra.getTbyY(sharedY.t1);
		if (t>t2) {
			var tt = t;
			t = t2;
			t2 = tt;
		}
//		trace("sharedT: [" + t  + " : " + t2 + "]");
//	    var c1 = 0xff3030;
//		var c2 = 0x90a030;
		while (t < t2) {
			var xRangeA = new Range(tra.getX(t) - unitRadius.value, tra.getX(t) + unitRadius.value);
//			trace("xRangeA: " + xRangeA);

			var y = tra.getY(t);
//			debugRenderer.drawRect(new Rect(xRangeA.t1, y + unitRadius.value, xRangeA.t2, y - unitRadius.value), c1, 2);

			var xRangeB = new Range(trb.getX(t) - unitRadius.value, trb.getX(t) + unitRadius.value);
//			trace("xRangeB: " + xRangeB);

			y = trb.getY(t);
//			debugRenderer.drawRect(new Rect(xRangeB.t1, y + unitRadius.value, xRangeB.t2, y - unitRadius.value),c2 , 2);

			var sharedX = xRangeA.cross(xRangeB);

//			trace("sharedX: " + sharedX);

			if (sharedX != null) {
//				debugRenderer.drawRect(new Rect(sharedX.t1, y + unitRadius.value, sharedX.t2, y - unitRadius.value), 0x90a030, 2);
				return true;
			}
//			c1 -=6;
//			c2-=6;
			t += timeStep;
		}
		return false;
	}
}