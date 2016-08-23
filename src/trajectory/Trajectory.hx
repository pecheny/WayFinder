package trajectory;
import math.Range;
interface Trajectory {
	/**
	* Время существования объекта (с момента генерации до выхода за границы экрана).
	**/
	var period:Range;
	/**
	* Функция определяющая зависимость х-координаты от времени.
	**/
	function getX(t:Float):Float;
	/**
	* Функция определяющая зависимость у-координаты от времени.
	**/
	function getY(t:Float):Float;
	/**
	* Функция обратная  getY(), getTbyY(getY(t)) должна возращать значение, близкое к t в пределах погрешности.
	**/
	function getTbyY(y:Float):Float;
}
