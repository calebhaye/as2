import org.caleb.movieclip.CoreMovieClip;
import org.caleb.widgets.ScrollBar;
import org.caleb.components.scroll.ScrollButton;

class org.caleb.components.scroll.Scroll extends CoreMovieClip
{
	private var $scrollInterval:Number;
	private var $hScrollAmount:Number;
	private var $vScrollAmount:Number;
	private var $contentId:String;
	private var $contentContainer:MovieClip;
	private var $hPosition:Number;
	private var $vPosition:Number;
	private var $scrollWidth:Number;
	private var $scrollHeight:Number;
	private var $maxHPosition:Number;
	private var $maxVPosition:Number;
	private var $vScrollPolicy:Boolean;
	private var $hScrollPolicy:Boolean;
	private var $scrollTween;
	private var $scrollBarVertical:ScrollBar;
	private var $scrollBarHorizontal:ScrollBar;
	
	public var scrollBarVerticalInterval:Number;
	public var scrollBarHorizontalInterval:Number;
	// assets assumed to be present in fla
	public var buttonUp:ScrollButton;
	public var buttonDown:ScrollButton;
	public var buttonLeft:ScrollButton;
	public var buttonRight:ScrollButton;
	
	public function Scroll()
	{
		trace('[Scroll] constructor invoked')
		this.setClassDescription('org.caleb.components.Scroll');
		// create a container
		this.$contentContainer = this.createEmptyMovieClip('scrollContentContainer', this.getNextHighestDepth());
		// paint
		this.paint();
		// defaults
		this.$vScrollAmount = 5;
		this.$hScrollAmount = 5;
		this.setViewArea(200,400)
	}
	public function onMouseUp()
	{
		clearInterval(this.scrollBarVerticalInterval);
		clearInterval(this.scrollBarHorizontalInterval);
	}
	private function paint():Void
	{
		
	}
	private function doScrollTween(begin:Number, end:Number, p:String)
	{
		trace('tweening: '+this.content)
		trace('sb v: '+this.$scrollBarVertical)
		this.scrollBarVerticalInterval = setInterval(this.positionVerticalScrollBar, 10, this);
		this.scrollBarHorizontalInterval = setInterval(this.positionHorizontalScrollBar, 10, this);
		var ease  = mx.transitions.easing.Strong.easeIn;
		var time  = .75;
		this.$scrollTween = new mx.transitions.Tween(this.content, p, ease, begin, end, time, true);
		this.$scrollTween.content = this;
		this.$scrollTween.onMotionFinished = function(obj)
		{
			obj.content.stop();
		}
	}
	private function positionVerticalScrollBar(s:Scroll)
	{
		s.scrollBarVertical.scroller._y = s.scrollBarY;
	}
	private function positionHorizontalScrollBar(s:Scroll)
	{
		s.scrollBarHorizontal.scroller._x = s.scrollBarX;
	}
	public function setViewArea(w:Number, h:Number)
	{
		this.$scrollWidth = w;
		this.$scrollHeight = h;
		org.caleb.util.MovieClipUtil.drawMask(this.$contentContainer, w, h);
		this.paint();
	}
	public function attachScrollBar():Void
	{
		trace('attachScrollBar: ' + this);
		this.$scrollBarVertical = ScrollBar(this.attachMovie('scrollbar','$scrollBarVertical', this.getNextHighestDepth()));
		this.$scrollBarVertical.useMask = false;
		this.$scrollBarVertical.horizontal = false;
		this.$scrollBarVertical.length = this.$scrollWidth - this.buttonUp._width - this.buttonDown._width;
		this.$scrollBarVertical.setup(this.content);
		this.$scrollBarVertical._x = this.$scrollWidth;
		this.$scrollBarVertical._y += this.buttonUp._width;

		this.$scrollBarHorizontal = ScrollBar(this.attachMovie('scrollbar','$scrollBarHorizontal', this.getNextHighestDepth()));
		this.$scrollBarHorizontal.useMask = false;
		this.$scrollBarHorizontal.horizontal = true;
		this.$scrollBarHorizontal.length = this.$scrollHeight - this.buttonLeft._width - this.buttonRight._width;
		this.$scrollBarHorizontal.setup(this.content);
		this.$scrollBarHorizontal._x = this.content._x + this.buttonLeft._width;
		this.$scrollBarHorizontal._y = this.$scrollHeight;
		// pass ref to buttons
		this.buttonUp.scroll = this;
		this.buttonDown.scroll = this;
		this.buttonLeft.scroll = this;
		this.buttonRight.scroll = this;
		// buttons
		this.initScrollBarButtons();
	}
	private function initScrollBarButtons()
	{
		this.buttonUp.scrollDirection = ScrollButton.DIRECTION_UP;
		this.buttonUp._y = this.buttonUp._height;
		this.buttonUp._x = this.$scrollBarVertical._x;

		this.buttonDown.scrollDirection = ScrollButton.DIRECTION_DOWN;
		this.buttonDown._y = this.$scrollBarVertical._y + this.$scrollBarVertical._height;
		this.buttonDown._x = this.$scrollBarVertical._x + this.$scrollBarVertical._width;

		this.buttonLeft.scrollDirection = ScrollButton.DIRECTION_LEFT;
		this.buttonLeft._y = this.$scrollBarHorizontal._y + this.$scrollBarHorizontal._height;
		this.buttonLeft._x = this.$scrollBarHorizontal._x;

		this.buttonRight.scrollDirection = ScrollButton.DIRECTION_RIGHT;
		this.buttonRight._y = this.$scrollBarHorizontal._y + this.$scrollBarHorizontal._height - this.buttonRight._height;
		this.buttonRight._x = this.$scrollBarHorizontal._x + this.$scrollBarHorizontal._width;
	}
	public function loadExternalContent(url:String):Void
	{
		// load the content into that container
		this.content = this.$contentContainer.createEmptyMovieClip('scrollContent', this.$contentContainer.getNextHighestDepth());
		org.caleb.util.MovieClipUtil.loadContent(this.content, url, 0, 0, this, this.onExternalContentLoad);
	}
	private function onExternalContentLoad(s:Scroll)
	{
		trace('onExternalContentLoad: ' + s);
		s.attachScrollBar();
	}
	public function libraryLoad(str:String):Void
	{
		if(str == undefined)
		{
			throw('[Scroll.libraryLoad] libary clip name is undefined')
		}
		else
		{
			this.$contentId = str;
			// load the content into that container
			this.content = this.$contentContainer.attachMovie(this.$contentId, 'scrollContent', this.$contentContainer.getNextHighestDepth());
			this.attachScrollBar();
		}
	}
	public function clickUp():Void
	{
		trace('[Scroll.clickUp]')
		trace(this.content._y +' <= '+ this._y)
		if(this.content._y <= this._y)
		{
			this.content._y += this.$vScrollAmount;
		}
	}
	public function clickDown():Void
	{
		trace('this.content:'+this.content)
		trace(this.$maxVPosition +' <= '+ (this.content._y + this.content._height))
		if(this.$maxVPosition <= (this.content._y + this.content._height))
		{
			trace('[Scroll.clickDown]')
			this.content._y -= this.$vScrollAmount;
		}
	}
	public function clickLeft():Void
	{
		trace('[Scroll.clickLeft]')
		if(this.content._x <= this._x)
		{
			this.content._x += this.$hScrollAmount;
		}
	}
	public function clickRight():Void
	{
		trace('[Scroll.clickRight]')
		trace(this.$maxHPosition +' <= '+ (this.content._x + this.content._width))
		if(this.$maxHPosition <= (this.content._x + this.content._width))
		{
			this.content._x -= this.$hScrollAmount;
		}
	}
	public function holdUp():Void
	{
		trace('up')
		if(this.contentScrollableVertical == true)
		{
			this.doScrollTween(this.content._y, 0, '_y');
		}
	}
	public function holdDown():Void
	{
		if(this.contentScrollableVertical == true)
		{
			this.doScrollTween(this.content._y, (-this.content._height)+this.$scrollHeight, '_y');
		}
	}
	public function holdLeft():Void
	{
		if(this.contentScrollableHorizontal == true)
		{
			this.doScrollTween(this.content._x, 0, '_x');
		}
	}
	public function holdRight():Void
	{
		if(this.contentScrollableHorizontal == true)
		{
			this.doScrollTween(this.content._x, -(this.content._width - this.scrollWidth), '_x');
		}
	}
	public function stop()
	{
		trace('stop');
		this.$scrollTween.stop();
	}
	/* 
	* Inspectable Properties
	*/
	[Inspectable]
	public function set scrollWidth(w:Number):Void
	{
		// todo: draw mask
		this.$scrollWidth = w;
	}
	public function get scrollWidth():Number
	{
		// todo: draw mask
		return this.$scrollWidth;
	}
	[Inspectable]
	public function set scrollHeight(h:Number):Void
	{
		this.$scrollHeight = h;
	}
	public function get scrollHeight():Number
	{
		return this.$scrollHeight;
	}
	[Inspectable]
	public function get content():MovieClip
	{
		if(this.$contentContainer.scrollContent == undefined)
		{
			// load the content into that container
			this.content = this.$contentContainer.createEmptyMovieClip('scrollContent', this.$contentContainer.getNextHighestDepth());
		}
		return this.$contentContainer.scrollContent;
	}
	public function set content(mc:MovieClip)
	{
		trace('setting content: '+mc)
		if(this.$contentContainer.scrollContent == undefined)
		{
			// load the content into that container
			this.content = this.$contentContainer.createEmptyMovieClip('scrollContent', this.$contentContainer.getNextHighestDepth());
		}
		this.$contentContainer.scrollContent = mc;
	}
	
	[Inspectable]
	public function get contentId():String
	{
		return this.$contentId;
	}
	public function set contentId(s:String)
	{
		this.$contentId = s;
	}
	[Inspectable]
	public function get hScrollAmount():Number
	{
		return this.$hScrollAmount;
	}
	public function set hScrollAmount(n:Number)
	{
		this.$hScrollAmount = n;
	}
	[Inspectable]
	public function get vScrollAmount():Number
	{
		return this.$vScrollAmount;
	}
	public function set vScrollAmount(n:Number)
	{
		this.$vScrollAmount = n;
	}
	/*
	* The horizontal position of the list 
	*/
	[Inspectable]
	public function get hPosition():Number
	{
		return this.$hPosition;
	}
	public function set hPosition(n:Number)
	{
		this.$hPosition = n;
	}
	/*
	* The _y of the topmost visible item of the list
	*/
	[Inspectable]
	public function get vPosition():Number
	{
		return this.$vPosition;
	}
	public function set vPosition(n:Number)
	{
		this.$vPosition = n;
	}	 
	/*
	* The number of pixels the list can scroll to the bottom, when public function get vScrollPolicy is set to "on". 
	*/
	[Inspectable]
	public function get maxVPosition():Number
	{
		return this.$maxVPosition;
	}
	public function set maxVPosition(n:Number)
	{
		this.$maxVPosition = n;
	}
	/*
	* The number of pixels the list can scroll to the right, when public function get hScrollPolicy is set to "on". 
	*/
	[Inspectable]
	public function get maxHPosition():Number
	{
		return this.$maxHPosition;
	}
	public function set maxHPosition(n:Number)
	{
		this.$maxHPosition = n;
	}
	/*
	* Indicates whether the horizontal scroll bar is displayed ("on") or not ("off").
	*/
	[Inspectable]
	public function get hScrollPolicy():Boolean
	{
		return this.$hScrollPolicy;
	}
	public function set hScrollPolicy(b:Boolean)
	{
		this.$hScrollPolicy = b;
	}
	/*
	* Indicates whether the vertical scroll bar is displayed ("on"), not displayed ("off"), or displayed when needed ("auto").
	*/
	[Inspectable]
	public function get vScrollPolicy():Boolean
	{
		return this.$vScrollPolicy;
	}
	public function set vScrollPolicy(b:Boolean)
	{
		this.$vScrollPolicy = b;
	}
	/*
	* read only
	*/	
	public function get container():MovieClip
	{
		return this.$contentContainer;
	}
	public function get scrollYPosition():Number
	{
		return this._y;
	}
	public function get scrollXPosition():Number
	{
		return this._x;
	}
	public function get scrollContentYPosition():Number
	{
		return Number(this._y + this.content._y)
	}
	public function get scrollContentXPosition():Number
	{
		return Number(this._x + this.content._x)
	}
	public function get scrollContentYRatio():Number
	{
		return -(this.content._y / this.content._height)
	}
	public function get scrollContentXRatio():Number
	{
		return -(this.content._x / this.content._width)
	}
	public function get scrollBarVerticalRatio():Number
	{
		return -(this.$scrollBarVertical._y / (this.$scrollHeight + this.buttonDown._height + this.buttonUp._height))
	}
	public function get scrollBarHorizontalRatio():Number
	{
		return -(this.$scrollBarVertical._x / (this.$scrollWidth + this.buttonRight._width + this.buttonLeft._width))
	}
	public function get scrollBarY():Number
	{
		return (this.$scrollHeight * this.scrollContentYRatio);
	}
	public function get scrollBarX():Number
	{
		return (this.$scrollWidth * this.scrollContentXRatio);
	}
	public function get scrollContentY():Number
	{
		return (this.content._height * this.scrollBarVerticalRatio);
	}
	public function get scrollContentX():Number
	{
		return (this.content._width * this.scrollBarHorizontalRatio);
	}
	public function get contentScrollableVertical():Boolean
	{
		return (this.content._height > this.$scrollHeight);
	}
	public function get contentScrollableHorizontal():Boolean
	{
		return (this.content._width > this.$scrollWidth);
	}
	public function get scrollBarVertical():ScrollBar
	{
		return this.$scrollBarVertical;
	}
	public function get scrollBarHorizontal():ScrollBar
	{
		return this.$scrollBarHorizontal;
	}
}