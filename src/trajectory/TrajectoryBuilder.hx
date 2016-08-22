package trajectory;
/**
* Содержит логику создания и варьирования траекторий.
**/
interface TrajectoryBuilder {
/**
* Инициализирует начальные условия для генерации траектории.
* @param t время появления
* @param odd определяет сверуху или снизу летит объект
**/
	function init(t:Float, odd:Bool):Void;
	function roll():Trajectory;
}