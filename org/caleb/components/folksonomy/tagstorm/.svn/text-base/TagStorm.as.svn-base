import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.components.scrubber.Scrubber;
import org.caleb.components.folksonomy.tagstorm.TagStormKeyFrame;
import flash.display.BitmapData;
class org.caleb.components.folksonomy.tagstorm.TagStorm extends ObservableMovieClip {
	private var $bg:MovieClip;
	private var $scrubber:Scrubber;
	private var $scrubbablewidth:Number;
	private var $position:Number;
	private var $si:Number;
	private var $tags:Array;
	private var $tagholder:MovieClip;
	private var $thumbnails:Array;
	private var $proxy:MovieClip;
	private var $proxy_cursor:Number;
	private var $mask:MovieClip;
	
	private var $maxval:Number;
	
	static var MIN_THUMB_SCALE:Number = 20;
	static var MAX_THUMB_SCALE:Number = 60;
	
	static var MIN_THUMB_ALPHA:Number = 20;
	static var MAX_THUMB_ALPHA:Number = 100;
	
	static var MAX_THUMB_FONTSIZE:Number = 100;
	static var MIN_THUMB_FONTSIZE:Number = 10;
	
	static var TIME_THRESHOLD = .1;
	
	public function TagStorm() {}
	public function init() {
		super();
		this.$initScrubber();
	}
	private function $initScrubber() {
		this.$scrubber.position = 0;
		this.$scrubber.height = this.$bg.height;
		this.$scrubber.width = 10;
		this.$scrubber.totalwidth = this.$bg._width;
		this.$scrubbablewidth = this.$bg._width - this.$scrubber.width;
		this.$addScrubberEvents()
		this.$scrubber.init();
	}
	private function $addScrubberEvents() {
		this.$scrubber.addEventObserver(this, 'onScrubberPressed');
		this.$scrubber.addEventObserver(this, 'onScrubberReleased');
	}
		
	private function $removeScrubberEvents() {
		this.$scrubber.removeEventObserver(this, 'onScrubberPressed');
		this.$scrubber.removeEventObserver(this, 'onScrubberReleased');
	}
	
	public function setTags(linkage_name, arr:Array, maxval:Number) {
		trace('setTags invoked w/ tags: ' + arr)
		this.$tags = arr;
		this.$maxval = maxval;
		this.$tagholder = this.createEmptyMovieClip('$tagholder', this.getNextHighestDepth());
		this.$tagholder.setMask(this.$mask);
		var hasVideo:Boolean = false;

		for(var tag in this.$tags)
		{
			trace('this.$tags[tag].type: ' + this.$tags[tag].type)
			if(this.$tags[tag].type == 'video')
			{
				hasVideo = true;
				break;
			}
		}
		if(hasVideo == true)
		{
			this.$createThumbnails(linkage_name, arr);
		}
		else
		{
			this.$renderTags();
		}
	}
	
	private function $createThumbnails(linkage_name:String, arr:Array):Void {
		//trace('createThumbnails for:'+linkage_name+' arr:'+arr);
		//create a proxy clip off stage to run through and take bitmap shots.
		this.$proxy = this.attachMovie(linkage_name, 'proxy', this.getNextHighestDepth());
		this.$proxy._x = -600;
		this.$proxy_cursor = 0;
		this.$thumbnails = new Array();
		this.onEnterFrame = function() {
			if (this.$proxy_cursor < this.$tags.length) {
				var tf = this.$proxy._totalframes;
				var f = Math.round(arr[this.$proxy_cursor].start * tf)+1;
				this.$proxy.gotoAndStop(f);
				var bm:BitmapData = new BitmapData(this.$proxy._width, this.$proxy._height);
				bm.draw(this.$proxy);
				this.$thumbnails.push(bm);
				this.$proxy_cursor++;
			} else {
				this.$onThumbnailsCreated();
				this.$proxy.stop();
				this.$proxy._visible = false;
				removeMovieClip(this.$proxy);
				delete this.onEnterFrame;
			}
		}
		
		
	}
	
	private function $onThumbnailsCreated(Void):Void {
		this.$renderTags();
	}
	private function $renderTags() {
		trace('render tags invoked w/ tags: ' + this.$tags)
		for (var i=0; i<this.$tags.length; i++) {
			var th = this.$tagholder;
			var t = th.attachMovie('CloudScrubberKeyFrameMC', 'kf_'+i, this.$tagholder.getNextHighestDepth());
			t.mode = this.$tags[i].type;
			t.setBitmap(this.$thumbnails[i]);
			t.maxscale = MAX_THUMB_SCALE;
			t.minscale = MIN_THUMB_SCALE;
			t.maxalpha = MAX_THUMB_ALPHA;
			t.minalpha = MIN_THUMB_ALPHA;
			t.maxfontsize = MAX_THUMB_FONTSIZE;
			t.minfontsize = MIN_THUMB_FONTSIZE;
			t.timethreshold = TIME_THRESHOLD;
			t.scrubbablewidth = this.$scrubbablewidth;
			t.start = this.$tags[i].start;
			t.end = this.$tags[i].end;
			t.value = this.$tags[i].value;
			t.maxval = this.$maxval;
			t.tags = this.$tags[i].tags;
			t._x = this.$bg._width * this.$tags[i].start;
			t._y = this.$tags[i].y * this.$bg._height;
		}
		this.$scrubber.swapDepths(this.getNextHighestDepth());
		this.position = this.$scrubber.position;
	}
	

	
	public function onScrubberPressed(e:org.caleb.event.Event):Void {
		var e1 = new org.caleb.event.Event('onCloudScrubberPressed');
		this.dispatchEvent(e1);
		clearInterval(this.$si);
		this.$si = setInterval(this, 'userMoveScrubber', 100);
	}
	public function onScrubberReleased(e:org.caleb.event.Event):Void {
		var e = new org.caleb.event.Event('onCloudScrubberReleased');
		this.dispatchEvent(e);
		clearInterval(this.$si);
	}

	
	public function userMoveScrubber(Void):Void {
		//move.
		var per = this._xmouse / this.$scrubbablewidth;
		per = Math.min(Math.max(per, 0), 1);
		this.position = per;
		//dispatch event
		var e = new org.caleb.event.Event('onCloudScrubberUpdated');
		e.addArgument('per', per);
		this.dispatchEvent(e);
		
	}
	
	
	public function set position(per:Number):Void {
		this.$scrubber.position = per;
		for(var i=0; i<this.$tags.length; i++) {
			var t = this.$tagholder['kf_'+i];
			t.scrubposition = per;			
		}
	}
	
	
	
	
	
}