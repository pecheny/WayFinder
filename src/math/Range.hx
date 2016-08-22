package math;
class Range {
	public var t1:Float;
	public var t2:Float;

	public inline function new(t1:Float, t2:Float) {
		this.t1 = t1;
		this.t2 = t2;
	}

	public inline function min():Float {
		return Math.min(t1, t2);
	}

	public inline function max():Float {
		return Math.max(t1, t2);
	}

	public inline function cross(other:Range):Null<Range> {
		var min = Math.max(this.min(), other.min());
		var max = Math.min(this.max(), other.max());
		if (min > max) return null;
		return new Range(min, max);
	}

	public inline function toString():String {
		return "new Range (" + t1  + ", " + t2  + ")";
	}
}