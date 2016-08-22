package impl;
import trajectory.TrajectoryBuilder;
import info.Stats;
import trajectory.Trajectory;
class TrajectorySpawner {
	@inject public var world:World;
	@inject public var trajectoryBuilder:TrajectoryBuilder;
	@inject public var stats:Stats;

	inline static var SEARCH_ITER_LIMIT:Int = 50;

	public function new() {
	}

	var odd:Bool;

	public function choose(t:Float):Null<Trajectory> {
		trajectoryBuilder.init(t, odd);
		var i = 0;
		var tr = trajectoryBuilder.roll();
		while (!world.isValid(tr)) {
			i++;
			if (i > SEARCH_ITER_LIMIT) {
				stats.searchesFailedCount++;
				return null;
			}
			tr = trajectoryBuilder.roll();
		}
		stats.searchIterations = i;
		odd = !odd;
		return tr;
	}
}