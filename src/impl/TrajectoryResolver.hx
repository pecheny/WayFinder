package impl;
import renderer.DebugRenderer;
import data.Speed;
import data.UnitRadius;
import math.Range;
import trajectory.Trajectory;
/**
* Определяет, столкнутся ли 2 объекта, летящие по заданным траекториям.
* Для корректной работы требуется, чтобы движение вдоль y-компонента скорости не меняла знак.
**/
class TrajectoryResolver {
	@inject public var unitRadius:UnitRadius;
	@inject public var speed:Speed;
	@inject public var debugRenderer:DebugRenderer;

	var timeStep:Float;

	public function new() {
	}

	@post public function init():Void {
		timeStep =  unitRadius.value / speed.value;
	}

	public function cross(tra:Trajectory, trb:Trajectory):Bool {
		var sharedTime = tra.period.cross(trb.period);
		if (sharedTime == null) return false;
//      предположим, что направление вдоль y не может меняться (не будем ориентироваться на синусоиды с уклоном оси более 45)
		var yRangeA = new Range(tra.getY(sharedTime.t1), tra.getY(sharedTime.t2));
		yRangeA.t1 -= unitRadius.value;
		yRangeA.t2 += unitRadius.value;
		var yRangeB = new Range(trb.getY(sharedTime.t1), trb.getY(sharedTime.t2));
		yRangeB.t1 -= unitRadius.value;
		yRangeB.t2 += unitRadius.value;
		var sharedY = yRangeA.cross(yRangeB);

		if (sharedY == null) return false;
		var t = tra.getTbyY(sharedY.t2);
		var t2 = tra.getTbyY(sharedY.t1);
		if (t>t2) {
			var tt = t;
			t = t2;
			t2 = tt;
		}
		var i = 0;
		while (t < t2) {
			var xRangeA = new Range(tra.getX(t) - unitRadius.value, tra.getX(t) + unitRadius.value);
			var y = tra.getY(t);
			var xRangeB = new Range(trb.getX(t) - unitRadius.value, trb.getX(t) + unitRadius.value);
			var sharedX = xRangeA.cross(xRangeB);
			if (sharedX != null) {
				return true;
			}
			t += timeStep;
		}
		return false;
	}
}