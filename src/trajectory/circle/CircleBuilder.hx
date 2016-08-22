package trajectory.circle;
import math.Range;
import math.Rect;
import data.Speed;
class CircleBuilder implements TrajectoryBuilder {
	public function new() { }
	@inject public var worldRect:Rect;
	@inject public var speed:Speed;

	var t:Float;
	var x1:Float;
	var x2:Float;
	var odd:Bool;

	public function init(t:Float, odd:Bool):Void {
		this.t = t;
		this.odd = odd;
	}


	var bias:Float = 150;

	public function roll():Trajectory {
		var r = worldRect.width();
		var diagAng = Math.asin(worldRect.height() / r);
		var horOffsetLimit = r - r * Math.cos(diagAng);
		var xMin = worldRect.x0 + r;// + horOffsetLimit;
		var xMax = worldRect.x0 + 2 * r - horOffsetLimit;
		var x0 = xMin + Math.random() * (xMax - xMin);
		var y0 = worldRect.y0 + Math.random() * worldRect.height();
		var speedSign = odd ? 1 : -1;
		var angSpeed = speedSign * speed.value / r;
		var period = new Range(t, t + 10);
		var yInWorldRectSpace = y0 - worldRect.y0;

//		trace("odd " + (Math.PI + Math.acos((yInWorldRectSpace) / r)));
//		trace("even " + ((Math.PI * 3 / 2) + Math.asin((worldRect.height() - yInWorldRectSpace) / r)));
		var startAngle = odd ?
		Math.PI + Math.acos((yInWorldRectSpace) / r) :
		(Math.PI * 3 / 2) + Math.asin( (worldRect.height() - yInWorldRectSpace) / r);
//		trace(startAngle);

		var tr = new CircleTrajectory(x0, y0, r, angSpeed, startAngle, period);
		tr.period.t2 = odd ?
		tr.getTbyY(worldRect.y1):
		tr.getTbyY(worldRect.y0);
		return tr;
	}
}