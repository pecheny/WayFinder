package trImpl;
import traectory.LineBuilder;
import traectory.Traectory;
class TraectoryChooser {
@inject public var world:World;
@inject public var lineBuilder:LineBuilder;
	public function new() {
	}


	public function choose(t:Float):Traectory {
		lineBuilder.init(t);
		var tr = lineBuilder.roll();
		while (!world.isValid(tr)) {
			tr = lineBuilder.roll();
		}
	     return tr;
	}
}