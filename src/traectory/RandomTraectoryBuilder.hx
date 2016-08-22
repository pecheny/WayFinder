package traectory;
class RandomTraectoryBuilder implements TraectoryBuilder {
	public function new() {	}
	var current:TraectoryBuilder;
	var traectoryBuilders:Array<TraectoryBuilder> = [];

	public function addBuilder(traectoryBuilder:TraectoryBuilder):Void {
		traectoryBuilders.push(traectoryBuilder);
	}

	public function init(t:Float, odd:Bool):Void {
		if (traectoryBuilders.length == 0) {
			throw "RandomTraectoryBuilder requires at least one builder been added.";
		}
		current = traectoryBuilders[Std.random(traectoryBuilders.length)];
		current.init(t, odd);
	}

	public function roll():Traectory {
		return current.roll();
	}
}