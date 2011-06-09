import flash.display.BitmapData;
import flash.filters.DropShadowFilter;
import org.caleb.animation.AnimationManager;
import org.caleb.movieclip.ObservableMovieClip;

class org.caleb.components.folksonomy.keyframe.KeyFrame extends ObservableMovieClip {
	private var $kf_holder:MovieClip;
	private var $tw:AnimationManager;
	private var $bg:MovieClip;
	
	public function KeyFrame() {
		this._alpha = 0;
		this.$tw = new AnimationManager(this);
		this.$kf_holder = this.createEmptyMovieClip('$kf_holder', this.getNextHighestDepth());
		this.$tw.alphaTo(100, .5);
	}
	
	public function set bitmap(bm:BitmapData) {
	//	this.$kf_holder.attachBitmap(bm, this.getNextHighestDepth(), true, true);
		this.$kf_holder.attachBitmap(bm, this.getNextHighestDepth());
		//how small does this need to be to fit in the pane?
		var sc = this.$kf_holder._height / this.$bg._height
		this.$kf_holder._x = this.$kf_holder._y = 5;
		
		this.$kf_holder._xscale = this.$kf_holder._yscale = (1/sc) * 91;
		this.$kf_holder.filters = [new DropShadowFilter(3, 90, 0x000000, 50, 3, 3, 1, 3, true)];
	}
	
	public function onKeyFrameResize() {
		var e = new org.caleb.event.Event('onKeyFrameResized');
		this.dispatchEvent(e);
	}
}
