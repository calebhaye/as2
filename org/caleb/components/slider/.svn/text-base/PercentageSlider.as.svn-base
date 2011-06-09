import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.animation.AnimationManager;
import org.caleb.event.Event;
import org.caleb.components.slider.HorizontalScrollThumb;
import org.caleb.state.ILockable;

class org.caleb.components.slider.PercentageSlider extends org.caleb.movieclip.ObservableMovieClip implements ILockable 
{
	public static var SymbolName:String = '__Packages.org.caleb.components.slider.PercentageSlider';
	public static var SymbolLinked = Object.registerClass(SymbolName, PercentageSlider);

	public var slider_mc:HorizontalScrollThumb;
	public var slidebar_mc:MovieClip;
	private var $slider_tw:AnimationManager;
	
	private var $zoom_out_mc:MovieClip;
	private var $zoom_in_mc:MovieClip;
	
	private var $slide_si:Number;
	private var $w:Number;
	private var $h:Number;
	private var $e:Event;
	
	public function PercentageSlider() {this.setClassDescription('org.caleb.components.slider.PercentageSlider');}	
	
	public function init() 
	{
		//trace('init invoked')
		this.$e = new org.caleb.event.Event();
		if(this.slidebar_mc == undefined)
		{
			if(this.$w == undefined && this.$h == undefined)
			{
				this.slidebar_mc = org.caleb.util.DrawingUtil.drawRectangle(this, 500, 15, 0, 0, 0, 0x990099, 0x999999);
			}
			else
			{
				this.slidebar_mc = org.caleb.util.DrawingUtil.drawRectangle(this, this.$w, this.$h, 0, 0, 0, 0x990099, 0x999999);
			}
		}

		if(this.slider_mc == undefined)
		{
			this.slider_mc = HorizontalScrollThumb(this.attachMovie(HorizontalScrollThumb.SymbolName, 'slider_mc', this.getNextHighestDepth()));
		}
		this.$initButtons();
		if (this.isLocked()) {
			this.unlock();
		}
	}
	
	public function get scrollpos():Number
	{
		var tot = (this.slidebar_mc._width - this.slider_mc._width);
		var per = (this.slider_mc._x - this.slidebar_mc._x) / tot;
		
		//trace('scrollpos: ' + per)
		return per;
	}
	
	public function set scrollpos(per:Number) 
	{
		var tot = this.slidebar_mc._width - this.slider_mc._width + this.slidebar_mc._x;
		this.slider_mc._x = tot * per;

		this.$e.setType('onSliderProceduralUpdate');
		var tot = (this.slidebar_mc._width - this.slider_mc._width);
		var per = (this.slider_mc._x - this.slidebar_mc._x) / tot;
		this.$e.addArgument('per', per);
		this.dispatchEvent($e);
	}
	public function set scrollX(x:Number) 
	{
		this.slider_mc._x = x;

		this.$e.setType('onSliderProceduralUpdate');
		var tot = (this.slidebar_mc._width - this.slider_mc._width);
		var per = (this.slider_mc._x - this.slidebar_mc._x) / tot;
		this.$e.addArgument('per', per);
		this.dispatchEvent($e);
	}
	
	public function watchSlide() {
		this.$e.setType('onSliderUpdate');
		var tot = (this.slidebar_mc._width - this.slider_mc._width);
		var per = (this.slider_mc._x - this.slidebar_mc._x) / tot;
		this.$e.addArgument('per', per);
		this.dispatchEvent($e);
	}
	
	private function $initButtons() {
		this.slider_mc.thumbwidth = this.slidebar_mc._width;
		this.slider_mc.init();
		if (this.$slider_tw == undefined) {
			this.$slider_tw = new AnimationManager(this.slider_mc);
		}
		
		this.$zoom_in_mc.onPress = function() {
			this._parent.slider_mc.onEnterFrame = function() {
				this._x += 5;
			}
		}
		this.$zoom_in_mc.onRelease = this.$zoom_in_mc.onReleaseOutside = function() {
			this._parent.slider_mc.onEnterFrame = undefined;
			this._parent.slider_mc.onRelease();
		}
		this.$zoom_out_mc.onPress = function() {
			this._parent.slider_mc.onEnterFrame = function() {
				this._x -= 5;
			}
		}
		this.$zoom_out_mc.onRelease = this.$zoom_out_mc.onReleaseOutside = function() {
			this._parent.slider_mc.onEnterFrame = undefined;
			this._parent.slider_mc.onRelease();
		}
	
		this.slidebar_mc.onRelease = function() 
		{
			this._parent.scrollpos = this._parent._xmouse / this._parent.slidebar_mc._width; 
			this._parent.slider_mc.onRelease();
	   };		
	}
	
	//Sets the scroll width of the scroll bar.	
	public function set total(arg:Number) {
		var per = 1 / arg;
		var w = per * this.slidebar_mc._width;
		this.$slider_tw.tween('thumbwidth', w, .5);
	}
	
	public function lock():Void {
		//slider should now move in accordance with the zoomLevel via setX
		this.enabled = false;
	}
	public function unlock():Void {
		this.enabled = true;
	}
	public function isLocked():Boolean {
		return this.enabled;
	}
	public function set w(arg:Number):Void
	{
		this.$w = arg;
	}
	public function set h(arg:Number):Void
	{
		this.$h = arg;
	}
}