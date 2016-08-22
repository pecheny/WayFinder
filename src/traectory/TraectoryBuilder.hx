package traectory;
interface TraectoryBuilder {
	function init(t:Float, odd:Bool):Void;
	function roll():Traectory;
}