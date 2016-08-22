package openfl;
import impl.World;
import data.UnitRadius;
import renderer.ItemRenderer;
import openfl.display.Sprite;
class CircleRenderer extends Sprite implements ItemRenderer {
	@inject public var unitRadius:UnitRadius;
	@inject public var world:World;

	public function new() {
		super();
	}

	public function render(x:Float, y:Float):Void {
		graphics.beginFill(0xd09090);
		graphics.drawCircle(x, y, unitRadius.value);
		graphics.endFill();
	}

	public function clear():Void {
		graphics.clear();
	}

	public function update(t:Float):Void {
		clear();
		for (tr in world.trajectories) {
			render(tr.getX(t), tr.getY(t));
		}

	}
}