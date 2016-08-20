package math;
class Range {
	public var t1:Float;
	public var t2:Float;

	public function new(t1:Float, t2:Float) {
		this.t1 = t1;
		this.t2 = t2;
	}

	public function min():Float {
		return Math.min(t1, t2);
	}

	public function max():Float {
		return Math.max(t1, t2);
	}

	public function cross(other:Range) {
		var min = Math.max(this.min(), other.min());
		var max = Math.min(this.max(), other.max());
		if (min > max) return null;
		return new Range(min, max);
	}
}