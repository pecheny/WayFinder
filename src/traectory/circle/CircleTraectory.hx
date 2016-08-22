package traectory.circle;
import math.Range;
class CircleTraectory implements Traectory {
	public var period:Range;
	public var centerX:Float;
	public var centerY:Float;
	public var startAngle:Float;
	public var angularSpeed:Float;
	public var radius:Float;

	public function new(x0:Float, y0:Float, radius:Float, angularSpeed:Float, startAngle:Float, period:Range) {
		centerX = x0;
		centerY = y0;
		this.radius = radius;
		this.startAngle = startAngle;
		this.angularSpeed = angularSpeed;
		this.period = period;
	}

	public function getX(t:Float):Float {
		var angle = startAngle + (t - period.t1) * angularSpeed;
		return centerX + radius * Math.sin(angle);
	}

	public function getY(t:Float):Float {
		var angle = startAngle + (t - period.t1) * angularSpeed;
//		trace("a " + angle + " " + (Math.acos(Math.cos(angle))));

		return centerY + radius * Math.cos(angle);
	}

	public function getTbyY(y:Float):Float {
		var angle:Float =
		if (y > centerY)
			2 * Math.PI - Math.acos((y - centerY) / radius) - startAngle
		else
			Math.PI + Math.acos((centerY - y) / radius) - startAngle;


//		trace("ang " + angle);
		return (angle / angularSpeed) + period.t1;
	}

	public function toString():String {
		return "Circle : (  " + centerX + ", " + centerY + ", " + radius + ", " + angularSpeed + ", " + startAngle + ", " + period + " ]";
	}
}