package trImpl;
import trImpl.stats.Stats;
import traectory.LineBuilder;
import traectory.Traectory;
class TraectorySpawner {
	@inject public var world:World;
	@inject public var lineBuilder:LineBuilder;
	@inject public var stats:Stats;

	inline static var SEARCH_ITER_LIMIT:Int = 50;

	public function new() {
	}

	var odd:Bool;

	public function choose(t:Float):Null<Traectory> {
		lineBuilder.init(t, odd);
		var i = 0;
		var tr = lineBuilder.roll();
		while (!world.isValid(tr)) {
			i++;
			if (i > SEARCH_ITER_LIMIT) {
				stats.searchesFailedCount++;
				return null;
			}
			tr = lineBuilder.roll();
		}
		stats.searchIterations = i;
		odd = !odd;
		return tr;
	}
}