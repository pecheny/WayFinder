package traectory.line;
import data.Speed;
import math.Range;
import math.Rect;
class LineBuilder implements TraectoryBuilder{
	public function new() {
	}

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
	public function roll():Traectory {
		x1 = worldRect.x0 + Math.random() * worldRect.width();
		x2 = clamp(x1 + Math.random() * (bias) - bias / 2, worldRect.x0, worldRect.x1);
		return buildLine(x1,x2,t,worldRect,speed.value,odd);
	}



	public static inline function buildLine(x1:Float,x2:Float, t0:Float, worldRect:Rect,s:Float,odd:Bool):Traectory {
		var xSign = x1 > x2 ? -1 : 1;
		var ySign = odd ? 1 : -1;
		var dx = x2 - x1;
		var dy = worldRect.height();
		var dxSq = dx * dx;
		var dySq = dy * dy;

		var sySq = (s * s * dySq) / (dySq + dxSq);
		var sxSq = s * s - sySq;

		var pathLen = Math.sqrt(dxSq + dySq);
		var period = new Range(t0, t0 + pathLen / s);

		var line = new LineTraectory(x1, odd ? worldRect.y0 : worldRect.y1, xSign * Math.sqrt(sxSq), ySign * Math.sqrt(sySq), period);

		return line;
	}

	// в реальном проекте наверняка найдется более подходяще место, но до тех пор,
	// пока употребление единично и нет дублирования кода, я считаю допустимым не мусорить дополнительными утилитными классами
	public inline static function clamp(value:Float, min:Float, max:Float):Float
		{
		    if (value < min)
		        return min;
		    else if (value > max)
		        return max;
		    else
		        return value;
		}

}