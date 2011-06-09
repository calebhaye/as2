import org.caleb.application.zoom.search.ZoomSearchList;
import org.caleb.movieclip.CoreMovieClip;
import org.caleb.application.zoom.ZoomController;
import org.caleb.application.zoom.ZoomImage;
import org.caleb.application.zoom.ZoomImageHeader;
import org.caleb.animation.AnimationManager;
import org.caleb.components.charting.PieChart;
/**
 * 
 * @author  calebh
 * @version 1.0
 * @see     CoreMovieClip	
 * @since   
 */
class org.caleb.application.zoom.ZoomView extends CoreMovieClip
{
	public static var USE_FILTERS:Boolean = false;
	public static var AUTO_LOAD_MAIN_IMAGES:Boolean = false;
	public static var RESIZE_INTERVAL:Number = 300;
	public static var LOADER_INDEX_FRAMES:Number = 0;
	public static var LOADER_INDEX_THUMBS:Number = 1;
	public static var LOADER_INDEX_IMAGES:Number = 2;
	private var $animationManager:AnimationManager;
	private var $intro:MovieClip;
	private var $thumbs:MovieClip;
	private var $thumbsMask:MovieClip;
	private var $items:Array;
	private var $imageRotationMap:Array;
	private var $random:Boolean;
	private var $locked:Boolean;
	private var $loadedMainImage:Boolean;
	private var $controller:ZoomController;
	private var $stageWidth:Number;
	private var $stageHeight:Number;
	private var $buttonTimeout:Number;
	private var $displayCurrentItemDetailsTimeout:Number;
	private var $imageHeader:ZoomImageHeader;
	private var $pieLoader:PieChart;
	var radius:Number;
	
	public function ZoomView()
	{
		this.setClassDescription('org.caleb.application.zoom.ZoomView');
		//trace('constructor invoked');
		Stage.align = "LT";
		Stage.scaleMode = "noScale";
		Stage.showMenu = false;
		Stage.addListener(this);

		this.$imageRotationMap = new Array();
		//set default stage size
		this.$stageWidth = 800; 
		this.$stageHeight = 800;
		this.reset();
	}
	public function onResize():Void
	{
		if(this.imagesAreReady)
		{
			this.setSizes();
			this.updateImagePositions();
			this.$intro.minimize();
			
			if(this.$controller.zoomedIn)
			{
				this.$controller.currentItem.zoomIn();
			}
		}
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onLoad()
	{
		this.initListeners()
		this.$imageHeader = ZoomImageHeader(this.attachMovie('imageHeader', '$imageHeader', this.getNextHighestDepth()))
		this.$imageHeader._visible = false;
		this.doIntro();
	}
	private function setupPieChart():Void
	{
		radius = 1000;		
		// new PieChart(x position, y position, radius, timeline to create in, depth, start angle (radians) clockwise from right (0 degrees));
		var $pieContainer:MovieClip = this.createEmptyMovieClip('myChartContainer', this.getNextHighestDepth());
		this.$pieLoader = new PieChart(this.$controller.relativeWidth, this.$controller.relativeHeight, radius, $pieContainer, $pieContainer.getNextHighestDepth(), -Math.PI/2);
		this.$pieLoader.addEventObserver(this, 'onSegmentRendered');
		this.$pieLoader.appendSlice(0, 0xFCFCFC); // percent value, color
		this.$pieLoader.appendSlice(0, 0x9933CC);
		this.$pieLoader.appendSlice(0, 0xCCCCCC);
		this.$pieLoader.render(); // draw on screen
		this.$pieLoader.view._visible = false;
		this.$thumbs._x = org.caleb.util.MovieClipUtil.getStageCenterX(this.$thumbs) * .45;
		this.$thumbs._y = org.caleb.util.MovieClipUtil.getStageCenterY(this.$thumbs) * .5;
	}
	private function onSegmentRendered(e:org.caleb.event.Event):Void
	{
		this.$thumbs._xscale = 20;
		this.$thumbs._yscale = 20;
		var targetThumb:ZoomImage = ZoomImage(this.$controller.loadedImages[this.$controller.loadedImages.length-1]);
		//trace('testThumb: ' + testThumb);
		targetThumb._x = Number(e.getArgument('anchorX') + e.getSender().view._x + radius);
		targetThumb._y = Number(e.getArgument('anchorY') + e.getSender().view._y + radius);
		targetThumb._rotation = Number(e.getArgument('percent')) * 360;
		targetThumb.pieRotation = targetThumb._rotation;
		targetThumb.pieX = targetThumb._x;
		targetThumb.pieY = targetThumb._y;
	}
	private function onZoomXMLReady(e:org.caleb.event.Event):Void
	{
		//trace('onZoomXMLReady invoked');
		//trace('e: ' + e.getArgument('xml'))
		//org.caleb.util.TraceUtil.traceObject(e.getArgument('xml'))
		// var x:XML = XML(e.getArgument('xml'));
		this.reset();
		this.layout();		

		if(this.$random == true)
		{
			var len = this.$controller.imageURLs.length;
			for (var i = 0; i<len; i++) 
			{
				var rand = Math.floor(Math.random() * len);
				var temp = this.$controller.imageURLs[i];
				this.$controller.imageURLs[i] = this.$controller.imageURLs[rand];
				this.$controller.imageURLs[rand] = temp;
			}
		}
		//trace('this.$controller.imageCount: ' + this.$controller.imageCount)
		this.attachImages(this.$controller.imageCount);
		this.initImages();
	}
	private function reset():Void
	{
		this.$imageHeader.controller = this.$controller;
		this.$imageHeader.init();
		this.$imageRotationMap = new Array();
		this.random = false;
		this.$loadedMainImage = false;
		// reset controller
		this.$controller.reset();
		this.removeImages();
	}
	private function removeImages():Void
	{
		for (var i = 0;i < this.$items.length;i++)
		{
			this.$items[i].removeMovieClip();
		}
	}
	private function initListeners()
	{
		//trace('initListeners invoked');
		this.setupKeyListeners();
		var resizeListener = new Object();
		Stage.addListener(resizeListener);
		resizeListener.onResize = function()
		{
			//trace("onResize");
			// todo: if(this.resizeIntervalId == undefined)
			if(!this.resizeIntervalId) 
			{ 
				this.resizeIntervalId = setInterval(this,"$onResize",RESIZE_INTERVAL);
			}		
			this.onResize = function() 
			{
				// invoke layout when the stage is resized	
				this.layout();
				clearInterval(this.resizeIntervalId);
				delete(this.resizeIntervalId);
			}
		}
	}
	
	private function doIntro():Void
	{
		//trace('doIntro invoked');
		this.$intro = this.attachMovie('intro', 'intro', 1);
		this.$intro.init(this);
		this.$imageHeader.outro();
	}
	private function navButtonPress(button:MovieClip):Void
	{
		button.nextFrame();
		_global.clearTimeout(this.$buttonTimeout);
		_global.setTimeout(button, 'prevFrame', 250);
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onLeft():Void
	{
		//trace('onLeft invoked');
		if(this.$controller.currentId > 0)
		{
			// set next item
			this.currentId--;
			this.items[this.currentId].zoomIn();
			this.navButtonPress(this.$imageHeader.topNav.previousButton)
		}
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onRight():Void
	{
		//trace('onRight invoked');
		if(this.$controller.currentId < this.$items.length-1)
		{
			// set next item
			this.currentId++;				
			this.items[this.currentId].zoomIn();
			this.navButtonPress(this.$imageHeader.topNav.nextButton)
		}
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onUp():Void
	{
		//trace('onUp invoked');
		if((this.$controller.currentId - this.$controller.columns) >= 0)
		{
			// set next item
			this.currentId -= this.columns;		
			this.items[this.currentId].zoomIn();
			this.navButtonPress(this.$imageHeader.topNav.upButton)
		}
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onDown():Void
	{
		//trace('onDown invoked');
		if((this.$controller.currentId + this.$controller.columns) < this.$items.length)
		{
			// set next item
			this.currentId += this.columns;				
			this.items[this.currentId].zoomIn();
			this.navButtonPress(this.$imageHeader.topNav.downButton)
		}
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onEnter():Void
	{
		//trace('onEnter invoked');
		if (this.controller.zoomedIn)
		{
			this.controller.zoomOut();
		}
		else
		{
			this.items[this.currentId].zoomIn();
		}
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function init()
	{
		//trace('init invoked');
		if(this.$controller == undefined)
		{
			this.$controller = new ZoomController(this);
			this.$controller.addEventObserver(this, 'onZoomXMLReady');
			this.$controller.addEventObserver(this, 'onZoomOutInit');
			this.$controller.addEventObserver(this, 'onZoomInInit');
			this.$controller.addEventObserver(this, 'onItemActivated');
			this.$controller.addEventObserver(this, 'onItemDeactivated');
			this.$controller.addEventObserver(this, 'onLoadAttemptComplete');
		}
		this.loadXML();
	}
	private function setupKeyListeners():Void
	{
		org.caleb.util.KeyboardUtil.addKeyListener(this);
	}
	private function onKeyDown(e:org.caleb.event.Event):Void
	{
		//trace("\tThe Key code is: "+e.getArgument('key'));
		//trace("\tThe ASCII value is: "+e.getArgument('ascii'));
		//trace("\tThe mapped value is: "+e.getArgument('value'));
		if (this.$locked != true) 
		{
			if(Key.isDown(Key.SPACE)) 
			{
				this.onEnter();
			}
			else
			{
				org.caleb.util.ObjectUtil.callMethod(this, String('on').concat(e.getArgument('value')));
			}
		}
		this.$locked = true;
	}
		
	private function onKeyUp(e:org.caleb.event.Event):Void 
	{
		this.$locked = false;
	}

	/**
	 * 
	 * @usage   
	 * @return  
	 */
	 
	private function onThumbsFadeOutComplete():Void
	{
		//trace('onThumbsFadeOutComplete invoked');
	}
	public function layout()
	{
		//trace('layout invoked');
		this.$thumbs.removeMovieClip();
		this.$thumbs = this.createEmptyMovieClip('thumbsContainer', this.getNextHighestDepth());		
		this.$thumbs._x = this.$controller.outX;
		this.$thumbs._y = this.$controller.outY;
		this.$thumbs._xscale = this.$controller.initialScale;
		this.$thumbs._yscale = this.$controller.initialScale;
		this.setSizes();
		if(false)
		{
			this.setupPieChart();
		}
		else
		{
			this.$intro.minimize();
		}
	}
	
	
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function loadXML()
	{
		//trace('loadXML invoked');

		// reset local collection
		this.$items = new Array;	
		//load XML doc
		this.$controller.loadXML('zoomimages.xml');
	}
	private function attachImages(count:Number):Void
	{
		//trace('attachImages invoked w/ count: '+ count);
		//add images to ZoomController
		for (var i = 0;i < count; i++)
		{			
			if(i >= this.$controller.maxRows * this.$controller.columns)
			{
				return;
			}
			this.$items[i] = this.$thumbs.attachMovie('zoomImage', ZoomController.THUMB_PREFIX.concat(i), 1 + i);
		}
	}
	private function initImages():Void
	{
		//trace('initImages invoked');
		var imageId:Number;
		var imageFile:String;
		var thumbURL:String;
		var imageX:Number;
		var imageY:Number;

		for (var i = 0;i < this.$items.length;i++)
		{			
			imageId = i;
			imageFile = this.$controller.imageURLs[i];
			thumbURL = this.$controller.thumbURLs[i];
			imageX = (this.$controller.imageDimensions*(i%this.$controller.columns) + this.$controller.imageDimensions/2);
			imageY = (this.$controller.imageDimensions*Math.floor(i/this.$controller.columns) + this.$controller.imageDimensions/2);
			
			this.$items[i].thumbURL = thumbURL;
			this.$items[i].init(imageId, imageFile, imageX, imageY, this.$controller, this);	
		}
	}
	public function onIntroMinimized(e:org.caleb.event.Event):Void
	{
		trace('onIntroMinimized invoked')
		this.setReady();
		this.setSizes();
		//this.updateImagePositions();
	}
	public function setReady():Void
	{
		for (var i = 0;i < this.$items.length;i++)
		{
			this.$items[i].ready = true;
		}
	}
	public function setSizes():Void
	{
		trace('setSizes invoked');
		trace('Stage.width: ' + Stage.width)
		trace('columns: ' + Math.floor(Stage.width / 100));
		trace('rows: ' + Math.floor(Stage.height / 120));
		this.$controller.columns = Math.floor(Stage.width / 120);
		this.$controller.maxRows = Math.floor(Stage.height / 120);
		this.$stageWidth = Stage.width;
		this.$controller.width = Stage.width;
		this.$stageHeight = Stage.height;
		this.$controller.height = Stage.height;
		//this.getURL("javascript:resizeDiv(" + _root._width + "," + _root._height + ")");
	}
	private function updateImagePositions():Void
	{
		var imageX:Number;
		var imageY:Number;

		for (var i = 0;i < this.$items.length;i++)
		{			
			imageX = (this.$controller.imageDimensions*(i%this.$controller.columns) + this.$controller.imageDimensions/2);
			imageY = (this.$controller.imageDimensions*Math.floor(i/this.$controller.columns) + this.$controller.imageDimensions/2);
			
			this.$items[i].x = imageX;
			this.$items[i].y = imageY;
			this.$items[i].gotoOriginalPosition();
		}
	}
	// events
	/**
	 * 
	 * @usage   
	 * @param   e 
	 * @return  
	 */
	public function onNoImagesFound(e:org.caleb.event.Event):Void
	{
		var needle = e.getArgument('needle');
		//trace('onNoImagesFound invoked, needle: ' + needle)
	}
	/**
	 * 
	 * @usage   
	 * @param   e 
	 * @return  
	 */
	public function onImagesFound(e:org.caleb.event.Event):Void
	{
		var count = e.getArgument('count');
		var needle = e.getArgument('needle');
		//trace('onImagesFound invoked, count: ' + count + '; needle: ' + needle)
	}
	/**
	 * 
	 * @usage   
	 * @param   e 
	 * @return  
	 */
	public function onItemDeactivated(e:org.caleb.event.Event):Void
	{
	}
	public function onItemActivated(e:org.caleb.event.Event):Void
	{
		//trace('onItemActivated invoked');

		this.displayCurrentItemDetails();
		this.$imageHeader.swapDepths(this.getNextHighestDepth());
		this.$intro.swapDepths(this.getNextHighestDepth());
		this.$imageHeader.intro();
		
		this.applyFilters();

	}
	public function displayCurrentItemDetails():Void
	{
		var title = this.imageDetailsMap[this.$controller.currentId]['title'];
		var summary = this.imageDetailsMap[this.$controller.currentId]['summary'];
		var imageURL = this.imageDetailsMap[this.$controller.currentId]['url'];
		var refererURL = this.imageDetailsMap[this.$controller.currentId]['referer_url'];
		var imageFilesize = this.imageDetailsMap[this.$controller.currentId]['size'];
		var imageWidth = this.imageDetailsMap[this.$controller.currentId]['width'];
		var imageHeight = this.imageDetailsMap[this.$controller.currentId]['height'];

		var headlineFormat:TextFormat = new TextFormat();
		headlineFormat.font = "gothamBoldExported";
		headlineFormat.size = 16;
		var paragraphFormat:TextFormat = new TextFormat();
		paragraphFormat.font = "gothamBookExported";
		paragraphFormat.size = 14;

		var headline:String = title + newline; 
		var link:String = '<a target="_blank" href="'+imageURL+'">' + imageURL + '</a>' + newline;
		var filesize:String = Math.round(imageFilesize/1000).toString().concat('KB');
		if(this.$controller.currentItem.loadStarted == true)
		{
			var loadStatus:String;
			if(this.$controller.currentItem.imageLoadFailed == true)
			{
				loadStatus = '(Image Not Found)';
				_global.clearTimeout(this.$displayCurrentItemDetailsTimeout);
			}
			else if(this.$controller.currentItem.loadPercentage == 1)
			{
				loadStatus = new String;
			}
			else if(this.$controller.currentItem.loadPercentage > 0 && this.$controller.currentItem.loadPercentage < 1)
			{
				loadStatus = Number(Math.ceil(this.$controller.currentItem.loadPercentage * 1000) / 10 ).toString();
				if(loadStatus.length == 2)
				{
					loadStatus = loadStatus.concat('.0');
				}
				loadStatus = loadStatus.concat('% Loaded').concat(newline);
				this.$displayCurrentItemDetailsTimeout = _global.setTimeout(this, 'displayCurrentItemDetails', 250);
			}
		}
		else
		{
			_global.clearTimeout(this.$displayCurrentItemDetailsTimeout);
		}
		var imageDimensions:String = imageWidth.concat('x').concat(imageHeight).concat(newline);
		if(loadStatus == undefined)
		{
			loadStatus = new String;
		}
		var paragraph:String = headline.concat(link).concat(filesize).concat(' ').concat(imageDimensions).concat(newline).concat(loadStatus);
		
		this.$imageHeader.detailsText.embedFonts = true;
		this.$imageHeader.detailsText.multiline = true;
		this.$imageHeader.detailsText.wordWrap = true;
		this.$imageHeader.detailsText.htmlText = headline;
		var firstIndex:Number = this.$imageHeader.detailsText.length;
		this.$imageHeader.detailsText.htmlText += paragraph;
		var secondIndex:Number = this.$imageHeader.detailsText.length;
		var zoomCSS = new TextField.StyleSheet();
		var cssURL = "zoom.css";
		zoomCSS.load( cssURL );
		this.$imageHeader.detailsText.styleSheet = zoomCSS;
		
		this.$imageHeader.detailsText.setTextFormat(0, firstIndex, headlineFormat);
		this.$imageHeader.detailsText.setTextFormat(firstIndex, secondIndex, paragraphFormat);
	}
	private function onLoadAttemptComplete(e:org.caleb.event.Event):Void
	{
		//trace('onLoadAttemptComplete invoked, this.$loadedMainImage: '+this.$loadedMainImage);
		if(this.$loadedMainImage == false)
		{
			if(AUTO_LOAD_MAIN_IMAGES == true)
			{
				this.loadMainImages();
			}
			this.$controller.zoomOut(1);
			this.setupInitialImagePosition();
		}
	}
	
	private function setupInitialImagePosition():Void
	{
		this.$intro.minimize();
		var timeoutDelay:Number;
		for (var i = 0;i < this.$items.length;i++)
		{
			if(i == 0)
			{
				this.$items[i].addEventObserver(this, 'onGotoOriginalPositionTweenComplete');
			}
			
			this.$items[i].gotoOriginalPosition(1);
			//_global.setTimeout(this.$items[i], 'gotoOriginalPosition', Number(i * 500));
			timeoutDelay = this.$items[i].tweenLength/20;
		}
		//_global.setTimeout(this, 'loadMainImages', timeoutDelay);
	}
	private function onGotoOriginalPositionTweenComplete(e:org.caleb.event.Event):Void
	{
		trace('onGotoOriginalPositionTweenComplete invoked');
		this.$items[0].removeEventObserver(this, 'onGotoOriginalPositionTweenComplete');
		for (var i = 0;i < this.$items.length;i++)
		{
			this.$items[i].ready = true;
		}
		this.loadMainImages();
	}
	private function loadMainImages():Void
	{
		if(this.$loadedMainImage == false)
		{
			org.caleb.application.zoom.ZoomImage.LOAD_THUMBS = false;
			for (var i = 0;i < this.$items.length;i++)
			{
				this.$items[i].imageIntroComplete = false;
				this.$items[i].loadAttempted = false;
				this.$items[i].setLoadTimeout();
			}
			this.$loadedMainImage = true;
		}
	}
	private function removeFilters():Void
	{
		if(USE_FILTERS)
		{
			//trace('removeFilters invoked');
			this.$items[this.$controller.currentId].dropshadow = 0;
		}
	}
	private function applyFilters():Void
	{
		if(USE_FILTERS)
		{
			//trace('applyFilters invoked');
			this.$items[this.$controller.previousId].dropshadow = 0;
			this.$items[this.$controller.currentId].dropshadow = 100;
		}
	}
	public function onZoomInInit():Void
	{
		//trace('onZoomInInit invoked')
		this.applyFilters();
	}
	public function onZoomOutInit():Void
	{
		//trace('onZoomOutInit invoked')
		this.$imageHeader.outro();
		this.removeFilters();
		_global.clearTimeout(this.$displayCurrentItemDetailsTimeout);
	}
	public function onZoomOutComplete():Void
	{
		//trace('onZoomOutComplete invoked')
	}
	// accessors
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
	public function get stageWidth():Number
	{
		return this.$stageWidth;
	}
	public function set stageWidth(arg:Number):Void
	{
		this.$stageWidth = arg;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get stageHeight():Number
	{
		return this.$stageHeight;
	}
	public function set stageHeight(arg:Number):Void
	{
		this.$stageHeight = arg;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get columns():Number
	{
		return this.$controller.columns;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get imageDimensions():Number
	{
		return this.$controller.imageDimensions;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get frameWidth():Number
	{
		return this.$controller.frameWidth;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get items():Array
	{
		return this.$items;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get imageRotationMap():Array
	{
		return this.$imageRotationMap;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get locked():Boolean
	{
		return this.$locked;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get random():Boolean
	{
		return this.$random;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get intro():MovieClip
	{
		return this.$intro;
	}
	// mutators
	/**
	 * 
	 * @usage   
	 * @param   n 
	 * @return  
	 */
	public function set frameWidth(n:Number):Void
	{
		this.$controller.frameWidth = n;
	}
	/**
	 * 
	 * @usage   
	 * @param   d 
	 * @return  
	 */
	public function set imageDimensions(d:Number):Void
	{
		this.$controller.imageDimensions = d;
	}
	/**
	 * 
	 * @usage   
	 * @param   n 
	 * @return  
	 */
	public function set columns(n:Number):Void
	{
		this.$controller.columns = n;
	}
	/**
	 * 
	 * @usage   
	 * @param   b 
	 * @return  
	 */
	public function set locked(b:Boolean):Void
	{
		this.$locked = b;
	}
	/**
	 * 
	 * @usage   
	 * @param   b 
	 * @return  
	 */
	public function set random(b:Boolean):Void
	{
		this.$random = b;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get imageDetailsMap():Array
	{
		return this.$controller.imageDetailsMap;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get thumbs():MovieClip
	{
		return this.$thumbs;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get thumbsMask():MovieClip
	{
		return this.$thumbsMask;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get currentId():Number
	{
		//trace('GETTING CURRENT ID FROM CONTROLLER');
		//trace('this.$controller: ' + this.$controller)
		//trace('this.$controller.currentId: ' + this.$controller.currentId)
		return this.$controller.currentId;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function set currentId(id:Number):Void
	{
		//trace('SETTING CURRENT ON CONTROLLER');
		//trace('this.$controller: ' + this.$controller)
		//trace('this.$controller.currentId (BEFORE): ' + this.$controller.currentId)
		this.$controller.currentId = id;
		//trace('this.$controller.currentId (AFTER): ' + this.$controller.currentId)
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get previousId():Number
	{
		return this.$controller.previousId;
	}
	public function get nextId():Number
	{
		return this.$controller.nextId;
	}
	public function get pieLoader():PieChart
	{
		return this.$pieLoader;
	}
	public function get imagesAreReady():Boolean
	{
		for(var img in this.$items)
		{
			if(this.$items[img].ready == false)
			{
				return false;
			}
		}
		
		return true;
	}
}