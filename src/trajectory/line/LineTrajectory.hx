package trajectory.line;
import math.Range;
class LineTrajectory implements Trajectory {
	public var period:Range;
	public var startX:Float;
	public var startY:Float;
	public var speedX:Float;
	public var speedY:Float;

	public function new(x0:Float, y0:Float, speedX:Float, speedY:Float, period:Range) {
		startX = x0;
		startY = y0;
		this.speedX = speedX;
		this.speedY = speedY;
		this.period = period;
	}

	public function getX(t:Float):Float {
		return startX + (t - period.t1) * speedX;
	}

	public function getY(t:Float):Float {
		return startY + (t - period.t1) * speedY;
	}

	public function getTbyY(y:Float):Float {
		return period.t1 + (y - startY) / speedY;
	}

	public function toString():String {
		return "Line : (  " + startX  + ", " + startY  + ", " + speedX  + ", " + speedY  + ", " + period  + " ]";
	}

}