package traectory;
import renderer.CommonRenderer;
import math.Range;
import math.Rect;
class LineBuilder {
	public function new() {
	}

	@inject public var worldRect:Rect;
	@inject public var commonRenderer:CommonRenderer;
	var s = 100;

	var t:Float;
	var x1:Float;
	var x2:Float;
	var odd:Bool;

	public function init(t:Float, odd:Bool):Void {
//		x1 = Math.random() * worldRect.width();
//		x2 = Math.random() * (worldRect.width());
		this.t = t;
		this.odd = odd;
	}


	public function roll():Traectory {
		x1 = Math.random() * worldRect.width();
		x2 = Math.random() * (worldRect.width());

		var xSign = x1 > x2 ? -1 : 1;
		var ySign = odd ? 1 : -1;
		var dx = x2 - x1;
		var dy = worldRect.height();
		var dxSq = dx * dx;
		var dySq = dy * dy;

		var sySq = (s * s * dySq) / (dySq + dxSq);
		var sxSq = s * s - sySq;

		var pathLen = Math.sqrt(dxSq + dySq);
		var period = new Range(t, t + pathLen / s);

		var line = new LineTraectory(x1, worldRect.y0, xSign * Math.sqrt(sxSq), ySign * Math.sqrt(sySq), period);

		trace(line.getX(period.t2) + " " + line.getY(period.t2));
		drawLine(x1, x2);

		return line;
	}

	public function drawLine(x1:Float, x2:Float):Void {
		if (odd) {
			commonRenderer.drawLine(x1, x2, worldRect.y0, worldRect.y1);
		} else {
			commonRenderer.drawLine(x1, x2, worldRect.y1, worldRect.y0);
		}
	}
}