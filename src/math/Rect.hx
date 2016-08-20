package math;
class Rect {
	public var x0:Float;
	public var x1:Float;
	public var y0:Float;
	public var y1:Float;

	public function new(x0:Float, y0:Float, x1:Float,  y1:Float) {
		this.x0 = x0;
		this.x1 = x1;
		this.y0 = y0;
		this.y1 = y1;
	}

	public function width():Float {
		return x1 - x0;
	}

	public function height():Float {
		return y1 - y0;
	}

//	public function toString():String {
//	return x0  + " " +
//	}
}