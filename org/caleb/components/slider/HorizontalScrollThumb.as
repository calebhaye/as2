import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.state.ILockable;

class org.caleb.components.slider.HorizontalScrollThumb extends ObservableMovieClip implements ILockable
{
	public static var SymbolName:String = '__Packages.org.caleb.components.slider.HorizontalScrollThumb';
	public static var SymbolLinked = Object.registerClass(SymbolName, HorizontalScrollThumb);

	private var $mid:MovieClip;
	private var $leftcap:MovieClip;
	private var $rightcap:MovieClip;
	private var $state:String;
	
	public function HorizontalScrollThumb() 
	{
		if($mid == undefined && $leftcap == undefined && $rightcap == undefined)
		{
			$mid = org.caleb.util.DrawingUtil.drawRectangle(this, 1, 15, 0, 0, 0, 0xCCCCCC, 0xFFFFFF);
			$leftcap = org.caleb.util.DrawingUtil.drawRectangle(this, 1, 15, 0, 0, 0, 0xCCCCCC, 0xFFFFFF);
			$rightcap = org.caleb.util.DrawingUtil.drawRectangle(this, 1, 15, 0, 0, 0, 0xCCCCCC, 0xFFFFFF);
		}
	}
	public function get mid():MovieClip
	{
		return this.$mid;
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
		//slider should now move in accordance with the zoomLevel via setX
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
	
	
	public function setX(arg:Number) {
		var per = Math.floor(arg) / 17;
		var tot = this._parent.slidebar_mc._width - this._width;
		var mov = this._parent.slidebar_mc._x + (tot - (per * tot));
		this._parent.slider_tw.tween('_x', mov, .5);
	}
	
	
	public function init() {
		this.onPress = function() {
			this.startDrag(false, this._parent.slidebar_mc._x, this._y, (this._parent.slidebar_mc._x + this._parent.slidebar_mc._width - this._width), this._y);
			clearInterval(this._parent.$slide_si);
			this._parent.$slide_si = setInterval(this._parent, "watchSlide", 100);
			this._parent.$e.setType('onSliderPress');
			this._parent.dispatchEvent(this._parent.$e);
		}
		
		this.onRelease = this.onReleaseOutside = function() 
		{
			this.stopDrag();
			//find what percentage you've dragged to.
			this._parent.$e.setType('onSliderRelease');
			this._parent.dispatchEvent(this._parent.$e);
			this._parent.watchSlide();
			clearInterval(this._parent.$slide_si);
		}
	}
	
	
	
		
}