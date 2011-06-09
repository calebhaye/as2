import flash.geom.Point;
import flash.geom.Matrix;
import flash.display.BitmapData;

class org.caleb.components.drawing.MarchingAnts extends MovieClip
{
	public static var SymbolName:String = '__Packages.org.caleb.components.drawing.MarchingAnts';
	public static var SymbolLinked = Object.registerClass(SymbolName, MarchingAnts);
	
	var startPoint:Point;
	var endPoint:Point;
	// define a matrix to control the shifting of
	// the ants pattern when its drawn
	private var $shift:Matrix;

	private var $marquee:MovieClip;
	private var $updateInterval:Number;
	private var $antsbmp:BitmapData;

	
	public function MarchingAnts()
	{
		Stage.scaleMode = 'noScale';
		// create a movie clip to contain the marquee
		this.$marquee = this.createEmptyMovieClip("this.$marquee", 1);
		this.$shift = new flash.geom.Matrix;
		// load the ants bitmap into BitmapData instance
		// named antsbmp.  All this is, is a pattern
		// of diagonal black and white lines
		this.$antsbmp = flash.display.BitmapData.loadBitmap("ants");
		
		//startPoint = new Point(10, 100);
		//endPoint = new Point(200, 200);
		this.$updateInterval = setInterval(this, 'updateAnts', 30);
	}

	// constantly update the marquee
	private function updateAnts()
	{
		// trace('update ants')
		// shift the matrix used for the ants down by 
		// a value of one - this makes them march
		this.$shift.translate(0, 1);
		// the marquee is dynamically drawn into this.$marquee
		// with the ants as a bitmap fill
		// clear this.$marquee each frame to update
		this.$marquee.clear();
		// start a bitmap fill with the ants
		// using the shift matrix to offset their position
		this.$marquee.beginBitmapFill(this.$antsbmp, this.$shift);
		// draw two squares to make a 1 pix thick hollow square
		// that will contain the marquee. Draw around
		// startPoint and endPoint
		
		drawSquare(this.$marquee, startPoint.x, startPoint.y, endPoint.x, endPoint.y);
		drawSquare(this.$marquee, startPoint.x+1, startPoint.y+1, endPoint.x-1, endPoint.y-1);
		// end the fill
		this.$marquee.endFill();
	}

	// method for drawing a square in target
	function drawSquare(target, x1, y1, x2, y2){
		target.moveTo(x1, y1);
		target.lineTo(x2, y1);
		target.lineTo(x2, y2);
		target.lineTo(x1, y2);
		target.lineTo(x1, y1);
	}
}