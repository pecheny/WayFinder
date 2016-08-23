package impl;
import info.Stats;
import trajectory.Trajectory;
/*
	хранит состояние всех живых объектов, следит за утилизацией, проверяет, насколько вписывается новая траектория в комплект уже имеющихся.
	если делать совсем солид-солид, то это бали бы: 1) модель-хранилище без логики, 2) валидатор и 3) утилизатор. но фанатизм никогда до добра не доводит, т.ч.
	вспомним немного и о kiss/yagni.
 */
class World {
	public var trajectories:Array<Trajectory> = new Array<Trajectory>();
	@inject public var traectoryResolver:TrajectoryResolver;
	@inject public var stats:Stats;

	public function new() {
	}

	public function add(tr:Trajectory) {
		trajectories.push(tr);
		stats.currentNumObjects = trajectories.length;
		stats.totalNumObjects++;
	}

	public function remove(tr:Trajectory) {
		trajectories.remove(tr);
		stats.currentNumObjects = trajectories.length;

	}

	public function reset():Void {
		trajectories = [];
	}

	public function isValid(tr:Trajectory):Bool {
		for (other in trajectories) {
			if (traectoryResolver.cross(tr, other)) {
				return false;
			}
		}
		return true;
	}

	public function update(t:Float):Void {
		for (tr in trajectories) {
			if (tr.period.max() < t) {
				remove(tr);
				continue;
			}
		}
	}


}