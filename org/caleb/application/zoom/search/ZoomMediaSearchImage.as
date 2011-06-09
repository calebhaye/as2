import org.caleb.application.zoom.search.ZoomMediaSearch;
import org.caleb.application.zoom.ZoomImage;
/**
 * 
 * @author  calebh
 * @version 1.0
 * @see     ZoomImage	
 * @throws	onLoadError
 * @since   
 */
class org.caleb.application.zoom.search.ZoomMediaSearchImage extends ZoomImage
{
	// assets assumed to be present in .fla
	private var imageDetails:MovieClip;
	private var $view:ZoomMediaSearch;
	
	function ZoomMediaSearchImage()
	{
		this.setClassDescription('org.caleb.application.zoom.search.ZoomMediaSearchImage');
		//trace('constructor invoked');
		this.imageDetails._visible = false;
		this.imageDetails.autoSize = 'center';

		this.$maximumRotation = 25;
		this.$baseURL = '';
	}
	private function onLoadAttemptComplete():Void
	{
		super.onLoadAttemptComplete();
		if(this.$imageLoadFailed == true)
		{
			this.$view.setMiniViewCellMode(this.$id, ZoomMediaSearch.MODE_LOAD_FAILED);
		}
		else
		{
			this.$view.setMiniViewCellMode(this.$id, undefined);
			//this.$view.setMiniViewCellMode(this.$id, ZoomMediaSearch.MODE_LOAD_SUCCESS);
		}
	}
	public function load():Void
	{
		super.load();
		this.$view.setMiniViewCellMode(this.$id, ZoomMediaSearch.MODE_LOAD_STARTED);
	}
	private function setupHandlers():Void
	{
		this.onRollOver = this.onRollOverHandler;
		this.onRollOut = this.onRollOutHandler;
	}
	public function onDragInit():Void
	{
		//trace('onDragInit invoked');
	}
	public function onDragInterval():Void
	{
		//trace('onDragInterval invoked');
	}
	public function onDragComplete():Void
	{
		//trace('onDragComplete invoked');

		if(this.$ready == true)
		{
			if(this.$x == this._x && this.$y == this._y)
			{
				this.onReleaseHandler();
			}
			else
			{
				this.gotoOriginalPosition();
			}
		}
	}
	private function setupButtons():Void
	{
		//super.setupButtons();
	}
}