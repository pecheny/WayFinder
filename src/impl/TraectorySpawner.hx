package impl;
import traectory.TraectoryBuilder;
import stats.Stats;
import traectory.Traectory;
class TraectorySpawner {
	@inject public var world:World;
	@inject public var traectoryBuilder:TraectoryBuilder;
	@inject public var stats:Stats;

	inline static var SEARCH_ITER_LIMIT:Int = 50;

	public function new() {
	}

	var odd:Bool;

	public function choose(t:Float):Null<Traectory> {
		traectoryBuilder.init(t, odd);
		var i = 0;
		var tr = traectoryBuilder.roll();
		while (!world.isValid(tr)) {
			i++;
			if (i > SEARCH_ITER_LIMIT) {
				stats.searchesFailedCount++;
				return null;
			}
			tr = traectoryBuilder.roll();
		}
		stats.searchIterations = i;
		odd = !odd;
		return tr;
	}
}