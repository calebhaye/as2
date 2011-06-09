import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.application.zoom.ZoomView;

class org.caleb.application.zoom.ZoomIntro extends ObservableMovieClip 
{
	private var $view:ZoomView;
	
	public function ZoomIntro()
	{
		this.setClassDescription('org.caleb.application.zoom.ZoomIntro');
		//trace('constructor invoked');
	}
	public function init(v:ZoomView):Void
	{
		trace('v: ' + v)
		this.$view = v;		
		this._x = Math.floor((this.$view.stageWidth- this._width) / 2);
		this._y = Math.floor(this.$view.stageHeight/2) - this._height;
		this.onRelease = function()
		{
			trace('this.$view.init: ' + this.$view.init)
			this.$view.init();
			this._visible = false;
		}
	}
}