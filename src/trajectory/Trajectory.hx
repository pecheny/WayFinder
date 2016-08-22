package trajectory;
import math.Range;
interface Trajectory {
/**
* Время существования объекта (с момента генерации до выхода за границы экрана).
**/
	var period:Range;
	function getX(t:Float):Float;
	function getY(t:Float):Float;
	function getTbyY(y:Float):Float;
}