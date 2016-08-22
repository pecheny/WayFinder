package renderer;
import math.Rect;
import openfl.display.Sprite;
class DebugRenderer extends Sprite {
	public function new() {
		super();
	}


	public function clear():Void {
		graphics.clear();
	}

	public function drawRect(rect:Rect, ?color = 0x909090, ?thk = 1):Void {
		graphics.lineStyle(thk, color);
		graphics.drawRect(rect.x0, rect.y0, rect.width(), rect.height());
	}

	public function drawLine(x1:Float,  y1:Float, x2:Float, y2:Float, ?thk:Float, ?color):Void {
		if (thk == null) thk = 1;
		if (color == null) color = 0x707070;
		graphics.lineStyle(thk, color);
		graphics.moveTo(x1, y1);
		graphics.lineTo(x2, y2);
	}

	public function drawCircle(x:Float, y:Float, r:Float):Void {
		graphics.lineStyle(1, 0x908050);
		graphics.drawCircle(x, y, r);
	}

}