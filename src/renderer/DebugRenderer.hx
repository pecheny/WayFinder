package renderer;
import math.Rect;
interface DebugRenderer {
	function clear():Void;
	function drawRect(rect:Rect, ?color:UInt = 0x909090, ?thk:Float = 1):Void ;
	function drawLine(x1:Float, y1:Float, x2:Float, y2:Float, ?thk:Float, ?color:UInt):Void;
	function drawCircle(x:Float, y:Float, r:Float):Void ;
}