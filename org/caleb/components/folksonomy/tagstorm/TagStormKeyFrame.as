import org.caleb.movieclip.ObservableMovieClip;
import flash.display.BitmapData;
import org.caleb.animation.AnimationManager;
class org.caleb.components.folksonomy.tagstorm.TagStormKeyFrame extends ObservableMovieClip {
	private var $maxscale:Number;
	private var $minscale:Number;
	
	private var $minalpha:Number;
	private var $maxalpha:Number;
	
	private var $minfontsize:Number;
	private var $maxfontsize:Number;
	
	private var $videoholder:MovieClip;
	private var $textholder:MovieClip;
	private var $tw:AnimationManager;
	private var $timethreshold:Number;
	
	private var $currentvalue:Number;
	private var $scrubberval:Number;
	private var $scrubbablewidth:Number;
	
	private var $start:Number;
	private var $end:Number;
	private var $mid:Number;
	
	private var $value:Number;
	private var $maxval:Number;
	private var $tags:String;
	
	private var $mode:String;
	static var TEXT_TAG:String = 'text';
	static var VIDEO_TAG:String = 'video';
	static var BUFFER:Number = 30;
	
	private var $si:Number;
	
	public function TagStormKeyFrame() {
		this.$tw = new AnimationManager(this);
		this.$videoholder = this.createEmptyMovieClip('$videoholder', this.getNextHighestDepth());
		this.$textholder = this.createEmptyMovieClip('$textholder', this.getNextHighestDepth());
	}
	public function setBitmap(bm:BitmapData):Void {
		this.$videoholder.attachBitmap(bm, this.$videoholder.getNextHighestDepth(), 'false', true);
		this.$videoholder._x = -this.$videoholder._width/2;
		this.$videoholder._y = -this.$videoholder._height/2;
		this._xscale = this._yscale = 1;
		this._alpha = 0;
		this.$currentvalue = 0;
	}

	public function set tags(arg:String) {
		this.$tags = arg;
		this.$textholder.createTextField('$text', this.$textholder.getNextHighestDepth(), 0, 0, 200, 200);
		this.$textholder.$text.embedFonts = true;
		this.$textholder.$text.text = this.$tags;
		this.$textholder.$text.autoSize = true;
		this.$textholder.$text.selectable = false;
		this.$textholder._y = -this.$textholder._height/2;
		var fmt:TextFormat = new TextFormat();
		fmt.color = 0xDDDDDD;
		fmt.font = 'gotham';
		fmt.align = 'center';
		fmt.size = this.$minfontsize + ((this.$maxfontsize-this.$minfontsize) * (this.$value/this.$maxval));
		this.$textholder.$text.setTextFormat(fmt);
	}
	
	
	public function set mode(arg:String) {
		this.$mode = arg;
		if (this.$mode == TEXT_TAG) {
			//trace('setting as text.');
			this.$textholder._visible = true;
			this.$videoholder._visible = false;
		} else {
			//trace('setting as video.');
			this.$textholder._visible = false;
			this.$videoholder._visible = true;
		}
	}
	
	public function set maxscale(arg:Number) {
		this.$maxscale = arg;
	}
	public function set minscale(arg:Number) {
		this.$minscale = arg;
	}
	
	public function set maxalpha(arg:Number) {
		this.$maxalpha = arg;
	}
	public function get maxalpha():Number {
		return this.$maxalpha;
	}
	
	
	public function set minalpha(arg:Number) {
		this.$minalpha = arg;
	}
	public function get minalpha():Number {
		return this.$minalpha;
	}
	
	public function set minfontsize(arg:Number) {
		this.$minfontsize = arg;
	}
	public function set maxfontsize(arg:Number) {
		this.$maxfontsize = arg;
	}
	

	public function set start(arg:Number) {
		this.$start = arg;
	}
	
	
	public function set end(arg:Number) {
		this.$end = arg;
		var dis:Number = Number(this.$end - this.$start);
		var halfdis:Number = Number(dis/2);
		this.$mid = Number(this.$start) + Number(halfdis);
	}
	
	public function set value(arg:Number) {
		this.$value = arg;
	}
	
	public function set maxval(arg:Number) {
		this.$maxval = arg;
	}
	
	public function set timethreshold(arg:Number) {
		this.$timethreshold = arg;
	}
	public function set scrubposition(arg:Number) {
		if (!this.$si) {
			clearInterval(this.$si);
			this.$si = setInterval(this, '$draw', 100);
		}
		
		this.$scrubberval = arg;
	}
	public function set scrubbablewidth(arg:Number) {
		this.$scrubbablewidth = arg;
	}	
	
	private function $draw(Void):Void {
		var norm = this.$value / this.$maxval;
		var dis = Math.abs((this.$scrubberval - this.$mid));
		//trace('s:'+this.$scrubberval+' m:'+this.$mid+' ='+(Number(this.$scrubberval) - Number(this.$mid)));
		
		//trace(this.$tags+': dis:'+dis+' sv:'+this.$scrubberval+' mid:'+this.$mid);
		
		
		 if (dis < this.$timethreshold){
			//i should be scaling at a sinusoidal rate to my max rate.
			var v = (this.$timethreshold - dis) / this.$timethreshold;
			var rad = 1 - Math.cos((Math.PI/2) * v);
			//trace(this.$tags+' : '+v+' : '+rad);
			//i should be at home, at minimum scale/opacity
			
			var st = (this.$start * this.$scrubbablewidth);
			var end = (this.$scrubberval * this.$scrubbablewidth);
			
			var xdiff = (((end - st) * rad) + st) - this._x;
			//var xdiff = (this.$start * this.$scrubbablewidth) - this._x;	
			var xdel = xdiff * .2;	
			
			
			var desscale = this.$minscale + (this.$maxscale - this.$minscale)*rad;
			var desalpha = this.$minalpha + (this.$maxalpha - this.$minalpha)*rad;
			//Handling inner justification
			if (this.$scrubberval >= 0 && this.$scrubberval <.3) {
				//quad one. move offset to the right.
				//var xoffset = this.$textholder._x;
				var xoffset = BUFFER - this.$textholder._x;
				var xoffsetdiff = xoffset * .5;
				
				var xvidoffset = BUFFER - this.$videoholder._x;
				var xvidoffsetdiff = xvidoffset * .5;
				
			} else if (this.$scrubberval >= .6 && this.$scrubberval <= 1) {
				//quad three. move offset to the left.
				var xoffset = -this.$textholder._width - BUFFER - this.$textholder._x;
				var xoffsetdiff = xoffset * .5;
				
				var xvidoffset = -this.$videoholder.width - BUFFER - this.$videoholder._x;
				var xvidoffsetdiff = xvidoffset * .5;
				
			} 
			
			
		} else {
			//i should be at home, at minimum scale/opacity
			var xdiff = (this.$start * this.$scrubbablewidth) - this._x;	
			var xdel = xdiff * .2;
			
			var desscale = this.$minscale;
			var desalpha = this.$minalpha;
			
		}
		
		
		
		
		
		var scalediff = (desscale - this._xscale);
		var scaledel = scalediff * .5;
		
		var alphadiff = (desalpha - this._alpha);
		var alphadel = alphadiff * .5;
		
		//Physically update.		
		this._alpha += alphadel;
		this._x += xdel;
		this._xscale = this._yscale += scaledel;
		this.$textholder._x += xoffsetdiff;
		this.$videoholder._x += xvidoffsetdiff;
		
		
	}	
	
}