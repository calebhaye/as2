import org.caleb.application.zoom.ZoomController;
import org.caleb.movieclip.CoreMovieClip;
import org.caleb.animation.AnimationManager;

class org.caleb.application.zoom.ZoomImageHeader extends CoreMovieClip 
{
	public var topNav:MovieClip;
	public var detailsText:TextField;
	private var $controller:ZoomController;
	private var $animationManager:AnimationManager;
	// assets assumed to be present in .fla
	public var shade:MovieClip;
	public var topShade:MovieClip;
	
	public function ZoomImageHeader()
	{
		this.setClassDescription('org.caleb.application.zoom.ZoomImageHeader');
		trace('constructor invoked');
		this._visible = false;
		this.$animationManager = new AnimationManager(this);
	}
	public function onLoad():Void
	{
		this.topNav.upButton.stop();
		this.topNav.downButton.stop();
		this.topNav.downloadButton.stop();
		this.topNav.previousButton.stop();
		this.topNav.nextButton.stop();
		this.topNav.zoomOutButton.stop();
	}
	public function init():Void
	{
		trace('init invoked')
		this.topNav.upButton.onRelease = function()
		{
			trace('next invoked');
			this._parent._parent.$controller.onUp();
		}
		this.topNav.upButton.onRollOver = function()
		{
			this.nextFrame();
			this.stop();
		}
		this.topNav.upButton.onRollOut = this.topNav.upButton.onReleaseOutside = function()
		{
			this.prevFrame();
			this.stop();
		}
		this.topNav.downButton.onRelease = function()
		{
			trace('next invoked');
			this._parent._parent.$controller.onDown();
		}
		this.topNav.downButton.onRollOver = function()
		{
			this.nextFrame();
			this.stop();
		}
		this.topNav.downButton.onRollOut = this.topNav.downButton.onReleaseOutside = function()
		{
			this.prevFrame();
			this.stop();
		}
		this.topNav.nextButton.onRelease = function()
		{
			trace('next invoked');
			this._parent._parent.$controller.onRight();
		}
		this.topNav.nextButton.onRollOver = function()
		{
			this.nextFrame();
			this.stop();
		}
		this.topNav.nextButton.onRollOut = this.topNav.nextButton.onReleaseOutside = function()
		{
			this.prevFrame();
			this.stop();
		}
		this.topNav.previousButton.onRelease = function()
		{
			this._parent._parent.$controller.onLeft();
		}
		this.topNav.previousButton.onRollOver = function()
		{
			this.nextFrame();
			this.stop();
		}
		this.topNav.previousButton.onRollOut = this.topNav.previousButton.onReleaseOutside = function()
		{
			this.prevFrame();
			this.stop();
		}
		this.topNav.zoomOutButton.onRelease = function()
		{
			//trace('zoomOutButton.onRelease invoked')
			this._parent._parent.$controller.zoomOut();;
		}
		this.topNav.zoomOutButton.onRollOver = function()
		{
			this.nextFrame();
			this.stop();
		}
		this.topNav.zoomOutButton.onRollOut = this.topNav.zoomOutButton.onReleaseOutside = function()
		{
			this.prevFrame();
			this.stop();
		}
		this.topNav.downloadButton.onRollOver = function()
		{
			this.nextFrame();
			this.stop();
		}
		this.topNav.downloadButton.onRollOut = this.topNav.downloadButton.onReleaseOutside = function()
		{
			this.prevFrame();
			this.stop();
		}
		this.topNav.downloadButton.onRelease = function()
		{
			this._parent._parent.$controller.downloadCurrentImage();
			// this.getURL("javascript:popUp('"+this.items[this.currentId].filename + "'," + this.items[this.currentId]._width+ ',' + this.items[this.currentId]._height + ')');
		}
	}
	private function onOutroComplete():Void
	{
		this._visible = false;
	}
	public function intro():Void
	{
		this._visible = true;
		this.$animationManager.tween('_alpha', 100, 1);
	}
	public function outro():Void
	{
		this.$animationManager.tween('_alpha', 0, 1, undefined, undefined, [this, 'onOutroComplete']);
	}
	public function set controller(zc:ZoomController):Void
	{
		trace('set controller invoked')
		this.$controller = zc;
	}
}