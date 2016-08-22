package info;
interface StatsRenderer {
	function setSearchIterations(v:Int):Void;
	function setFailedSearchesCount(v:Int):Void;
	function setObjectHits(v:Int):Void ;
	function setTotalNumObjects(v:Int):Void;
	function setCurrentNumObjects(v:Int):Void;
	function setDelay(v:Float):Void ;
}