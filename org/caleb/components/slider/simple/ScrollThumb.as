import org.caleb.movieclip.ObservableMovieClip;
class org.caleb.components.slider.simple.ScrollThumb extends ObservableMovieClip{
	private var $mid:MovieClip;
	private var $leftcap:MovieClip;
	private var $rightcap:MovieClip;
	private var $state:String;
	
	public function ScrollThumb() {
		
	}
	
	public function set thumbwidth(arg:Number) {
		//trace('set thumbwidth:'+arg);
		this.$mid._width = arg - this.$leftcap._width - this.$rightcap._width;
		this.$rightcap._x = this.$mid._x + this.$mid._width;
	}
	
	public function get thumbwidth():Number {
		var w = this.$mid._width + this.$rightcap._width + this.$leftcap._width;
		return w;
	}
	
	public function lock():Void {
		this.$state = 'locked';
		this.enabled = false;
	}
	public function unlock():Void {
		this.$state = 'unlocked';
		this.enabled = true;
	}
	
	public function isLocked():Boolean {
		return this.$state == 'locked' ? true : false;
	}

	
	public function init() {
		this.onPress = function() {
			this.startDrag(false, this._parent.slidebar_mc._x, this._y, (this._parent.slidebar_mc._x + this._parent.slidebar_mc._width - this._width), this._y);
			clearInterval(this._parent.$slide_si);
			this._parent.$slide_si = setInterval(this._parent, "watchSlide", 100);
		}
		
		this.onRelease = this.onReleaseOutside = function() {
			this.stopDrag();
			//find what percentage you've dragged to.
			this._parent.$e.setType('onSliderReleased');
			this._parent.dispatchEvent(this._parent.$e);
			this._parent.watchSlide();
			clearInterval(this._parent.$slide_si);
		}
	}
	
	
	
		
}