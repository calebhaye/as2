import org.caleb.movieclip.ObservableMovieClip;

/**
 * 
 * @see     CoreMovieClip	
 */
class org.caleb.loader.DynamicPreloader extends ObservableMovieClip
{
	public static var BOX_LINE_COLOR:Number = 0xCCCCCC;
	public static var BOX_FILL_COLOR:Number = 0x660066;
	public static var BAR_WIDTH:Number = 130;
	public static var BAR_HEIGHT:Number = 3;
	public static var BAR_X = 0;
	public static var BAR_Y = 0;

	private var $boxLineColor:Number;
	private var $boxFillColor:Number;
	private var $barWidth:Number;
	private var $barHeight:Number;
	private var $barXPosition;
	private var $barYPosition;

	private var $monitorInterval:Number;
	private var $barHolder:MovieClip;
	private var $swfLoadingBar:MovieClip;
	private var $swfLoadingBarBox:MovieClip;
	private var $swfURL:String;
	private var $swf:MovieClip;
	private var $loaded:Number;
	private var $total:Number;
	private var $percent:Number;

	private var $loadCompleteInvoked:Boolean;
	private var $context:MovieClip;
	private var $supressOutput:Boolean;
	
	/**
	 * 
	 * @param   b 
	 */
	public function set supressOutput(b:Boolean):Void
	{
		this.$supressOutput = b;
	}
	/**
	 * 
	 * @param   target 
	 * @param   id     
	 */
	public function DynamicPreloader(target:MovieClip, id:String)
	{
		this.setClassDescription('org.caleb.loader.DynamicPreloader');
		this.addEventObserver(this, 'onLoadComplete');
		//trace("constructor invoked w/ id: " + id);
		// we are the default context
		this.$context = this;
		// load my content ...
		this.$swf = target.createEmptyMovieClip(id, target.getNextHighestDepth());
		// ... into an empty clip
		$barHolder =  target.createEmptyMovieClip("$barHolder", target.getNextHighestDepth());
		// defaults
		this.$boxLineColor = BOX_LINE_COLOR;
		this.$boxFillColor = BOX_FILL_COLOR;
		this.$barWidth = BAR_WIDTH;
		this.$barHeight = BAR_HEIGHT;
		this.$barXPosition = BAR_X;
		this.$barYPosition = BAR_Y;
	}
	/**
	 * 
	 * @param   loader 
	 */
	public function monitorProgress(loader:DynamicPreloader)
	{
		//trace('[org.caleb.loader.DynamicPreloader] monitorProgress running');
		loader.swfProgressBarRun(loader.$swf);
		loader.removeSWFBar();
		loader.monitorLoad();
	//	swfSquash();
	//	swfCenter();
		loader.fadeSWFIn(loader.$swf);
	}
	// public load method
	/**
	 * 
	 * @param   url  
	 * @param   barX 
	 * @param   barY 
	 */
	public function doLoad(url:String,barX:Number,barY:Number):Void 
	{
		//trace("doLoad invoked w/ url: "+url);
		$barXPosition = barX;
		$barYPosition = barY;
		$swfURL = url;
		swfLoad($swfURL);
		swfProgressBar();
	}
	/**
	 * 
	 * @param   context 
	 */
	public function onLoadComplete(context:MovieClip):Void
	{
		//trace('onLoadComplete invoked w/ context: ' + context);
	}
	public function onIntroComplete():Void
	{
		// //trace('onIntroComplete invoked');
	}
	/*
	* READ / WRITE ONLY PROPERTIES
	*/
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get context():MovieClip
	{
		return this.$context;
	}
	/**
	 * 
	 * @param   mc 
	 */
	public function set context(mc:MovieClip):Void
	{
		this.$context = mc;
	}	
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get monitorInterval():Number
	{
		return this.$monitorInterval;
	}
	/**
	 * 
	 * @usage   
	 * @param   n 
	 * @return  
	 */
	public function set monitorInterval(n:Number):Void
	{
		this.$monitorInterval = n;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get boxLineColor():Number
	{
		return this.$boxLineColor;
	}
	/**
	 * 
	 * @usage   
	 * @param   n 
	 * @return  
	 */
	public function set boxLineColor(n:Number):Void
	{
		this.$boxLineColor = n;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get boxFillColor():Number
	{
		return this.$boxFillColor;
	}
	/**
	 * 
	 * @usage   
	 * @param   n 
	 * @return  
	 */
	public function set boxFillColor(n:Number):Void
	{
		this.$boxFillColor = n;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get barWidth():Number
	{
		return this.$barWidth;
	}
	/**
	 * 
	 * @usage   
	 * @param   n 
	 * @return  
	 */
	public function set barWidth(n:Number):Void
	{
		this.$barWidth = n;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get barHeight():Number
	{
		return this.$barHeight;
	}
	/**
	 * 
	 * @usage   
	 * @param   n 
	 * @return  
	 */
	public function set barHeight(n:Number):Void
	{
		this.$barHeight = n;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get barXPosition():Number
	{
		return this.$barXPosition;
	}
	/**
	 * 
	 * @usage   
	 * @param   n 
	 * @return  
	 */
	public function set barXPosition(n:Number):Void
	{
		this.$barXPosition = n;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get barYPosition():Number
	{
		return this.$barYPosition;
	}
	/**
	 * 
	 * @usage   
	 * @param    
	 * @return  
	 */
	public function set barYPosition(n:Number):Void
	{
		this.$barYPosition = n;
	}

	/*
	* READ ONLY PROPERTIES
	*/
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get supressOutput():Boolean
	{
		return this.$supressOutput;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get barHolder():MovieClip
	{
		return this.$barHolder;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get swfLoadingBar():MovieClip
	{
		return this.$swfLoadingBar;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get swfLoadingBarBox():MovieClip
	{
		return this.$swfLoadingBarBox;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get swfURL():String
	{
		return this.$swfURL;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get swf():MovieClip
	{
		return this.$swf;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get loadComplete():Boolean
	{
		return (this.$swf.getBytesLoaded() == this.$swf.getBytesTotal() && this.$swf._alpha < 100 && this.$swf._width>0) 
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get loadedBytes():Number
	{
		return $loaded;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get totalBytes():Number
	{
		return $total;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get loadedRatio():Number
	{
		return $percent;
	}

	private function swfLoad(url) 
	{
		//trace('');
		//trace('swfLoad invoked');
		//trace('url: '+url);
		//trace('$swf :'+$swf);
		//trace('');
		this.$monitorInterval = setInterval(this.monitorProgress, 100, this)
		this.$loadCompleteInvoked = false;
		this.$swf._alpha = 0;
		if(this.$swf != undefined)
		{
			this.$swf.loadMovie(url);
		}
	}

	private function swfProgressBar() 
	{
		//trace("swfProgressBar invoked");
		if ($barHeight<5) 
		{
			$barHeight = 5;
		}
		//bar
		//trace('$barWidth: '+$barWidth)
		$swfLoadingBar = $barHolder.createEmptyMovieClip("$swfLoadingBar", $barHolder.getNextHighestDepth());
		$swfLoadingBar.lineStyle(.25, $boxLineColor, 0);
		$swfLoadingBar.beginFill($boxFillColor, 100);
		$swfLoadingBar.lineTo($barWidth, 1);
		$swfLoadingBar.lineTo($barWidth, $barHeight);
		$swfLoadingBar.lineTo(1, $barHeight);
		$swfLoadingBar.lineTo(1, 1);
		$swfLoadingBar.endFill();
		$swfLoadingBar._xscale = 0;
		//box
		$swfLoadingBarBox = $barHolder.createEmptyMovieClip("$swfLoadingBarBox", $barHolder.getNextHighestDepth());
		$swfLoadingBarBox.lineStyle(.25, $boxLineColor, 100);
		$swfLoadingBarBox.lineTo($barWidth, 0);
		$swfLoadingBarBox.lineTo($barWidth, $barHeight);
		$swfLoadingBarBox.lineTo(0, $barHeight);
		$swfLoadingBarBox.lineTo(0, 0);
		// uncomment the following 2 lines to position the bar dynamically
		// relative to the size of the $swf being $loaded
		// $swfLoadingBarBox._x = $swfLoadingBar._x=$swf._x/2;
		// $swfLoadingBarBox._y = $swfLoadingBar._y=$swf._y/2;
		// uncomment the following 2 lines to position the bar statically
		$swfLoadingBarBox._x = $swfLoadingBar._x = $barXPosition;//105;
		$swfLoadingBarBox._y = $swfLoadingBar._y = $barYPosition;//150;
	}
	
	/**
	 * 
	 * @param   mc 
	 */
	public function swfProgressBarRun(mc:MovieClip) 
	{
		$loaded = mc.getBytesLoaded()/1024;
		$total = mc.getBytesTotal()/1024;
		$percent = ($loaded/$total) * 100;
		////trace("[org.caleb.loader.DynamicPreloader] monitorProgress $loaded:"+$loaded);
		/*
		$barHolder.txtLoading.text = "Loading " 
										 + Math.round($percent)
										 + "%";
		*/
		var xScale:Number = (mc.getBytesLoaded() / mc.getBytesTotal()) * 100;
		if(xScale > 0)
		{
			$swfLoadingBar._xscale = xScale;
		}
		// //trace('$swfLoadingBar._xscale = '+(mc.getBytesLoaded() / mc.getBytesTotal()) * 100);
		
		//todo - implement this customization hack better
		_parent.loadFill._yscale = (mc.getBytesLoaded() / mc.getBytesTotal()) * 100;
		_parent.loadFill2._yscale = (mc.getBytesLoaded() / mc.getBytesTotal()) * 100;
	}
	
	private function removeSWFBar() 
	{
		if ($swfLoadingBar._xscale>=100) 
		{
			$barHolder.txtLoading.text = "";
			$swfLoadingBar.removeMovieClip();
			$swfLoadingBarBox.removeMovieClip();
		}
	}

	private function alphaFullCheck()
	{
		return (this.$swf._alpha >= 100);
	}
	private function monitorLoad()
	{
		if(this.loadComplete == true && this.$loadCompleteInvoked == false)
		{
			this.dispatchEvent(new org.caleb.event.Event('onLoadComplete'));
			this.$loadCompleteInvoked = true;
		}
	}
	// Begin Fading functions
	private function fadeSWFIn(mc) 
	{
		if(this.alphaFullCheck() == true)
		{
			this.onIntroComplete();
			clearInterval(this.$monitorInterval);
		}
		if (mc.getBytesLoaded() == mc.getBytesTotal() && mc._alpha < 100 && mc._width>0) 
		{
			if (mc._alpha<100) 
			{
				mc._alpha += 10;
			}
		}
	}
	private function loadOut(mc):Void
	{
		mc._alpha -= 10;
	}
	// End Fading functions

	public function swfCenter():Void
	{
		if ($swf._width > 0) 
		{
			var pIX = $swf._x;
			var pIY = $swf._y;
			$swf._x = pIX + ($swf._width)/2;
			$swf._y = pIY + ($swf._height)/2;
		}
	}
}