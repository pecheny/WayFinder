package renderer;
import math.Rect;
import openfl.display.Sprite;
class CommonRenderer extends Sprite {
	public function new() {
		super();
	}

	public function drawRect(rect:Rect):Void {
		graphics.lineStyle(1, 0x909090);
		graphics.drawRect(rect.x0, rect.y0,  rect.width(), rect.height());
	}

	public function drawLine(x1:Float, x2:Float, y1:Float, y2:Float):Void {
		graphics.lineStyle(1, 0x909090);
		graphics.moveTo(x1, y1);
		graphics.lineTo(x2, y2);
	}

}