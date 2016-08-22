package impl;
import stats.Stats;
import traectory.Traectory;
/*
	хранит состояние всех живых объектов, следит за утилизацией, проверяет, насколько вписывается новая траектория в комплект уже имеющихся.
	если делать совсем солид-солид, то это бали бы: 1) модель-хранилище без логики, 2) валидатор и 3) утилизатор. но фанатизм никогда до добра не доводит, т.ч.
	вспомним немного и о kiss/yagni.
 */
class World {
	public var traectories:Array<Traectory> = new Array<Traectory>();
	@inject public var traectoryResolver:TraectoryResolver;
	@inject public var stats:Stats;

	public function new() {
	}

	public function add(tr:Traectory) {
		traectories.push(tr);
		stats.currentNumObjects = traectories.length;
		stats.totalNumObjects++;
	}

	public function remove(tr:Traectory) {
		traectories.remove(tr);
		stats.currentNumObjects = traectories.length;

	}

	public function reset():Void {
		traectories = [];
	}

	public function isValid(tr:Traectory):Bool {
		for (other in traectories) {
			if (traectoryResolver.cross(tr, other)) {
//				trace("cross A: " + tr);
//				trace("cross B: " + other);
				return false;
			}
		}
//		trace("doesn't cross");
		return true;
	}

	public function update(t:Float):Void {
		for (tr in traectories) {
			if (tr.period.max() < t) {
				remove(tr);
				continue;
			}
		}
	}


}