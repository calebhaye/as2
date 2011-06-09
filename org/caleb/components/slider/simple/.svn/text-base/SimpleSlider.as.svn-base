import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.animation.AnimationManager;
import org.caleb.event.Event;
import org.caleb.components.slider.simple.ScrollThumb;

class org.caleb.components.slider.simple.SimpleSlider extends ObservableMovieClip 
{
	public var slider_mc:ScrollThumb;
	public var slidebar_mc:MovieClip;
	private var $slider_tw:AnimationManager;
	private var $zoom_out_mc:MovieClip;
	private var $zoom_in_mc:MovieClip;
	private var $slide_si:Number;
	private var $total:Number;
	private var $e:Event;
	public function init() {
		this.$e = new org.caleb.event.Event();
		this.$initButtons();
		if (this.isLocked()) {
			this.unlock();
		}
	}
		
	/**
	* set scrollposition
	* description: sets the scrollbar position from 0-1
	* usage: SimpleSlider.scrollposition = .3;
	**/
	public function set scrollposition(per:Number) 
	{
		update(per);
	}
	private function update(per:Number, eventName:String):Void
	{
		trace('** per: ' + per);
		if(eventName == undefined)
		{
			eventName = 'onSliderProceduralUpdate';
		}
		var tot = this.slidebar_mc._width - this.slider_mc._width + this.slidebar_mc._x;
		this.slider_mc._x = tot * per;

		this.$e.setType(eventName);
		tot = (this.slidebar_mc._width - this.slider_mc._width);
		this.$e.addArgument('slider', this);
		this.$e.addArgument('per', per);
		this.$e.addArgument('value', Math.ceil(per*this.$total));
		this.dispatchEvent($e);
	}
	public function get per()
	{
		var tot = (this.slidebar_mc._width-this.slider_mc._width);
		return (this.slider_mc._x-this.slidebar_mc._x)/tot;
	}
	/**
	* watchSlide 
	* description: 
	**/
	public function watchSlide() {
		//this.trace('watchSlide invoked')
		this.$e.setType('onSliderUpdate');
		var tot = (this.slidebar_mc._width-this.slider_mc._width);
		var per = (this.slider_mc._x-this.slidebar_mc._x)/tot;
		this.$e.addArgument('per', per);
		this.$e.addArgument('value', Math.ceil(per*this.$total));
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
			};
		};
		this.$zoom_in_mc.onRelease = this.$zoom_in_mc.onReleaseOutside=function () {
			this._parent.slider_mc.onEnterFrame = undefined;
			this._parent.slider_mc.onRelease();
		};
		this.$zoom_out_mc.onPress = function() {
			this._parent.slider_mc.onEnterFrame = function() {
				this._x -= 5;
			};
		};
		this.$zoom_out_mc.onRelease = this.$zoom_out_mc.onReleaseOutside=function () {
			this._parent.slider_mc.onEnterFrame = undefined;
			this._parent.slider_mc.onRelease();
		};
		this.slidebar_mc.onRelease = function() {
			var tot = this._parent.slidebar_mc._width-this._parent.slider_mc._width+this._parent.slidebar_mc._x;
			var p = this._parent.slider_mc._x/tot;
			var m = this._parent._xmouse/tot;
			this._parent.update( (p+m)/2 , 'onSliderBackgroundClick');
		};
	}
	public function get total():Number
	{
		return this.$total;
	}
	//Sets the scroll width of the scroll bar.	
	public function set total(arg:Number) {
		this.$total = arg;
		var per = 1/arg;
		var w = per*this.slidebar_mc._width;
		this.$slider_tw.tween('thumbwidth', w, .5);
	}
	public function lock():Void {
		this.enabled = false;
	}
	public function unlock():Void {
		this.enabled = true;
	}
	public function isLocked():Boolean {
		return this.enabled;
	}
}
