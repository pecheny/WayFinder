package trImpl;
import traectory.Traectory;
class World {
	var traectories:List<Traectory> = new List<Traectory>();
	@inject public var traectoryResolver:TraectoryResolver;

	public function new() {
	}

	public function add(tr:Traectory) {
		traectories.add(tr);
	}

	public function remove(tr:Traectory) {
		traectories.remove(tr);
	}

	public function isValid(tr:Traectory):Bool {
		for (other in traectories) {
			if (traectoryResolver.cross(tr, other)) {
				return false;
			}
		}
		return true;
	}

	public function update(t:Float):Void {
		for(tr in traectories) {
			if (tr.period.max()<t) {
				remove(tr);
				continue;
			}
		}
	}


}