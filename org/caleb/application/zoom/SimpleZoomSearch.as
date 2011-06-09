import org.caleb.application.zoom.search.ZoomSearchXML;
import org.caleb.application.zoom.search.ZoomMediaSearch;
import org.caleb.application.zoom.search.ZoomSearchList;
import org.caleb.application.zoom.search.ZoomMediaSearchBox;
import org.caleb.application.zoom.search.ZoomSearchController;
import org.caleb.application.zoom.ZoomView;
import org.caleb.xml.SimpleXML;
import org.caleb.search.SearchResultXML;
import org.caleb.util.SearchUtil;
import org.caleb.paginator.Paginator;
import org.caleb.animation.AnimationManager;
import org.caleb.flickr.*;

class org.caleb.application.zoom.SimpleZoomSearch extends ZoomMediaSearch
{
	public static var MODE_YAHOO:String = 'yahooSearch';
	public static var MODE_FLICKR:String = 'flickrSearch';
	public static var MODE_LOAD_SUCCESS:String = 'imageLoadStarted';
	public static var MODE_LOAD_STARTED:String = 'imageLoadStarted';
	public static var MODE_LOAD_FAILED:String = 'imageLoadFailed';
	public static var MODE_LOAD_QUEUED:String = 'imageLoadNotAttempted';
	public static var FLICKR_API_KEY:String = '1a008492633952aa82bcff2081dbc931';
	private var $xmlString:String;
	private var $noResultsFoundAlert:MovieClip;
	private var $stageMask:MovieClip;
	private var $help:MovieClip;
	private var $startResultPosition:String;
	private var $searchString:String;
	private var $postIntroSetupComplete:Boolean;
	private var $intro:ZoomMediaSearchBox;	
	private var $hideHelpInterval:Number;
	private var $itemsPerPage:Number;
	private var $controller:ZoomSearchController;
	private var $paginator:Paginator;
	private var $table:Table;
	private var $flickr:Flickr;
	private var $flickrManager:FlickrManager;
	private var $legend:MovieClip;
	private var $flickrPhotos:Array;
	// assets assumed to be present in .fla
	public var listResults:MovieClip;

	/**
	 * 
	 * @usage   
	 * @param   str 
	 * @return  
	 */
	public function SimpleZoomSearch()
	{
		this.setClassDescription('org.caleb.application.zoom.SimpleZoomSearch');
		//trace('constructor invoked');
		this.$itemsPerPage = 50;
		this.init(MODE_FLICKR);
	}
	public function onResize():Void
	{
		
		super.onResize();
		
		this.$table.columns = this.$controller.columns;
		this.$table.positionCells();
		this.$table.selectCell(this.$controller.currentItem.id);
		this.positionFloatingElements();
		this.performSearch();
	}
	private function initImages(start:Number):Void
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
			if(i>= start || start == undefined)
			{
				this.$items[i].init(imageId, imageFile, imageX, imageY, this.$controller, this);	
			}
		}
	}
	public function onTableCellsPositioned(e:org.caleb.event.Event):Void
	{
		trace('onTableCellsPositioned invoked');
		this.$table.view._x = this.$legend._x - this.$table.view._width - 10;
	}
	private function positionFloatingElements():Void
	{
		this.$animationManager = new org.caleb.animation.AnimationManager(this.$intro);
		this.$animationManager.tween(['_x'], [org.caleb.util.MovieClipUtil.getStageCenterX(this.$intro)], 1);

		this.$animationManager = new org.caleb.animation.AnimationManager(this.$paginator);
		this.$animationManager.tween(['_x','_y'], [org.caleb.util.MovieClipUtil.getStageCenterX(this.$paginator), 50], 1);
		
		this.$animationManager = new org.caleb.animation.AnimationManager(this.$table);
		this.$animationManager.tween(['_x','_y'], [Stage.width - this.$table._width - 25, Stage.height - this.$table._height - 25], 1);
		
		this.$animationManager = new org.caleb.animation.AnimationManager(this.listResults);
		this.$animationManager.tween('_x', Stage.width - 10, 1);
		
		this.$animationManager = new org.caleb.animation.AnimationManager(this.$imageHeader);
		this.$animationManager.tween('_x', org.caleb.util.MovieClipUtil.getStageCenterX(this.$imageHeader), 1);
	}
	public function onYahooSearchResult(e:org.caleb.event.Event):Void
	{
		trace('onYahooSearchResult invoked');
		//trace('sender: ' + e.getArgument('xml'));
		trace('type: ' + e.getArgument('type'));
		switch(String(e.getArgument('type')))
		{
			case SearchUtil.YAHOO_IMAGE_SEARCH:
			{
				this.$xmlString = String(e.getArgument('xml'));
				this.loadXML();
				this.setupPaginator(XML(e.getArgument('xml')))
				this.setupMiniView();
			}
			break;
			case SearchUtil.YAHOO_WEB_SEARCH:
			{
				this.listResults._visible = true;
				ZoomSearchList(this.listResults.webList).populateList(String(e.getArgument('type')), XML(e.getArgument('xml')));
			}
			break;
			case SearchUtil.YAHOO_NEWS_SEARCH:
			{
				this.listResults._visible = true;
				ZoomSearchList(this.listResults.newsList).populateList(String(e.getArgument('type')), XML(e.getArgument('xml')));
			}
			break;
			case SearchUtil.YAHOO_VIDEO_SEARCH:
			{
				this.listResults._visible = true;
				ZoomSearchList(this.listResults.videoList).populateList(String(e.getArgument('type')), XML(e.getArgument('xml')));
			}
			break;
		}
	}
		
	private function onFlickrError(e:org.caleb.event.Event):Void
	{
		trace('onFlickrAPIResponse invoked');
		// for(var i in e['$arguments']) trace('key: ' + i + ', value: ' + e['$arguments'][i]);
	}
	private function onFlickrAPIResponse(e:org.caleb.event.Event):Void
	{
		trace('onFlickrAPIResponse invoked');
		// for(var i in e['$arguments']) trace('key: ' + i + ', value: ' + e['$arguments'][i]);
		this.$xmlString = XML(e.getArgument('eventObject').xml).firstChild.firstChild.toString();
		
	}
	private function onFlickrPhotosSearch(e:org.caleb.event.Event):Void
	{
		trace('onFlickrPhotosSearch invoked');
		this.$flickrPhotos = new Array(e.getArguments()['photos'].length);
		for(var i:Number = 0; i < e.getArguments()['photos'].length; i++)
		{
			this.$flickrPhotos[i] = (Photo(e.getArguments()['photos'][i]));
		}
		this.loadXML();
		this.setupPaginator(new XML(this.$xmlString));
		this.setupMiniView();
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function submitForm():Void
	{
		//trace('submitForm invoked w/ arg: ' + arguments[0])
		var startResultPosition = arguments[0];
		var newStart;
		if(startResultPosition > 1)
		{
			newStart =  Number((startResultPosition * this.$itemsPerPage) - this.$itemsPerPage + 1);
		}
		else
		{
			newStart = 1;
		}
		if(this.$intro.needle.text != '')
		{
			this.search(this.$intro.needle.text, newStart);
		}
	}
	public function next():Void
	{
		//trace('next invoked: '+ Number(Number($paginator.currentPage) + 1))
		this.submitForm(Number(Number($paginator.currentPage) + 1));
	}
	public function previous():Void
	{
		//trace('previous invoked: '+ Number(Number($paginator.currentPage) - 1))
		this.submitForm(Number(Number($paginator.currentPage) - 1));
	}
	public function gotoPage(context:Object, page:Number):Void
	{
		//trace('gotoPage w/ page: '+page);
		this.submitForm(page);
	}
	public function onEnter():Void
	{
		//trace('onEnter invoked');
		if(this.$intro.focused == true && Key.isDown(Key.SPACE) != true)
		{
			trace('a')
			// the focus has not yet been defined
			// or the search box is focused
			// and enter has been pressed
			this.$intro.search.onRelease();
		}
		else if(this.$intro.focused == true)
		{
			trace('b')
			// spacebar hit when search text box was focused
			// noop
			//trace('onEnter noop')
		}
		else
		{
			trace('c')
			// search box is not focused
			// zoom in and out
 			super.onEnter();
		}
	}

	private function doIntro():Void
	{
		//trace('doIntro invoked');
		this.$intro = ZoomMediaSearchBox(this.attachMovie('intro', 'intro',this.getNextHighestDepth()));
		this.$intro.init(this);
		trace('this.$controller.relativeHeight: ' + this.$controller.relativeHeight)
		this.$intro._x = -(this.$intro._width);
		this.$intro._y = (Stage.height/5)-this.$intro._height;
		this.$animationManager = new org.caleb.animation.AnimationManager(this.$intro)
		this.$animationManager.tween(['_x'], [(Stage.width/2)-(this.$intro._width/2)], 2, "easeoutelastic");
		this.$imageHeader.outro();
	}
	public function search(searchString:String):Void
	{
		this.$searchString = arguments[0];
		this.$startResultPosition = arguments[1];
		this.$intro.modeSwitch._visible = false;
		trace('search invoked, this.$startResultPosition: ' + this.$startResultPosition);
		this.fadeOutImages();
		this.fadeOutMiniView();
	}
	public function performSearch():Void
	{
		trace('performSearch invoked, this.$controller.mode: ' + this.$controller.mode);
		switch(this.$controller.mode)
		{
			case MODE_YAHOO:
			{
				this.performYahooSearch();
			}
			break;
			case MODE_FLICKR:
			{
				this.performFlickrSearch();
			}
			break;
		}
	}
	public function performYahooSearch():Void
	{
		this.reset();
		//trace('search invoked w/ string: ' + searchString)
		SearchUtil.APPLICATION_ID = 'CalebHaye-YahooZoomSearch';
		trace('performYahooSearch invoked, this.$startResultPosition: ' + this.$startResultPosition);
		if(this.$startResultPosition == undefined)
		{
			SearchUtil.search(this, this.$searchString, SearchUtil.YAHOO_IMAGE_SEARCH, this.$itemsPerPage);
		}
		else
		{
			SearchUtil.search(this, this.$searchString, SearchUtil.YAHOO_IMAGE_SEARCH, this.$itemsPerPage, '&start='+this.$startResultPosition);
		}
	}
	public function performFlickrSearch():Void
	{
		var tagSearch:Object = new Object;
		tagSearch.tags = this.$searchString;
		tagSearch.tag_mode = 'any';
		tagSearch.sort = 'relevance';
		tagSearch.per_page = this.$itemsPerPage;
		if(this.$startResultPosition != undefined)
		{
			tagSearch.page = Math.ceil((this.$startResultPosition) / this.$itemsPerPage);
		}
		trace('tagSearch.page: ' + tagSearch.page );
		trace('startResultPosition: ' + this.$startResultPosition);
		this.$flickr.photosSearch(tagSearch);
	}
	private function complimentarySearch():Void
	{
		trace('complimentarySearch invoked');
		//trace('search invoked w/ string: ' + searchString)
		SearchUtil.APPLICATION_ID = 'CalebHaye-YahooZoomSearch';
		trace('this.$startResultPosition: ' + this.$startResultPosition);
		if(this.$startResultPosition == undefined)
		{
			SearchUtil.search(this, this.$searchString, SearchUtil.YAHOO_WEB_SEARCH, 10);
			SearchUtil.search(this, this.$searchString, SearchUtil.YAHOO_NEWS_SEARCH, 10);
			SearchUtil.search(this, this.$searchString, SearchUtil.YAHOO_VIDEO_SEARCH, 10);
		}
		else
		{
			trace('this.$startResultPosition: ' + this.$startResultPosition);
			SearchUtil.search(this, this.$searchString, SearchUtil.YAHOO_WEB_SEARCH, 10, '&start='+this.$startResultPosition);
			SearchUtil.search(this, this.$searchString, SearchUtil.YAHOO_NEWS_SEARCH, 10, '&start='+this.$startResultPosition);
			SearchUtil.search(this, this.$searchString, SearchUtil.YAHOO_VIDEO_SEARCH, 10, '&start='+this.$startResultPosition);
		}
	}
	private function postIntroSetup():Void
	{
		if(this.$postIntroSetupComplete != true)
		{
			this.$paginator.locked = false;
			for (var i = 0;i < this.$items.length;i++)
			{			
				org.caleb.util.MovieClipUtil.makeDraggable(this.$items[i]);
			}
			this.listResults.swapDepths(this.getNextHighestDepth());
			this.complimentarySearch();
			this.$postIntroSetupComplete = true;
			if(false)
			{
				this.setupMiniView();
			}
			for (var i = 0;i < this.$items.length;i++)
			{
				this.setMiniViewCellMode(i, ZoomMediaSearch.MODE_LOAD_QUEUED);
			}
		}
	}
	private function setupMiniView():Void
	{
		if(this.$table != undefined)
		{
			this.$table.removeMovieClip();
		}
		this.$table = Table(this.attachMovie(Table.SymbolName, 'miniView', this.getNextHighestDepth()));
		this.$table.addEventObserver(this, 'onCellSelect');
		this.$table.addEventObserver(this, 'onTableCellsPositioned');
		this.$table.init(this.$controller.columns, this.$items.length, false);

		// attach legend
		this.$legend = this.$table.attachMovie('miniViewLegend', 'legend', this.$table.getNextHighestDepth());
		this.$legend._x = this.$table._width + 5;

		// position
		this.$table._x = Stage.width - this.$table._width - 25;
		this.$table._y = Stage.height - this.$table._height - 25;
		this.$table.addMode(ZoomMediaSearch.MODE_LOAD_STARTED, org.caleb.application.zoom.ZoomImage.COLOR_LOAD_STARTED);
		this.$table.addMode(ZoomMediaSearch.MODE_LOAD_QUEUED, org.caleb.application.zoom.ZoomImage.COLOR_LOAD_QUEUED);
		this.$table.addMode(ZoomMediaSearch.MODE_LOAD_FAILED, org.caleb.application.zoom.ZoomImage.COLOR_LOAD_ERROR);		
		this.$table.addMode(ZoomMediaSearch.MODE_LOAD_SUCCESS, org.caleb.application.zoom.ZoomImage.COLOR_LOAD_SUCCESS);		
	}
	
	public function onIntroMinimized(e:org.caleb.event.Event):Void
	{
		trace('onIntroMinimized invoked');
		super.onIntroMinimized(e);
		this.postIntroSetup();
		this.$paginator._x = (Stage.width - this.$paginator._width) / 2;
		this.$paginator._y = this.$intro._y + this.$intro._height + 10;;
		if(this.$paginator._alpha != 100 || this.$paginator._visible == false)
		{
			org.caleb.util.MovieClipUtil.fadeIn(this.$paginator, 1);
		}
		this.$intro.modeSwitch._visible = true;
	}
	public function init(mode:String)
	{
		trace('init invoked, mode: ' + mode);
		this.$controller.mode = mode;

		this.$flickr = Flickr.getFlickr();
		this.$flickr.apiKey = FLICKR_API_KEY;
		this.$flickrManager = new FlickrManager(this);

		this.$paginator.removeMovieClip();
		this.$paginator = Paginator(this.attachMovie('Paginator', '$paginator', this.getNextHighestDepth()))
		this.$paginator._visible = false;
		if(this.$controller == undefined)
		{
			this.$controller = new ZoomSearchController(this);
			this.$controller.addEventObserver(this, 'onZoomXMLReady');
			this.$controller.addEventObserver(this, 'onZoomOutInit');
			this.$controller.addEventObserver(this, 'onZoomInInit');
			this.$controller.addEventObserver(this, 'onItemActivated');
			this.$controller.addEventObserver(this, 'onItemDeactivated');
			this.$controller.addEventObserver(this, 'onLoadAttemptComplete');
			this.$controller.mode = mode;

			trace('this.$imageHeader: ' + this.$imageHeader)
			this.$imageHeader.controller = this.$controller;
		}
		this.listResults._x = Stage.width - 10;
	}
	public function setSizes():Void
	{
		super.setSizes();
		this.$imageHeader.shade._x = 0;
		this.$imageHeader.shade._width = Stage.width + 50;
		this.$imageHeader.topShade._x = 0;
		this.$imageHeader.topShade._width = Stage.width + 50;
	}
	/**
	 * 
	 * @usage   
	 * @param   success 
	 * @return  
	 */
	public function setupPaginator(x:XML)
	{
		trace('setupPaginator invoked');
		trace(' this.$controller.firstResultPosition: ' +  this.$controller.firstResultPosition)
		var e:org.caleb.event.Event = new org.caleb.event.Event();
		e.setSender(this);
		e.addArgument('needle', this.$intro.needle.text);
		e.addArgument('count', x.firstChild.childNodes.length);
		this.$paginator.init(this.$controller.totalResultsAvailable, this.$itemsPerPage, 'pageMenuItem', this.$controller.firstResultPosition, 9, this);
		trace('this.$controller.totalResultsAvailable: ' + this.$controller.totalResultsAvailable);
		trace('this.$itemsPerPage: ' + this.$itemsPerPage);
		trace('this.$controller.firstResultPosition: ' + this.$controller.firstResultPosition);
		this.$paginator.locked = true;
		if(this.$thumbs._alpha != 100)
		{
			this.$animationManager = new org.caleb.animation.AnimationManager(this.$thumbs);
			this.$animationManager.tween('_alpha', 100, 1)
		}
		if(x.firstChild.childNodes.length > 0)
		{
			e.setType('onImagesFound');
			this.onImagesFound(e);
		}
		else
		{
			e.setType('onNoImagesFound');
			this.onNoImagesFound(e);
		}
		this.positionFloatingElements();
	}
	/**
	 * 
	 * @usage   
	 * @param   e 
	 * @return  
	 */
	public function onNoImagesFound(e:org.caleb.event.Event):Void
	{
		trace('onNoImagesFound invoked');
		this.$paginator.locked = false;
		this.$intro.modeSwitch._visible = false;
		if(this.$noResultsFoundAlert._visible != true)
		{
			this.$intro.resultCount._visible = true;
			var count = e.getArgument('count');
			var needle = e.getArgument('needle');
			var resultText:String = 'Found 0 images matching "' + needle + '"';
			this.$intro.resultCount.text = resultText;
			this.displayNoResultsFoundAlert();
		}
	}
	private function displayNoResultsFoundAlert()
	{
		this.$noResultsFoundAlert.removeMovieClip();
		this.$noResultsFoundAlert = this.attachMovie('noResultsFoundAlert', 'noResultsFoundAlert',this.getNextHighestDepth());
		this.$noResultsFoundAlert._x = -(this.$noResultsFoundAlert._width);
		this.$noResultsFoundAlert._y = (Stage.height/2)-this.$noResultsFoundAlert._height;
		this.$animationManager = new org.caleb.animation.AnimationManager(this.$noResultsFoundAlert)
		this.$noResultsFoundAlert._alpha = 0;
		this.$animationManager.tween(['_x', '_alpha'], [(Stage.width/2)-(this.$noResultsFoundAlert._width/2), 100], 2, "easeoutelastic");
	}
	public function displayStageMask():Void
	{
		this.$stageMask = org.caleb.util.DrawingUtil.drawRectangle(this, Stage.width, Stage.height, 0, 0, 10, 0x333333, 0xFFFFFF);
		this.$stageMask._alpha = 0;
		this.$stageMask.onRelease = function():Void
		{
			this._parent.hideHelp();
		}
		//this.$animationManager = new org.caleb.animation.AnimationManager(this.$stageMask);
		//this.$animationManager.tween('_alpha', 100, 1);
	}
	public function hideStageMask():Void
	{
		trace('hideStageMask invoked');
		this.$stageMask.removeMovieClip();
		//this.$animationManager = new org.caleb.animation.AnimationManager(this.$stageMask);
		//this.$animationManager.tween('_alpha', 0, 1);
	}
	public function hideHelp():Void
	{
		//this.hideStageMask();
		trace('hideHelp invoked')
		this.$animationManager = new org.caleb.animation.AnimationManager(this.$help);
		this.$animationManager.tween('_alpha', 0, 1, undefined, undefined, [this, 'deleteHelp']);
	}
	private function deleteHelp():Void
	{
		trace('deleteHelp invoked');
		this.$help.removeMovieClip();
	}
	public function displayHelp():Void
	{
		trace('displayHelp invoked');
		this.displayStageMask();
		this.deleteHelp()
		this.$help = this.attachMovie('help', 'help', this.getNextHighestDepth());
		this.$help._x = (Stage.width/2)-(this.$help._width/2);
		this.$help._y = (Stage.height/2)-this.$help._height;
		this.$animationManager = new org.caleb.animation.AnimationManager(this.$help)
		this.$animationManager.tween(['_alpha'], [100], 2, "easeoutelastic");
		//_global.clearInterval(this.$hideHelpInterval);
		//this.$hideHelpInterval = _global.setTimeout(this, 'hideHelp', 3000);
	}
	/**
	 * 
	 * @usage   
	 * @param   e 
	 * @return  
	 */
	public function onImagesFound(e:org.caleb.event.Event):Void
	{
		trace('onImagesFound invoked');
		
		this.$noResultsFoundAlert.removeMovieClip();
		this.$intro.resultCount._visible = true;
		var count = e.getArgument('count');
		var needle = e.getArgument('needle');
		trace('onImagesFound invoked, count: ' + count + '; needle: ' + needle)
		var resultText:String = 'Displaying ';
		if(count >= this.$itemsPerPage)
		{
			// resultText += 'the first ';
		}
		resultText += count + ' image result';
		if(count != 1)
		{
			resultText += 's';
		}
		resultText += ' matching keyword';
		if(needle.split(' ').length > 1)
		{
			resultText += 's';
		}
		resultText += ' "'+needle+'"';
		resultText += ' (Page ';

		//trace('this: '+this)
		//trace('this.$controller: '+this.$controller)
		//for(var i in this.$controller) trace('key: ' + i + ', value: ' + this.$controller[i]);
		//trace('this.$controller.firstResultPosition: '+this.$controller.firstResultPosition)
		//trace('this.$itemsPerPage: '+this.$itemsPerPage)
		resultText += String(Math.ceil(ZoomSearchController(this.$controller).firstResultPosition/this.$itemsPerPage));

		resultText += ')';
		this.$intro.resultCount.text = resultText;
	}
	private function reset():Void
	{
		super.reset();
		//this.$controller.zoomOut();
		this.listResults._visible = false;
		this.$postIntroSetupComplete = false;
		this.$controller.currentId = undefined;
		this.$imageHeader.outro();
	}
	private function removeImages():Void
	{
		trace('destroyImages invoked');
		super.removeImages();
		this.$thumbs._alpha = 100;
	}
	private function fadeOutMiniView():Void
	{
		trace('fadeOutMiniView invoked')
		if(this.$items.length > 0 && this.$table._alpha > 0)
		{
			this.setupMiniView();
			this.$animationManager = new org.caleb.animation.AnimationManager(this.$table);
			this.$animationManager.tween('_alpha', 0, 1, undefined, undefined, [this, 'removeMiniView'])
		}
	}
	private function fadeInMiniView():Void
	{
		trace('fadeInMiniView invoked')
		if(this.$table._alpha < 100)
		{
			this.$animationManager = new org.caleb.animation.AnimationManager(this.$table);
			this.$animationManager.tween('_alpha', 100, 1);
		}
	}
	private function removeMiniView():Void
	{
		this.$table.removeMovieClip();
		delete this.$table;
		this.$table = undefined;
	}
	private function fadeOutImages():Void
	{
		trace('fadeOutImages invoked')
		if(this.$items.length > 0)
		{
			this.$animationManager = new org.caleb.animation.AnimationManager(this.$thumbs);
			this.$animationManager.tween('_alpha', 0, 1, undefined, undefined, [this, 'performSearch'])
		}
		else
		{
			this.performSearch();
		}
	}
	private function loadMainImages():Void
	{
		super.loadMainImages();
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
		//trace('this.$xmlString: ' + this.$xmlString)
		switch(this.$controller.mode)
		{
			case MODE_YAHOO:
			{
				this.$controller.xml = ZoomSearchXML.getYahooImageSearchZoomXML(new XML(this.$xmlString));
			}
			break;
			case MODE_FLICKR:
			{
				this.$controller.xml = ZoomSearchXML.getFlickrZoomXML(new XML(this.$xmlString), this.$flickrPhotos);
			}
			break;
		}
	}
	public function onZoomImageRollOver(e:org.caleb.event.Event):Void
	{
		for(var i in this.listResults)
		{
			if(org.caleb.util.ObjectUtil.isInstanceOf(this.listResults[i], ZoomSearchList))
			{
				this.listResults[i].expandCollapse(false);
			}
		}
	}
	private function onCellSelect(e:org.caleb.event.Event):Void
	{
		trace('onCellSelect invoked');
		var cell:TableCell = TableCell(e.getArgument('cell'));
		this.currentId = cell.index;
		//if(this.$controller.zoomedIn != true)
		{
			this.items[this.currentId].zoomIn();
		}
	}
	/**
	 * 
	 * @usage   
	 * @param   e 
	 * @return  
	 */
	public function onItemActivated(e:org.caleb.event.Event):Void
	{
		trace('onItemActivated invoked');
		super.onItemActivated(e);
		if(this.$table == undefined)
		{
			//this.setupMiniView();
		}
		this.$table.selectCell(this.$controller.currentItem.id);
		new mx.transitions.Tween(e.getSender(), "_xscale", mx.transitions.easing.Regular.easeOut, e.getSender()._xscale, 100, 15, false);
		new mx.transitions.Tween(e.getSender(), "_yscale", mx.transitions.easing.Regular.easeOut,  e.getSender()._yscale, 100, 15, false);
		
		if(this.$controller.currentItem.id == this.$itemsPerPage-1)
		{
			this.$imageHeader.topNav.nextButton._visible = false;
		}
		else
		{
			this.$imageHeader.topNav.nextButton._visible = true;
		}
		if(this.$controller.currentItem.id == 0)
		{
			this.$imageHeader.topNav.previousButton._visible = false;
		}
		else
		{
			this.$imageHeader.topNav.previousButton._visible = true;
		}
		if(this.$controller.currentItem.row < this.$controller.rows-1)
		{
			this.$imageHeader.topNav.downButton._visible = true;
		}
		else
		{
			this.$imageHeader.topNav.downButton._visible = false;
		}
		if(this.$controller.currentItem.row > 0)
		{
			this.$imageHeader.topNav.upButton._visible = true;
		}
		else
		{
			this.$imageHeader.topNav.upButton._visible = false;
		}
		this.$table.swapDepths(this.getNextHighestDepth());
		this.$paginator.swapDepths(this.getNextHighestDepth());
		this.listResults.swapDepths(this.getNextHighestDepth());
	}
	/**
	 * 
	 * @usage   
	 * @param   e 
	 * @return  
	 */
	public function onZoomInInit(e:org.caleb.event.Event):Void
	{
		this.hideAllButtons();
		this.onItemActivated(e);
		this.$animationManager = new AnimationManager(this.$imageHeader.topNav);
		this.$animationManager.tween(['_x'], [Stage.width/2 - this.$imageHeader.topNav._width/2], 1)
		this.$animationManager = new AnimationManager(this.$imageHeader.detailsText);
		this.$animationManager.tween(['_x', '_y'], [Stage.width/2 - this.$imageHeader.detailsText._width/2, Stage.height - this.$imageHeader.detailsText._height], 1)
		this.$animationManager = new AnimationManager(this.$imageHeader.shade);
		this.$animationManager.tween('_y', Stage.height - this.$imageHeader.detailsText._height, 1)
	}
	/**
	 * 
	 * @usage   
	 * @param   e 
	 * @return  
	 */
	public function onZoomOutInit(e:org.caleb.event.Event):Void
	{
		super.onZoomOutInit(e);
		//this.$table.deselectAll();
		//this.fadeOutMiniView();
		this.hideAllButtons();
	}
	/**
	 * 
	 * @usage   
	 * @param   e 
	 * @return  
	 */
	public function onZoomOutComplete(e:org.caleb.event.Event):Void
	{
		super.onZoomOutInit(e);
		this.hideAllButtons();
	}
	public function setMiniViewCellMode(index:Number, mode:String)
	{
		this.$table.setCellMode(index, mode);
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function hideAllButtons()
	{
		for(var it in this.items)
		{
			this.items[it].hideButtons();
		}
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
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get xmlString():String
	{
		return this.$xmlString;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get mode():String
	{
		return this.$controller.mode;
	}
	/**
	 * 
	 * @usage   
	 * @param   x 
	 * @return  
	 */
	public function set xmlString(x:String):Void
	{
		this.$xmlString = x;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get itemsPerPage():Number
	{
		return this.$itemsPerPage;
	}
	/**
	 * Enter description here
	 * 
	 * @usage   
	 * @return  
	 */
	public function get controller():ZoomSearchController
	{
		return this.$controller;
	}
}