package traectory;
import math.Range;
interface Traectory {
	var period:Range;
	function getX(t:Float):Float;
	function getY(t:Float):Float;
}