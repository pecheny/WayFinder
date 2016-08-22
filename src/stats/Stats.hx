package stats;
class Stats {
	@inject public var statsRenderer:StatsRenderer;

	public function new() {
	}
	public var totalNumObjects(default, set):Int;

	function set_totalNumObjects(val:Int) {
		statsRenderer.setTotalNumObjects(val);
		return totalNumObjects = val;
	}

	public var currentNumObjects(default, set):Int;

	function set_currentNumObjects(val:Int) {
		statsRenderer.setCurrentNumObjects(val);
		return currentNumObjects = val;
	}

	public var objectHits(default, set):Int;

	function set_objectHits(val:Int) {
		statsRenderer.setObjectHits(val);
		return objectHits = val;
	}
	public var searchIterations(default, set):Int;

	function set_searchIterations(val:Int) {
		statsRenderer.setSearchIterations(val);
		return searchIterations = val;
	}
	public var searchesFailedCount(default, set):Int;

	function set_searchesFailedCount(val:Int) {
		statsRenderer.setFailedSearchesCount(val);
		return searchesFailedCount = val;
	}

	public var delay(default, set):Float;

	function set_delay(val:Float) {
		statsRenderer.setDelay(val);
		return delay = val;
	}
}