import org.caleb.movieclip.CoreMovieClip;
import org.caleb.components.ticker.SlidingTicker;

class org.caleb.components.ticker.SlidingTickerItem extends CoreMovieClip
{
	private var $ticker:SlidingTicker;
	private var $animating:Boolean;
	private var $enteredStage:Boolean;
	private var $data:Object;
	// indices
	private var $index:Number;
	private var $nextIndex:Number;
	private var $previousIndex:Number;
	// properties
	private var $timeOnStage:Number;
	// assets assumed to be present in .fla
	private var display:TextField;
	
	public function SlidingTickerItem()
	{
		this.setClassDescription('org.caleb.components.ticker.SlidingTickerItem');
		this.$enteredStage = false;
		this.$animating = false;
		this.display.autoSize = 'left';
		this.$timeOnStage = 3;
	}
	// public methods
	public function reset():Void
	{
		this.stop();
		this.$enteredStage = false;
		this._x = this.$ticker.mask._width;
	}
	public function start():Void
	{
		this.$animating = true;
		var easeType:Object = mx.transitions.easing.None.easeNone; 
		
		var a:Number = this._width / this.$ticker.mask._width;
		var b:Number = this.$timeOnStage * a;
		
		var totalSeconds:Number = b + this.$timeOnStage;

		var seconds:Number = totalSeconds;
		var begin:Number = this._x;
		var end:Number = this.$ticker._x - this.$ticker.mask._x - this._width;
		this.$ticker.activeTween =  new mx.transitions.Tween(this, "_x", easeType, begin, end, seconds, true);
		this.onEnterStage();
		this.$ticker.activeTween.content = new Object;
		this.$ticker.activeTween.content.item = this;
		this.$ticker.activeTween.onMotionFinished = function(tween):Void
		{
			tween.content.item.onComplete();
			tween.content.item.reset();
			delete tween.content.item.ticker.activeTween;
			tween.content.item.startNext();
		}
		
	}
	public function stop():Void
	{
		this.$animating = false;
	}
	public function onEnterStage():Void
	{
		this.$enteredStage = true;
	}
	public function startNext():Void
	{
		//trace('onEnterStage invoked for item: ' + this.$index);
		var rightBrother:SlidingTickerItem = this.$ticker.items[this.nextIndex];
		if(rightBrother.animating != true)
		{
			rightBrother.start();
		}
	}
	public function get enteredStage():Boolean
	{
		return this.$enteredStage;
	}
	public function get isHittingMask():Boolean
	{
		return this.hitTest(this.$ticker.mask);
	}
	public function get isOnStage():Boolean
	{
		var widthIsOnMask:Boolean =  this._x + this._width <= this.$ticker.mask._width;
		return (widthIsOnMask);
	}
	public function get isOffStageLeft():Boolean
	{
		var offStageLeft:Boolean = ((this._x + this._width) <= this.$ticker.mask._x);
		
		return (offStageLeft && !this.isHittingMask);
	}
	public function gotoInitialPosition():Void
	{
		this._x = this.$ticker.mask._width;
	}
	// mutators
	public function set ticker(t:SlidingTicker):Void
	{
		this.$ticker = t;
	}
	public function set data(o:Object):Void
	{
		this.$data = o;
		if(this.$ticker.isHTML == true)
		{
			this.display.htmlText = String(o);
		}
		else
		{
			this.display.text = String(o);
		}
	}
	public function set index(n:Number):Void
	{
		this.$index = n;
	}
	public function set nextIndex(n:Number):Void
	{
		this.$nextIndex = n;
	}
	public function set previousIndex(n:Number):Void
	{
		this.$previousIndex = n;
	}
	// accessors
	public function get ticker():SlidingTicker
	{
		return this.$ticker;
	}
	public function get data():Object
	{
		return this.$data;
	}
	public function get index():Number
	{
		return this.$index;
	}
	public function get nextIndex():Number
	{
		return this.$nextIndex;
	}
	public function get previousIndex():Number
	{
		return this.$previousIndex;
	}
	public function get animating():Boolean
	{
		return this.$animating;
	}
}