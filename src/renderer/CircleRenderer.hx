package renderer;
import trImpl.UnitRadius;
import renderer.Renderer;
import openfl.display.Sprite;
class CircleRenderer extends Sprite implements Renderer {
	@inject public var unitRadius:UnitRadius;

	public function new() {
		super();
	}

	public function render(x:Float, y:Float):Void {
		graphics.beginFill(0x902020);
		graphics.drawCircle(x, y, unitRadius.value);
		graphics.endFill();
	}

	public function clear():Void {
		graphics.clear();
	}
}