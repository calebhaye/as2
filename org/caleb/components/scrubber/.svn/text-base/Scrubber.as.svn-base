import org.caleb.movieclip.ObservableMovieClip;
class org.caleb.components.scrubber.Scrubber extends ObservableMovieClip {
	private var $width:Number;
	private var $height:Number;
	private var $totalwidth:Number;
	private var $scrubbablewidth:Number;
	
	private var onRelease:Function;
	private var onReleaseOutside:Function;
	private var onPress:Function;	
	
	public function Scrubber() {
		
	}
	
	public function init(Void):Void {
		this.unlock();
	}	
	
	/**
	* Accessor for private $width var.
	* @return Number.
	**/
	
	public function get width():Number{
		return this.$width;
	}
	/**
	* Mutator for private $width var.
	* @param arg Number
	**/
	
	public function set width(arg:Number) {
		this._width = arg;
		this.$width = arg;
	}
	
	/**
	* Accessor for private $height var.
	* @return Number.
	**/
	
	public function get height():Number{
		return this.$height;
	}
	/**
	* Mutator for private $height var.
	* @param arg Number
	**/
	
	public function set height(arg:Number) {
		this._height = arg;
		this.$height = arg;
	}
	
	/**
	* Accessor for private $totalwidth var.
	* @return Number.
	**/
	
	public function get totalwidth():Number{
		return this.$totalwidth;
	}
	/**
	* Mutator for private $totalwidth var.
	* @param arg Number
	**/
	
	public function set totalwidth(arg:Number) {
		this.$totalwidth = arg;
		this.$scrubbablewidth = this.$totalwidth - this.$width;
	}
	
	
	public function unlock(Void):Void {
		this.onPress = function() {
			var e = new org.caleb.event.Event('onScrubberPressed');
			this.dispatchEvent(e);
			
		}
		this.onRelease = this.onReleaseOutside = function() {
			var e = new org.caleb.event.Event('onScrubberReleased');
			this.dispatchEvent(e);
		}
	}
	
	
	public function lock(Void):Void {
		delete this.onPress, this.onRelease, this.onReleaseOutside;
	}
	
	public function set position(per:Number):Void {
		var md = this.$scrubbablewidth * per;
		this._x = md;
	}
	public function get position():Number {
		return this._x / this.$scrubbablewidth;
	}

	
	
	
}