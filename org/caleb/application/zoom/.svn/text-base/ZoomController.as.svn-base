import org.caleb.event.ObservableObject;
import org.caleb.application.zoom.ZoomView;
import org.caleb.application.zoom.ZoomImage;
import org.caleb.application.zoom.ZoomData;
import org.caleb.application.zoom.ZoomXML;
import org.caleb.animation.AnimationManager;

/**
 * 
 * @author  calebh
 * @version 1.0
 * @see     ObservableObject
 * @since   
 */
class org.caleb.application.zoom.ZoomController extends ObservableObject
{
	public static var DEFAULT_EASE_TYPE:String = 'easeoutsine';
	public static var THUMB_PREFIX:String = 'zoomThumb';
	public static var ROTATE_ON_ZOOM_IN:Boolean = false;
	public static var ROTATE_ON_ZOOM_OUT:Boolean = false;
	private var $view:ZoomView;
	private var $data:ZoomData;
	private var $zoomXML:ZoomXML;
	private var $animationManager:AnimationManager;
	
	/**
	 * 
	 * @usage   
	 * @param   zoomViewer 
	 * @param   zoomWidth  
	 * @param   zoomHeight 
	 * @return  
	 */
	public function ZoomController(zoomViewer)
	{
		this.setClassDescription('org.caleb.application.zoom.ZoomController');
		//trace('constructor invoked');
		this.$data = new ZoomData;
		this.initData(zoomViewer);
		
	}
	public function set xml(x:XML):Void
	{
		this.initXML();
		this.$zoomXML.xml = x;
	}
	public function loadXML(arg:String):Void
	{
		this.initXML();
		this.$zoomXML.load(arg);
	}
	public function initXML():Void
	{
		this.$zoomXML = new ZoomXML;
		this.$zoomXML.addEventObserver(this, 'onZoomXMLReady');
		this.$zoomXML.controller = this;
	}
	private function onZoomXMLReady(e:org.caleb.event.Event):Void
	{
		this.dispatchEvent(e);
	}
	private function initData(zoomViewer):Void
	{
		//trace('ZoomController initData invoked');
		// init params
		this.$view = zoomViewer;
		// defaults
		this.$data.initialScale = 15;
		//this.$data.launchX = -50;
		//this.$data.launchY = -100;
		this.$data.outX = 25;
		this.$data.outY = 75;
		this.$data.zoomOutPerc = 15;
		this.$data.maxRows = 50;
		this.$data.zoomInPerc = 150;
		this.$data.tweenLen = .5;
		this.$data.zoomedIn = false;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function rotateToOriginal():Void
	{
		var targetRotation:Number;
		if(ROTATE_ON_ZOOM_IN == true)
		{
			targetRotation = -1 * (360 + this.$view.imageRotationMap[this.$view.currentId]);
		}
		else
		{
			targetRotation = this.$view.imageRotationMap[this.$view.currentId]
		}
		this.$animationManager = new AnimationManager(this.$view.thumbs[ZoomController.THUMB_PREFIX + this.$view.currentId]);
		this.$animationManager.tween('_rotation', targetRotation, this.$data.tweenLen, DEFAULT_EASE_TYPE);
	}
	/**
	 * 
	 * @usage   
	 * @param   x 
	 * @param   y 
	 * @return  
	 */
	public function zoomIn(x,y):Void
	{
		//trace('zoomIn invoked');
		this.$data.zoomedIn = true;
	
		// dispatch zoom init events
		var e = new org.caleb.event.Event('onZoomInInit');
		e.setArgument('item', this.currentItem);
		this.dispatchEvent(e);
		var e = new org.caleb.event.Event('onItemDeactivated');
		e.setArgument('item', this.previousItem);
		this.dispatchEvent(e);

		//this.$animationManager = new AnimationManager(this.currentItem);
		var targetRotation:Number = 0;
		if(ROTATE_ON_ZOOM_IN == true)
		{
			targetRotation = 360;
		}
		this.currentItem.swapDepths(this.currentItem._parent.getNextHighestDepth());
		//this.$animationManager.tween(['_alpha', '_rotation'], [100, targetRotation], this.$data.tweenLen, DEFAULT_EASE_TYPE);

		//this.$animationManager = new AnimationManager(this.previousItem);
		//var targetRotation:Number = this.$view.imageRotationMap[this.$view.currentId];
		//this.$animationManager.tween(['_alpha', '_rotation'], [35, targetRotation], this.$data.tweenLen, DEFAULT_EASE_TYPE);
		//this.$animationManager.tween(['_alpha', '_rotation'], [100, targetRotation], this.$data.tweenLen, DEFAULT_EASE_TYPE);
		
		trace('x: ' + x);
		trace('y: ' + y);

		this.$animationManager = new AnimationManager(this.$view.thumbs);
		var endX:Number = Math.round((this.$view.stageWidth/2) - (x * this.$data.zoomInPerc/100));
		var endY:Number = Math.round((this.$view.stageHeight/2) - (y * this.$data.zoomInPerc/100));
		var tweenProperties:Array = new Array('_xscale', '_yscale', '_x', '_y');
		var tweenEndValues:Array = new Array(this.$data.zoomInPerc, this.$data.zoomInPerc, endX, endY);
		var tweenHandler:Array = new Array(this.$view, 'onItemActivated');
		this.$animationManager.tween(tweenProperties, tweenEndValues, Math.round(this.$data.tweenLen * .9), DEFAULT_EASE_TYPE, 0, tweenHandler);
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function zoomOut(speed:Number):Void
	{		
		if(isNaN(speed)) 
		{
			speed = this.$data.tweenLen*2;
		}
		//trace('zoomOut invoked');
		this.$data.zoomedIn = false;
		this.rotateToOriginal();
		// dispatch zoom init event
		var e = new org.caleb.event.Event('onZoomOutInit');
		e.setArgument('item', this.currentItem);
		this.dispatchEvent(e);
		var e = new org.caleb.event.Event('onItemDeactivated');
		e.setArgument('item', this.previousItem);
		this.dispatchEvent(e);

		this.$animationManager = new AnimationManager(this.currentItem);
		//this.$animationManager.tween(['_alpha'], [35], this.$data.tweenLen, DEFAULT_EASE_TYPE);

		this.$animationManager = new AnimationManager(this.$view.thumbs);
		var tweenProperties:Array = new Array('_xscale', '_yscale', '_x', '_y');
		var tweenEndValues:Array = new Array(this.$data.zoomOutPerc, this.$data.zoomOutPerc, this.$data.outX, this.$data.outY);
		var tweenHandler:Array = new Array(this.$view, 'onZoomOutComplete');
		this.$animationManager.tween(tweenProperties, tweenEndValues, speed, "easeinoutcubic", 0, tweenHandler);
	}
	public function reset():Void
	{
		org.caleb.application.zoom.ZoomImage.LOAD_THUMBS = true;
		this.$data.loadedImages = new Array;
		this.$data.currentId = undefined;
		//this.removeAllEventObservers();
		//this.$view.init();
	}
	public function onLeft():Void
	{
		//trace('onLeft invoked');
		this.$view.onLeft();
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onRight():Void
	{
		trace('onRight invoked');
		this.$view.onRight();
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onUp():Void
	{
		trace('onUp invoked');
		this.$view.onUp();
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onDown():Void
	{
		trace('onDown invoked');
		this.$view.onDown();
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onEnter():Void
	{
		trace('onEnter invoked');
		this.$view.onEnter();
	}
	/**
	 * 
	 * @usage   
	 * @param   p 
	 * @return  
	 */
	public function set zoomOutPercentage(p:Number):Void
	{
		this.$data.zoomOutPerc = p;
		this.$view.thumbs._xscale = p;
		this.$view.thumbs._yscale = p;		
	}
	/**
	 * 
	 * @usage   
	 * @param   p 
	 * @return  
	 */
	public function set zoomInPercentage(p:Number):Void
	{
		this.$data.zoomInPerc = p;
	}
	/**
	 * 
	 * @usage   
	 * @param   w 
	 * @return  
	 */
	public function set width(w:Number):Void
	{
		this.$data.width = w; 
	}
	/**
	 * 
	 * @usage   
	 * @param   h 
	 * @return  
	 */
	public function set height(h:Number):Void
	{
		this.$data.height = h;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get width():Number
	{
		return this.$data.width;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get height():Number
	{
		return this.$data.height;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get outY():Number
	{
		return this.$data.outY;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function set outY(y:Number):Void
	{
		// trace('OUT Y SET TO: ' + y)
		this.$data.outY = y;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get outX():Number
	{
		return this.$data.outX;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function set outX(x:Number):Void
	{
		// trace('OUT X SET TO: ' + x)
		this.$data.outX = x;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get zoomedIn():Boolean
	{
		return this.$data.zoomedIn;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get currentId():Number
	{
		// trace('GETTING CURRENT FROM DATA:');
		// trace('this.$data: '+this.$data);
		// for(var i in this.$data) trace('key: ' + i + ', value: ' + this.$data[i]);
		return this.$data.currentId;
	}
	public function get currentItem():ZoomImage
	{
		// trace('GETTING CURRENT FROM DATA:');
		// trace('this.$data: '+this.$data);
		// for(var i in this.$data) trace('key: ' + i + ', value: ' + this.$data[i]);
		return this.$view.items[this.$data.currentId];
	}
	public function get nextItem():ZoomImage
	{
		// trace('GETTING CURRENT FROM DATA:');
		// trace('this.$data: '+this.$data);
		// for(var i in this.$data) trace('key: ' + i + ', value: ' + this.$data[i]);
		return this.$view.items[this.$data.nextId];
	}
	public function get previousItem():ZoomImage
	{
		// trace('GETTING CURRENT FROM DATA:');
		// trace('this.$data: '+this.$data);
		// for(var i in this.$data) trace('key: ' + i + ', value: ' + this.$data[i]);
		return this.$view.items[this.$data.previousId];
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function set currentId(id:Number):Void
	{
		// trace('SETTING CURRENT ON DATA TO: ' + id);
		this.$data.currentId = id;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get previousId():Number
	{
		return this.$data.previousId;
	}
	public function get nextId():Number
	{
		return this.$data.nextId;
	}
	/**
	* Accessor for private $imageDimensions var.
	* @return Number.
	**/
	public function get imageDimensions():Number
	{
		return this.$data.imageDimensions;
	}
	/**
	* Mutator for private $imageDimensions var.
	* @param arg Number
	**/
	public function set imageDimensions(arg:Number) 
	{
		this.$data.imageDimensions = arg;
	}
	/**
	* Accessor for private $frameWidth var.
	* @return Number.
	**/
	public function get frameWidth():Number
	{
		return this.$data.frameWidth;
	}
	/**
	* Mutator for private $frameWidth var.
	* @param arg Number
	**/
	public function set frameWidth(arg:Number) 
	{
		this.$data.frameWidth = arg;
	}
	/**
	* Accessor for private $columns var.
	* @return Number.
	**/
	public function get columns():Number
	{
		return this.$data.columns;
	}
	public function get rows():Number
	{
		return Math.ceil(this.$view.items.length / this.$data.columns);
	}
	/**
	* Mutator for private $columns var.
	* @param arg Number
	**/
	public function set columns(arg:Number) 
	{
		this.$data.columns = arg;
	}
	public function get maxRows():Number
	{
		return this.$data.maxRows;
	}
	public function set maxRows(arg:Number) 
	{
		//trace('set maxRows: ' + arg)
		this.$data.maxRows = arg;
	}
	public function get launchX():Number
	{
		return this.$data.launchX;
	}
	public function set launchX(arg:Number) 
	{
		this.$data.launchX = arg;
	}
	public function get launchY():Number
	{
		return this.$data.launchY;
	}
	public function set launchY(arg:Number) 
	{
		this.$data.launchY = arg;
	}
	public function get data():ZoomData
	{
		return this.$data;
	}
	public function get initialScale():Number
	{
		return this.$data.initialScale;
	}
	public function get view():ZoomView
	{
		return this.$view;
	}
	public function set initialScale(arg:Number) 
	{
		this.$data.initialScale = arg;
	}	
	public function get imageURLs():Array
	{
		return this.$zoomXML.imageURLs;
	}
	public function get thumbURLs():Array
	{
		return this.$zoomXML.thumbURLs;
	}
	public function get imageDetailsMap():Array
	{
		return this.$zoomXML.imageDetailsMap;
	}
	public function get imageCount():Number
	{
		return this.$zoomXML.firstChild.childNodes.length
	}
	public function get relativeWidth():Number
	{
		return this.$data.outX + this.$data.width * (this.$data.initialScale/100);
	}
	public function get relativeHeight():Number
	{
		return this.$data.height * (this.$data.initialScale/100);
	}
	public function get loadedImages():Array
	{
		return this.$data.loadedImages;
	}
	public function get loadAttemptComplete():Boolean
	{
		return (this.$data.loadedImages.length >= this.$view.items.length);
	}
	public function set loadAttemptComplete(arg:Boolean):Void
	{
		if(arg == true)
		{
			//trace('dispatching onLoadAttemptComplete event')
			var e:org.caleb.event.Event = new org.caleb.event.Event('onLoadAttemptComplete');
			this.dispatchEvent(e);
		}
	}
}