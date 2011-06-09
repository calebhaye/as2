import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.animation.AnimationManager;
import flash.display.BitmapData;
import org.caleb.components.slider.PercentageSlider;

class org.caleb.components.folksonomy.tagholder.TagHolder extends ObservableMovieClip 
{
	private var $tags:Array;
	private var $tag_ct:Number;
	private var $tag_scale:Number;
	private var $tagholder:MovieClip;
	private var $tagholder_tw:AnimationManager;
	private var $bg:MovieClip;
	private var $slider:PercentageSlider;
	
	public function TagHolder() 
	{
		this.setClassDescription('TagHolder');
	}
	public function init(Void):Void 
	{
		this.$tags = new Array();
		this.$tag_ct = 0;
		this.$tagholder = this.createEmptyMovieClip('$tagholder', this.getNextHighestDepth());
		this.$tagholder_tw = new AnimationManager(this.$tagholder);
		this.$slider.init();
		this.$slider.addEventObserver(this, 'onSliderUpdate');
	}
	
	public function onSliderUpdate(e:org.caleb.event.Event):Void {
		var over = this.$tagholder._width - this.$bg._width;
		var per = e.getArgumentByName('per');
		
		this.$tagholder_tw.tween('_x', -over * per, .5);
	}
	public function addAudioFrame(bm:BitmapData):Void 
	{
		// todo: add temporal notation here (get time/range, asset url, send remote request)
		this.addVideoFrame(bm);
	}
	public function addVideoFrame(bm:BitmapData):Void 
	{
		// todo: add temporal notation here (get time, asset url, send remote request)
		var kf = this.$tagholder.attachMovie('KeyFrameMC', 'kf_'+this.$tag_ct, this.$tagholder.getNextHighestDepth());
		kf.addEventObserver(this, 'onKeyFrameResized');
		kf.bitmap = bm;
		kf._y = 4;
		this.$tags.push(kf);
		this.$tag_ct++;
		this.resortClips();
	}
	public function addTag():Void {
		// todo: add temporal notation here (get time, asset url, send remote request)
		var kf = this.$tagholder.attachMovie('KeyFrameMC', 'kf_'+this.$tag_ct, this.$tagholder.getNextHighestDepth());
		kf.addEventObserver(this, 'onKeyFrameResized');
		kf._y = 4;
		this.$tags.push(kf);
		this.$tag_ct++;
		this.resortClips();
	}
	
	public function resortClips() {
		var xbuf = 4;
		for (var i=0; i<this.$tags.length; i++) {
			if (i==0) {
				this.$tags[i]._x = 0+xbuf;
			} else {
				var pt = this.$tags[i-1];
				this.$tags[i]._x = pt._x + pt._width + xbuf;
			}
		}
		var p = this._width / this.$bg._width;
		if (p > 1) {
			this.$slider.total = (p);
			this.$slider.unlock();
		} else {
			this.$slider.total = 1;
			this.$slider.lock();
			this.$slider.scrollpos = 0;
			this.$tagholder_tw.tween('_x', 0, .5);
			
		}
	}
	
	public function onKeyFrameResized() {
		this.resortClips();
	}
	
}