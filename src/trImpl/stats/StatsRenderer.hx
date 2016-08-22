package trImpl.stats;
import flash.text.TextField;
import openfl.display.Sprite;
class StatsRenderer extends Sprite {
	var searchIterations:TextField;
	var searchesFailedCount:TextField;
	var objectHits:TextField;
	var totalNumObjects:TextField;
	var currentNumObjects:TextField;
	var delay:TextField;

	public function new() {
		super();
		createLabel("«+/-»   – Увеличить/ уменьшить задержку между попытками запуска");
		createLabel("«p»   – Пауза");
		createLabel("«r»   – Перезапуск");
		searchIterations = createLabel();
		searchesFailedCount = createLabel();
		objectHits = createLabel();
		totalNumObjects = createLabel();
		currentNumObjects = createLabel();
		delay = createLabel();
		setSearchIterations(0);
		setFailedSearchesCount(0);
		setObjectHits(0);
		setTotalNumObjects(0);
		setCurrentNumObjects(0);
		setDelay(0);
	}

	var mheight:Float = 20;

	private function createLabel(?initialText:String = ""):TextField {
		var tf = new TextField();
		tf.text = initialText;
		tf.y = mheight - 10;
		tf.x = 10;
		tf.width = 200;
		tf.textColor = 0xffffff;
		mheight += 16;
		updateBg();
		addChild(tf);
		return tf;
	}

	private function updateBg():Void {
		graphics.clear();
		graphics.beginFill(0, 0.7);
		graphics.drawRect(0, 0, 220, mheight);
		graphics.endFill();
	}

	public function setSearchIterations(v:Int):Void {
		searchIterations.text = "" + v + " итераций поиска" ;
	}

	public function setFailedSearchesCount(v:Int):Void {
		searchesFailedCount.text = "" + v + " раз не удалось найти путь" ;
	}

	public function setObjectHits(v:Int):Void {
		objectHits.text = "" + v + " объектов столкнулось" ;
	}

	public function setTotalNumObjects(v:Int):Void {
		totalNumObjects.text = "" + v + " объектов запущено" ;
	}

	public function setCurrentNumObjects(v:Int):Void {
		currentNumObjects.text = "" + v + " активных объектов" ;
	}

	public function setDelay(v:Float):Void {
		delay.text = "" + v + " задержка между попытками" ;
	}

}