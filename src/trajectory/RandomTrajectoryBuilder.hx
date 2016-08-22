package trajectory;
class RandomTrajectoryBuilder implements TrajectoryBuilder {
	public function new() {	}
	var current:TrajectoryBuilder;
	var trajectoryBuilders:Array<TrajectoryBuilder> = [];

	public function addBuilder(trajectoryBuilder:TrajectoryBuilder):Void {
		trajectoryBuilders.push(trajectoryBuilder);
	}

	public function init(t:Float, odd:Bool):Void {
		if (trajectoryBuilders.length == 0) {
			throw "RandomTraectoryBuilder requires at least one builder been added.";
		}
		current = trajectoryBuilders[Std.random(trajectoryBuilders.length)];
		current.init(t, odd);
	}

	public function roll():Trajectory {
		return current.roll();
	}
}