import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.application.zoom.ZoomController;
import org.caleb.application.zoom.ZoomView;
import org.caleb.animation.AnimationManager;
import flash.filters.DropShadowFilter;
import flash.geom.Transform;
import flash.geom.Matrix;
import flash.display.BitmapData;

/**
 * 
 * @author  calebh
 * @version 1.0
 * @see     CoreMovieClip	
 * @since   
 */
class org.caleb.application.zoom.ZoomImage extends ObservableMovieClip 
{
	public static var ANIMATED_INTRO:Boolean = false;
	public static var UNLOADED_IMAGES_IN_GRID:Boolean = true;
	public static var LOAD_THUMBS:Boolean = true;
	public static var ROTATE_ON_INTRO:Boolean = false;
	public static var SCALE_USING_BITMAP:Boolean = false;
	public static var ATTACH_ERROR_CLIP:Boolean = true;
	static var MAX_SHADOW:Number = 20;
	static var COLOR_LOAD_ERROR:Number = 0xFF0000;
	static var COLOR_LOAD_STARTED:Number = 0xFFFF00;
	static var COLOR_LOAD_QUEUED:Number = 0x00FF00;
	static var COLOR_LOAD_SUCCESS:Number = 0x666666;
	
	private var $id:Number;
	private var $nextLoaded:Boolean;
	private var $ready:Boolean;
	private var $filename:String;
	private var $baseURL:String;
	private var $thumbURL:String;
	private var $x:Number;
	private var $y:Number;
	private var $pieX:Number;
	private var $pieY:Number;
	private var $imageX:Number;
	private var $imageY:Number;
	private var $httpStatus:Number;
	private var $pieRotation:Number;
	private var $row:Number;
	private var $column:Number;
	private var $loadPercentage:Number;
	private var $loadTarget:MovieClip;
	private var $tempLoader:MovieClip;
	private var $loader:MovieClip;
	private var $movieClipLoader:MovieClipLoader;
	private var $tweenLength:Number;
	private var $maximumRotation:Number;
	private var $originalRotation:Number;
	private var $controller:ZoomController;
	private var $view:ZoomView;
	private var $zoomButton:MovieClip;
	private var $imageLoadFailed:Boolean;
	private var $imageIntroComplete:Boolean;
	private var $animationManager:AnimationManager;
	private var $frame:MovieClip;
	private var $errorClip:MovieClip;
	private var $textContainer:MovieClip;
	private var $imageLoadProgress:TextField;
	private var $loadTimeout:Number;
	private var $loadStarted:Boolean;
	private var $loadAttempted:Boolean;
	private var $dropshadow:Number;
	
	public function ZoomImage()
	{
		this.setClassDescription('org.caleb.application.zoom.ZoomImage');
		//trace('constructor invoked');
		// defaults
		this.$tweenLength = 15;
		this.$maximumRotation = 25;
		this.$dropshadow = 0;
		this.$baseURL = new String;
		this.$animationManager = new AnimationManager(this);
		this.$loader = this.createEmptyMovieClip("$loader", this.getNextHighestDepth());
		this.$movieClipLoader = new MovieClipLoader;
		this.$movieClipLoader.addListener(this);
	}
	
	//@arg: (0-1)
	public function set dropshadow(arg:Number) {
		trace('dropshadow:'+arg);
		this.$dropshadow = arg;
		var p = arg / 100;
		this.filters = [new DropShadowFilter(0, 90, 0x000000, 100, MAX_SHADOW*p, MAX_SHADOW*p, 1, 1)];
	}
	
	public function get dropshadow():Number {
		return this.$dropshadow;
	}
	
	private function setupHandlers():Void
	{
		this.onRelease = this.onReleaseHandler;
		this.onReleaseOutside = this.onReleaseHandler;
		this.onRollOut = this.onRollOutHandler;
		this.onRollOver = this.onRollOverHandler;
	}
	/**
	 * 
	 * @usage   
	 * @param   imageId        
	 * @param   imageFile      
	 * @param   imageX         
	 * @param   imageY         
	 * @param   controller 
	 * @param   view           
	 * @return  
	 */
	 // todo: add thumbURL:String to method signature
	public function init(imageId:Number, imageFile:String, imageX:Number, imageY:Number, controller:ZoomController, view:ZoomView)
	{
		this.$ready = false;
		this.$imageIntroComplete = false;
		this.setupHandlers();
		this.$loadAttempted = false;
		this.$controller = controller;				
		this.$view = view;
		this.$id = imageId;
		this.$thumbURL = thumbURL;		
		this.$filename = imageFile;		
		//trace('init invoked, w/ id: ' + imageId)
		// update private members
		//this.$frame = org.caleb.util.DrawingUtil.drawRoundedRectangle(this, this.$controller.width/(this.$controller.maxRows * this.$controller.columns), this.$controller.width/(this.$controller.maxRows * this.$controller.columns), 4, 0xFFFFFF, 100, 0, 0xFFFFFF, 100, 'newRoundedRectangle', this.getNextHighestDepth());
		if(this.$frame != undefined)
		{
			this.$frame.removeMovieClip();
		}
		this.$frame = org.caleb.util.DrawingUtil.drawRoundedRectangle(this, 35, 35, 0, 0xFFFFFF, 100, 0, 0xFFFFFF, 100, 'newRoundedRectangle', this.getNextHighestDepth());
		this.centerClip(this.$frame);
		this.$frame._visible = false;
		
		this.$textContainer = this.createEmptyMovieClip('$textContainer', this.getNextHighestDepth())
		this.$textContainer._visible = false;
		this.$imageLoadProgress = this.$textContainer.createTextField('txt', this.$textContainer.getNextHighestDepth(), 0, 0, 600, 100);
		this.$imageLoadProgress.embedFonts = true;
		this.$imageLoadProgress.autoSize = false;
		this.$imageLoadProgress.background = false;
		var fmt:TextFormat = new TextFormat;
		fmt.align = 'center';
		fmt.size = 50;
		fmt.color = 0xFFFFFF;
		fmt.font = 'gothamBoldExported';
		this.$imageLoadProgress.setNewTextFormat(fmt);
		this.centerClip(this.$textContainer);
		this.$imageLoadProgress._y -= 100;
		//this._x = imageId * this._width;
		//this._y = 0;
		this.$row = Math.floor(this.$id / this.$controller.columns);
		this.$column = Math.floor(this.$id - (this.$row*this.$controller.columns))
		//trace('this.$row: '+this.$row)
		//trace('this.$column: '+this.$column)
		
		this.$imageX = imageX;
		this.$imageY = imageY;
		
		if(UNLOADED_IMAGES_IN_GRID == true)
		{
			this._x = this.$controller.launchX * this.$controller.initialScale;
			this._y = this.$controller.launchY * this.$controller.initialScale;
			this.$x = this.$imageX;
			this.$y = this.$imageY;
		}
		else
		{
			this._x = this._width * this.$id;
		}
		if(UNLOADED_IMAGES_IN_GRID == true)
		{
			this.intro();
		}
		else
		{
			this.load();
		}
		this.addEventObserver(this.$view, 'onZoomImageRollOver');
		this.addEventObserver(this.$view, 'onZoomImageRollOverTweenComplete');
		this.addEventObserver(this.$view, 'onZoomImageRollOut');
		this.addEventObserver(this.$view, 'onZoomImageRollOutTweenComplete');
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function load():Void
	{
		if(this.$loadAttempted == false || this.$loadTimeout == false)
		{
			this.$imageLoadProgress.text = 'WAITING FOR SERVER';
			this.$loadAttempted = true;
			
			if(this.$loader._width > 0 && this.$loader._height > 0)
			{
				this.$tempLoader.removeMovieClip();
				this.$tempLoader = this.createEmptyMovieClip("$tempLoader", this.getNextHighestDepth());
				this.$loadTarget = this.$tempLoader;
				this.$imageIntroComplete = false;
			}
			else
			{
				this.$loadTarget = this.$loader;
			}
			
			trace(this.toString().concat(': ').concat(LOAD_THUMBS))
			if(LOAD_THUMBS)
			{
				this.$movieClipLoader.loadClip(this.$baseURL + this.$thumbURL, this.$loadTarget);
			}
			else
			{
				this.$movieClipLoader.loadClip(this.$baseURL + this.$filename, this.$loadTarget);
			}
			_global.setTimeout(this, 'load', 250);
		}
	}
	public function gotoOriginalPosition(speed:Number):Void
	{
		//trace('gotoOriginalPosition invoked');
		if(isNaN(speed)) 
		{
			speed = this.$tweenLength/50;
		}
		var tweenProperties:Array = new Array('_x', '_y', '_rotation');
		var tweenEndValues:Array = new Array(this.$x, this.$y, this.$view.imageRotationMap[this.$id]);
		var tweenHandler:Array = new Array(this, 'onGotoOriginalPositionTweenComplete');
		this.$animationManager.tween(tweenProperties, tweenEndValues, speed, ZoomController.DEFAULT_EASE_TYPE, 0, tweenHandler, 10, 5);
	}
	public function onReleaseOutsideHandler():Void
	{
		this.onRollOut();
	}
	public function onReleaseHandler()
	{
		trace('releaseHandler invoked w/ this.$ready: '+this.$ready);
		if(this.$ready == true)
		{
			if (this.$controller.currentId == this.id && this.controller.zoomedIn)
			{
				this.view.controller.zoomOut();
				for(var i in this.view.thumbs)
				{
					this.view.thumbs[i].gotoOriginalPosition();
				}
			}
			else
			{
				var tweenProperties:Array = new Array('_xscale', '_yscale');
				var tweenEndValues:Array = new Array(100, 100);
				var tweenHandler:Array = new Array(this, 'onGotoOriginalPositionTweenComplete');
				this.$animationManager.tween(tweenProperties, tweenEndValues, this.$tweenLength/50, ZoomController.DEFAULT_EASE_TYPE, 0, tweenHandler, 10, 5);
				this.zoomIn();				
			}
		}
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onRollOverHandler()
	{
		//trace('rolloverHandler invoked on: '+this);
		var e:org.caleb.event.Event = new org.caleb.event.Event('onZoomImageRollOver');
		e.addArgument('image', this);
		this.dispatchEvent(e)
		
		if(this.view.controller.zoomedIn == false)
		{
			var tweenProperties:Array = new Array('_xscale', '_yscale', '_alpha');
			//var tweenEndValues:Array = new Array(150, 150, 75);
			var tweenEndValues:Array = new Array(150, 150, 100);
			var tweenHandler:Array = new Array(this, 'onRollOverTweenComplete');
			this.$animationManager.tween(tweenProperties, tweenEndValues, this.$tweenLength/75, ZoomController.DEFAULT_EASE_TYPE, 0, tweenHandler, .51);
			this.swapDepths(this._parent.getNextHighestDepth());
		}
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onRollOutHandler()
	{
		//trace('rolloutHandler invoked');
		var e:org.caleb.event.Event = new org.caleb.event.Event('onZoomImageRollOut');
		e.addArgument('image', this);
		this.dispatchEvent(e)

		if(this.view.controller.zoomedIn == false)
		{
			var tweenProperties:Array;
			var tweenEndValues:Array;
			if(ROTATE_ON_INTRO)
			{
				tweenProperties = new Array('_xscale', '_yscale', '_rotation', '_alpha');
				//tweenEndValues = new Array(100, 100, this.view.imageRotationMap[this.id], 35);
				tweenEndValues = new Array(100, 100, this.view.imageRotationMap[this.id], 100);
			}
			else
			{
				tweenProperties = new Array('_xscale', '_yscale', '_alpha');
				//tweenEndValues = new Array(100, 100, 35);
				tweenEndValues = new Array(100, 100, 100);
			}
			var tweenHandler:Array = new Array(this, 'onRollOutTweenComplete');
			this.$animationManager.tween(tweenProperties, tweenEndValues, this.$tweenLength/50, ZoomController.DEFAULT_EASE_TYPE, 0, tweenHandler);
		}
	}
	private function onRollOutTweenComplete():Void
	{
		var e:org.caleb.event.Event = new org.caleb.event.Event('onZoomImageRollOutTweenComplete');
		e.addArgument('image', this);
		this.dispatchEvent(e)
	}
	private function onGotoOriginalPositionTweenComplete():Void
	{
		var e:org.caleb.event.Event = new org.caleb.event.Event('onGotoOriginalPositionTweenComplete');
		e.addArgument('image', this);
		this.dispatchEvent(e)
	}
	private function onRollOverTweenComplete():Void
	{
		var e:org.caleb.event.Event = new org.caleb.event.Event('onZoomImageRollOverTweenComplete');
		e.addArgument('image', this);
		this.dispatchEvent(e)
	}
	public function zoomIn():Void
	{
		trace('zoomIn invoked, $id = ' + $id);
		this.$controller.currentId = this.$id;
		//trace('this.$controller.currentId: ' + this.$controller.currentId);
		this.$controller.zoomIn(this.$x, this.$y);
	}
	private function onLoadComplete(target:MovieClip, httpStatus:Number):Void
	{
		this.$httpStatus = httpStatus;
	}
	private function onLoadStart(target:MovieClip):Void
	{
		if(LOAD_THUMBS == false)
		{
			this.$loadStarted = true;
			this.$view.displayCurrentItemDetails();
		}
		else
		{
			this.$loadStarted = false;
		}
	}
	private function onLoadError(target:MovieClip, errorCode:String, httpStatus:Number):Void
	{
		trace('onLoadError invoked')
		this.$httpStatus = httpStatus;
		_global.clearTimeout(this.$loadTimeout)
		this.$imageLoadFailed = true;
		//this.introImage();
		//this.setupErrorFrame();
		this.loadNext();
		this.onLoadAttemptComplete();
		this.frameColor = COLOR_LOAD_ERROR;
		//newFrame._x = this.$frame._x - this.$loader._x;
		//newFrame._y = this.$frame._y - this.$loader._y;
		//trace('newFrame: ' + newFrame)
		//trace('newFrame.getDepth(): ' + newFrame.getDepth())
		//trace('this.$loader: ' + this.$loader)
		//trace('this.$loader.getDepth(): ' + this.$loader.getDepth())
	}
	private function onLoadInit(target:MovieClip):Void
	{
		// trace('onLoadInit: ' + this.$id)
		if(this.$imageIntroComplete == false)
		{
			this.$imageLoadProgress._visible = false;
			if(this.$loadTarget._width > 0 && this.$loadTarget._height > 0)
			{
				if(this.$loadTarget != this.$loader)
				{
					this.$loader.removeMovieClip();
					this.$loader = this.$tempLoader;
				}
				//trace('onLoadInit invoked: '+target);
				this.$imageLoadFailed = false;
				this.$loader._visible = false;
				if(UNLOADED_IMAGES_IN_GRID == true)
				{
					this.introImage();
				}
				else
				{
					this.$x = this.$imageX;
					this.$y = this.$imageY;
					this.intro();
				}
				this.loadNext();
				this.$imageIntroComplete = true;
				this.onLoadAttemptComplete();
			}
			else
			{
				this.onLoadError(target, 'error loading image.  most likely a progressive jpg');
			}
		}
		else
		{
			_global.clearTimeout(this.$loadTimeout)
		}
	}
	private function onLoadProgress(target:MovieClip, bytesLoaded:Number, bytesTotal:Number):Void
	{
		this.$loadPercentage = Number(bytesLoaded/bytesTotal);
		if(bytesLoaded < bytesTotal && this.$loadPercentage != Infinity)
		{
			var amountLoaded:String = Number(Math.ceil(this.$loadPercentage * 1000) / 10 ).toString();
			if(isNaN(Number(amountLoaded)) == false)
			{
				if(amountLoaded.length == 2)
				{
					amountLoaded = amountLoaded.concat('.0');
				}
				amountLoaded = amountLoaded.concat('%');
				this.$imageLoadProgress.text = amountLoaded;
			}
		}
		else if(this.$loadPercentage == Infinity)
		{
			this.$loadPercentage = 0;
		}
	}
	public function get loadPercentage():Number
	{
		return this.$loadPercentage;
	}
	private function onLoadAttemptComplete():Void
	{
		this.$controller.loadedImages[this.$id] = this;
		if(LOAD_THUMBS == true)
		{
			this.$view.pieLoader.setSlicePercent(0, (this.$id+1)/this.$view.items.length);
			this.$view.pieLoader.render();
		}
		if(this.$controller.loadedImages.length == this.$view.items.length)
		{
			//trace('telling controller to dispatch onLoadAttemptComplete event');
			this.ready = true;
			this.controller.loadAttemptComplete = true;
		}
	}
	private function loadNext():Void
	{
		if(this.$nextLoaded != true)
		{
			this.$nextLoaded = true;
			if(this.$view.items[this.$id + 1] != undefined)
			{
				if(ZoomImage(this.$view.items[this.$id + 1]).imageIntroComplete == false)
				{
					//trace('ZoomImage(this.$view.items[this.$id + 1]).loadTimeout: ' + ZoomImage(this.$view.items[this.$id + 1]).loadTimeout)
					ZoomImage(this.$view.items[this.$id + 1]).load();
				}
			}
		}
	}
	private function setupImageFrame():Void
	{
		this.$frame.swapDepths(0);
		this.$loader.swapDepths(this.getNextHighestDepth());
		this.setupFrame(this.$loader);
	}
	private function setupErrorFrame():Void
	{
		this.$frame.swapDepths(0);
		this.$loader.swapDepths(this.getNextHighestDepth());
		if(ATTACH_ERROR_CLIP)
		{
			this.$errorClip = this.attachMovie('errorClip', 'errorClip', this.getNextHighestDepth());
			this.$errorClip._visible = false;
			this.setupFrame(this.$errorClip);
		}
	}
	private function setupFrame(clip:MovieClip):Void
	{
		if(this.$imageLoadFailed == true)
		{
			trace('IMAGE LOAD FAILED AND SETUPFRAME INVOKED');
		}
		this.$frame._visible = true;
		this.$animationManager = new AnimationManager(this.$frame);
		var tweenProperties:Array = new Array('_width', '_height', '_x', '_y');
		var targetWidth:Number = (clip._width + this.$controller.frameWidth*2);
		var targetHeight:Number = (clip._height + this.$controller.frameWidth*2);
		var tweenEndValues:Array = new Array(targetWidth, targetHeight, -targetWidth/2, -targetHeight/2);
		this.$animationManager.tween(tweenProperties, tweenEndValues, this.$tweenLength/20, ZoomController.DEFAULT_EASE_TYPE);

		this.$animationManager = new AnimationManager(this);
	}
	public function introImage():Void
	{
		//trace('introImage invoked')
		var targetWidth:Number;
		var targetHeight:Number;
		var targetXScale:Number;
		var targetYScale:Number;
		if(this.$imageLoadFailed)
		{
			if(ATTACH_ERROR_CLIP)
			{
				targetWidth = (this.$errorClip._width + this.$controller.frameWidth*2);
				targetHeight = (this.$errorClip._height + this.$controller.frameWidth*2);
				targetXScale = 100;
				targetYScale = 100;
				this.$errorClip._visible = true;
				this.$errorClip._yscale = 0;
				this.$errorClip._xscale = 0;
				this.$animationManager = new AnimationManager(this.$errorClip);
			}
		}
		else 
		{
			targetWidth = (this.$loader._width + this.$controller.frameWidth*2);
			targetHeight = (this.$loader._height + this.$controller.frameWidth*2);
			targetXScale = 100;
			targetYScale = 100;
			if(targetWidth > this.$view.stageWidth/2 || targetHeight > this.$view.stageHeight/2)
			{
				if(SCALE_USING_BITMAP)
				{
					var b:BitmapData = org.caleb.util.BitmapUtil.getMovieClipSnapshot(this.$loader, 0, 0, this.$loader._width, this.$loader._height);
					this.$loader.removeMovieClip();
					
					this.$loader = this.createEmptyMovieClip('$loader', this.getNextHighestDepth());
					this.$loader.attachBitmap(b, this.$loader.getNextHighestDepth());
					var trans:Transform = new Transform(this.$loader);
					//var foo:MovieClip = _root.createEmptyMovieClip('foo', _root.getNextHighestDepth());
					//foo.attachBitmap(b, foo.getNextHighestDepth());
					//var trans:Transform = new Transform(foo);
					var mutationDetails:Object = this.getBitmapScale(b);
					var scaleMatrix:Matrix = new Matrix;
					/*
					trace('mutationDetails.scalePercentage: ' + mutationDetails.scalePercentage)
					trace('mutationDetails.widthExceedsHeight: ' + mutationDetails.widthExceedsHeight)
					trace('mutationDetails.difference: ' + mutationDetails.difference)
					trace('mutationDetails.width: ' + mutationDetails.width)
					trace('mutationDetails.height: ' + mutationDetails.height)
					trace('b.height: ' + b.height)
					trace('b.width: ' + b.width)
					trace('');
					*/
					scaleMatrix.scale(mutationDetails.scalePercentage, mutationDetails.scalePercentage);
					targetXScale = mutationDetails.scalePercentage * 100;
					targetYScale = mutationDetails.scalePercentage * 100;
					trans.matrix = scaleMatrix;
				}
				else
				{
					this.shrink(this.$loader);
					targetXScale = this.$loader._xscale;
					targetYScale = this.$loader._yscale;
				}
				targetWidth = (this.$loader._width + this.$controller.frameWidth*2);
				targetHeight = (this.$loader._height + this.$controller.frameWidth*2);
			}
			this.setupImageFrame();
			//trace('targetWidth: ' + targetWidth);
			//trace('targetHeight: ' + targetHeight);
			//trace('');
			this.$loader._visible = true;
			this.$loader._yscale = 0;
			this.$loader._xscale = 0;
			this.$loader._width = this.$frame._width;
			this.$loader._height = this.$frame._height;
			centerClip(this.$loader)
			this.$animationManager = new AnimationManager(this.$loader);
		}
		
		if(targetHeight > 0 && targetWidth > 0)
		{
			var tweenProperties:Array = new Array('_xscale', '_yscale', '_x', '_y');
			var tweenEndValues:Array = new Array(targetXScale,targetYScale,(-targetWidth/2)+this.$controller.frameWidth, (-targetHeight/2)+this.$controller.frameWidth);
			this.$animationManager.tween(tweenProperties, tweenEndValues, this.$tweenLength/20, ZoomController.DEFAULT_EASE_TYPE, 0, [this, 'onImageFrameSetupComplete']);

			this.$animationManager = new AnimationManager(this);
		}
	}
	public function centerClip(mc:MovieClip):Void
	{
		mc._x = -mc._width/2;
		mc._y = -mc._height/2;		
	}
	private function intro():Void
	{
		var targetRotation:Number;
		if(ROTATE_ON_INTRO == true)
		{
			targetRotation = (Math.random() * this.$maximumRotation - this.$maximumRotation / 2);
		}
		else
		{
			targetRotation = 0;
		}
		// setup tweens
		var tweenProperties:Array = new Array('_x', '_y', '_alpha', '_rotation');
		//var tweenEndValues:Array = new Array(this.$x, this.$y, 35, 360 + targetRotation);
		var tweenEndValues:Array = new Array(this.$x, this.$y, 100, 360 + targetRotation);
		var tweenHandler:Array = new Array(this, 'onIntroComplete');
		//trace('intro: ' + this.$id)
		if(ANIMATED_INTRO)
		{
			this.$animationManager.tween(tweenProperties, tweenEndValues, this.$tweenLength/10, ZoomController.DEFAULT_EASE_TYPE, this.$id/15, tweenHandler);
		}
		else
		{
			this._x = tweenEndValues[0];
			this._y = tweenEndValues[1];
			this._alpha = tweenEndValues[2];
			this._rotation = tweenEndValues[3];
			// invoked handler (onIntroComplete)
			tweenHandler[0][tweenHandler[1]]();
		}
		// update image rotation map
		this.$originalRotation = targetRotation;
		view.imageRotationMap[this.$id] = this.$originalRotation;
	}	
	private function shrink(mc:MovieClip):MovieClip
	{
		//trace('shrink invoked, mc = ' + mc);
		var widthExceedsHeight:Boolean = (mc._width > mc._height);

		var difference:Number;
		var scalePercentage:Number;
		var scaleWidthAmount:Number;
		var scaleHeightAmount:Number;

		if(widthExceedsHeight == true)
		{
			// scale to width
			difference = mc._width - this.$view.stageWidth/2;
			scalePercentage = difference / mc._width;
		}
		else
		{
			// scale to height
			difference = mc._height - this.$view.stageHeight/2;
			scalePercentage = difference / mc._height;
		}
		scaleWidthAmount = scalePercentage * mc._width;
		scaleHeightAmount = scalePercentage * mc._height;
		
		mc._width -= scaleWidthAmount;
		mc._height -= scaleHeightAmount;
		
		return mc;
	}
	private function getBitmapScale(bitmap:BitmapData):Object
	{
		var o:Object = new Object;
		//trace('shrink invoked, mc = ' + mc);
		var widthExceedsHeight:Boolean = (bitmap.width > bitmap.height);

		var difference:Number;
		var scalePercentage:Number;
		var scaleWidthAmount:Number;
		var scaleHeightAmount:Number;

		if(widthExceedsHeight == true)
		{
			// scale to width
			difference = bitmap.width - this.$view.stageWidth/2;
			scalePercentage = difference / bitmap.width;
		}
		else
		{
			// scale to height
			difference = bitmap.height - this.$view.stageHeight/2;
			scalePercentage = difference / bitmap.height;
		}
		scaleWidthAmount = scalePercentage * bitmap.width;
		scaleHeightAmount = scalePercentage * bitmap.height;

		o.widthExceedsHeight = widthExceedsHeight;
		o.width = bitmap.width - scaleWidthAmount;
		o.height = bitmap.height - scaleHeightAmount;
		o.scaleWidthAmount = scaleWidthAmount;
		o.scaleHeightAmount = scaleHeightAmount;
		o.scalePercentage = 1 - scalePercentage;
		o.difference = difference;
		
		return o;
	}
	public function onImageFrameSetupComplete():Void
	{
	}
	public function onIntroComplete():Void
	{
		//trace('onIntroComplete invoked');
		if(UNLOADED_IMAGES_IN_GRID == true)
		{
			this.setLoadTimeout();
		}
		else
		{
			this.introImage();
		}
	}
	public function setLoadTimeout():Void
	{
		if(this.$loadAttempted == false)
		{
			if(LOAD_THUMBS == true)
			{
				if(this.$id == 0)
				{
					this.load();
				}
			}
			else
			{
				this.$loadTimeout = _global.setTimeout(this, 'load', (this.$row*2000) + (this.$column*250))
			}
			
		}
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get view():ZoomView
	{
		return this.$view;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get controller():ZoomController
	{
		return this.$controller;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get id():Number
	{
		return this.$id;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get originalRotation():Number
	{
		return this.$originalRotation;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get tweenLength():Number
	{
		return this.$tweenLength;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get loadTimeout():Number
	{
		return this.$loadTimeout;
	}
	public function get imageIntroComplete():Boolean
	{
		return this.$imageIntroComplete;
	}
	public function set imageIntroComplete(arg:Boolean):Void
	{
		this.$imageIntroComplete = arg;
	}
	
	public function get imageLoadFailed():Boolean
	{
		return this.$imageLoadFailed;
	}
	public function get loadStarted():Boolean
	{
		return this.$loadStarted;
	}
	public function get filename():String
	{
		return this.$filename;
	}
	public function get loadTarget():MovieClip
	{
		return this.$loadTarget;
	}
	public function get thumbURL():String
	{
		return this.$thumbURL;
	}
	public function set thumbURL(arg:String):Void
	{
		this.$thumbURL = arg;
	}
	public function get pieRotation():Number
	{
		return this.$pieRotation;
	}
	public function set pieRotation(arg:Number):Void
	{
		this.$pieRotation = arg;
	}
	public function get pieX():Number
	{
		return this.$pieX;
	}
	public function set pieX(arg:Number):Void
	{
		this.$pieX = arg;
	}
	public function get pieY():Number
	{
		return this.$pieY;
	}
	public function set pieY(arg:Number):Void
	{
		this.$pieY = arg;
	}
	public function set loadAttempted(arg:Boolean):Void
	{
		this.$loadAttempted = arg;
	}
	public function set x(arg:Number):Void
	{
		this.$x = arg;
	}
	public function set y(arg:Number):Void
	{
		this.$y = arg;
	}
	public function get ready():Boolean
	{
		return this.$ready;
	}
	public function set ready(arg:Boolean):Void
	{
		this.$ready = arg;
	}
	public function get row():Number
	{
		return Math.floor(this.$id / this.$controller.columns);
	}
	public function get column():Number
	{		return Math.floor(this.$id - (this.row * this.$controller.columns));
	}
	public function set frameColor(arg:Number):Void
	{
		var newFrame:MovieClip = org.caleb.util.DrawingUtil.drawRectangle(this, this.$frame._width, this.$frame._height, 0, 0, 0, arg, arg);
		newFrame._x = this.$frame._x;
		newFrame._y = this.$frame._y;
		newFrame._alpha = 0;
		org.caleb.util.MovieClipUtil.fadeIn(newFrame, 1);
		//this.$frame.removeMovieClip();
		this.$frame = newFrame;
		this.$frame.swapDepths(this.$loader)
	}
}