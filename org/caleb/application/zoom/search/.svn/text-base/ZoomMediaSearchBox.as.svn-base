import org.caleb.application.zoom.ZoomIntro;
import org.caleb.application.zoom.search.ZoomMediaSearch;
/**
 * 
 * @author  calebh
 * @version 1.0
 * @see     ZoomIntro	
 * @since   
 */
class org.caleb.application.zoom.search.ZoomMediaSearchBox extends ZoomIntro
{
	private var $focused:Boolean;
	private var $view:ZoomMediaSearch;
	// assets assumed to be present in .fla
	public var search:MovieClip;
	public var flickrButton:MovieClip;
	public var bg:MovieClip;
	public var modeSwitch:MovieClip;
	public var helpButton:MovieClip;
	public var needle:TextField;
	public var resultCount:TextField;

	public function ZoomMediaSearchBox()
	{
		this.setClassDescription('org.caleb.application.zoom.ZoomMediaSearchBox');
		//trace('constructor invoked');
	}
	public function switchMode():Void
	{
		trace('switchMode invoked, this.flickrButton: '+this.flickrButton);
		trace('this.flickrButton._alpha: ' + this.flickrButton._alpha);
		var animationManager = new org.caleb.animation.AnimationManager(this.flickrButton);
		if(this.flickrButton._alpha == 0)
		{
			this.$view.init(ZoomMediaSearch.MODE_FLICKR);
			animationManager.tween('_alpha', 100, 1);
		}
		else
		{
			this.$view.init(ZoomMediaSearch.MODE_YAHOO);
			animationManager.tween('_alpha', 0, 1);
		}
		this.$view.submitForm();	}
	public function init(v:ZoomMediaSearch):Void
	{
		this.$view = v;	
		this.addEventObserver(this.$view, 'onIntroMinimized');
		//trace('this.$view: ' + this.$view);
		//trace('this.$view.search: ' + this.$view.search);
		this.modeSwitch.onRelease = function():Void
		{
			this._parent.switchMode();
		}
		this.needle.onSetFocus = function():Void
		{
			this._parent.focused = true;
		}
		this.needle.onKillFocus = function():Void
		{
			this._parent.focused = false;
		}
		this.bg.nonDragReleaseHandler = function():Void
		{
			trace('nonDragReleaseHandler invoked');
			this.onMouseMove = this.nonDragMouseMoveHandler;
			this.onRelease = null;
			this.onRollOver = null;
		}

		this.bg.onRollOver = function():Void
		{
			this._parent.$view.searchFocused = true;
		}
		this.bg.onPress = function():Void
		{
			this.onRelease = this.nonDragReleaseHandler;
			var offset = {x:_parent._x - _parent._parent._xmouse, y:_parent._y - _parent._parent._ymouse}
			this.onMouseMove = function() 
			{
				trace('dragging');
				this._parent.resultCount._visible = false;
				_parent._x = _parent._parent._xmouse + offset.x;
				_parent._y = _parent._parent._ymouse + offset.y;
				this.updateAfterEvent();
			}
		}
		this.helpButton.stop();
		this.helpButton.onRollOver = function():Void
		{
			this.nextFrame();
			this.stop();
		}
		this.helpButton.onRollOut = function():Void
		{
			this.prevFrame();
			this.stop();
		}
		this.helpButton.onRelease = function():Void
		{
			this._parent.$view.displayHelp();
			this.stop();
		}
		this.search.onRelease = function()
		{
			//trace('this._parent.$view: ' + this._parent.$view)
			//trace('this._parent.$view.search: ' + this._parent.$view.search)
			this._parent.$view.search(this._parent.needle.text);
		}
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function minimize():Void
	{
		var animationManager = new org.caleb.animation.AnimationManager(this)
		animationManager.tween(['_x','_y'], [((Stage.width - this._width) / 2), 5], .25, "easeoutquad", 0, [this, 'onIntroMinimized']);
	}
	public function onIntroMinimized():Void
	{
		trace('onIntroMinimized invoked');
		this.dispatchEvent(new org.caleb.event.Event('onIntroMinimized'));
	}
	public function get focused():Boolean
	{
		return this.$focused;
	}
	public function set focused(arg:Boolean):Void
	{
		this.$focused = arg;
	}
}