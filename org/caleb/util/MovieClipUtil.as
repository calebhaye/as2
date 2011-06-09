import org.caleb.core.CoreObject;
import org.caleb.loader.DynamicPreloader;
import org.caleb.animation.AnimationManager;
/**
 * This class provides a layer of abstraction for common MovieClip tasks 
 * @see     CoreObject	
 */
class org.caleb.util.MovieClipUtil extends CoreObject
{
	public static var DRAG_LIMITATION_HORIZONTAL:String = 'horizontal';
	public static var DRAG_LIMITATION_VERTICAL:String = 'vertical';
	private static var $checks:Object;
	
	/**
	 * Method to tween properties on an object
	 * @usage	org.caleb.animation.AnimationManager.tween ("_alpha", 0);
	 * @usage	org.caleb.animation.AnimationManager.tween (["_x", "_y"], [100, 100], 4, "linear");
	 * @usage	org.caleb.animation.AnimationManager.tween ("_yscale", 200, 3, undefined, undefined, [myObj, doPlay]);
	 * @usage 	org.caleb.animation.AnimationManager.tween ("_alpha", 100, 1);
	 * @param	prop (String/Array) property or an array of properties to be tweened
	 * @param	propDest (String/Array) final values for associated object properties
	 * @param	timeSeconds (Number) seconds to reach the end values
	 * @param 	animType (String) animation equation type
	 * @param	delay (Number) number of seconds to delay before beginning tween
	 * @param	callback (Array) object and method to call when tween has completed. [obj:Object, function:Function]
	 * @param	extra1 (Number) optional animation parameter defining amplitude in animType='elastic' or overshoot amount in animType='back'
	 * @param	extra2 (Number) optional animation parameter defining period in animType='elastic'
	 **/
	
	public static function tween(target, prop, propDest, timeSeconds, animType, delay, callback, extra1, extra2):Number
	{
		var yt:AnimationManager = new AnimationManager(target);
		return yt.tween(prop, propDest, timeSeconds, animType, delay, callback, extra1, extra2);
	}
	public static function centerInsideStage(clipToBeCentered:MovieClip, vertical:Boolean, horiz:Boolean):Void
	{
		/*
		org.caleb.Configuration.Log.info('centerInsideStage invoked');
		org.caleb.Configuration.Log.info('clipToBeCentered._width: ' + clipToBeCentered._width);
		org.caleb.Configuration.Log.info('clipToBeCentered._height: ' + clipToBeCentered._height);
		*/
		if(horiz != false)
		{
			clipToBeCentered._x = MovieClipUtil.getStageCenterX(clipToBeCentered);
			//org.caleb.Configuration.Log.info('clipToBeCentered._x: ' + clipToBeCentered._x);
		}
		if(vertical != false)
		{
			clipToBeCentered._y = MovieClipUtil.getStageCenterY(clipToBeCentered);
			//org.caleb.Configuration.Log.info('clipToBeCentered._y: ' + clipToBeCentered._y);
		}
	}
	public static function centerInsideClip(parentClip, clipToBeCentered:MovieClip, vertical:Boolean, horiz:Boolean):Void
	{
		if(horiz != false)
		{
			clipToBeCentered._x = (parentClip._width - clipToBeCentered._width) / 2;
		}
		if(vertical != false)
		{
			clipToBeCentered._y = (parentClip._height- clipToBeCentered._height) / 2;
		}
	}
	public static function proportionalScaleDown(target:MovieClip, maxWidth:Number, maxHeight:Number):Number
	{
		//trace('proportionalScaleDown invoked maxWidth: ' + maxWidth + ', maxHeight: ' + maxHeight);
		//if(maxWidth < target._width || maxHeight < target._height)
		{
			var imageOffset:Number = Math.min( (maxWidth / target._width), (maxHeight / target._height) );
			target._width = imageOffset * target._width;
			target._height = imageOffset * target._height;
			return imageOffset;
		}
		
	}
	public static function scaleToFit(target:MovieClip, w:Number, h:Number):Void
	{
		//trace('scaleToFit: ' + w + ', h: ' + h);
		var imageOffset:Number = Math.max( (w / target._width), (h / target._height) );
		target._width = imageOffset * target._width;
		target._height = imageOffset * target._height;
	}
	public static function getStageCenterX(target):Number
	{
		return (Stage.width - target._width) / 2;
	}
	public static function getStageCenterY(target):Number
	{
		return (Stage.height - target._height) / 2;
	}
	public static function getCenterX(target):Number
	{
		return target._x + (target._width/2);
	}
	public static function getCenterY(target):Number
	{
		return target._y + (target._height/2);
	}
	
	public static function constrain(mc:MovieClip,maxW:Number,maxH:Number):Void 
	{
		if(mc._height > mc._width) {		
			if(mc._height > maxH) {
				var pctDiff = maxH / mc._height * 100;
				mc._xscale = mc._yscale = pctDiff;
				mc._x = mc._x + ((maxW - mc._width)/2);
			}
			else { // smaller than constraints
				mc._x = mc._x + ((maxW - mc._width)/2);
				mc._y = mc._y + ((maxH - mc._height)/2);			
			}
		}
		else {
			if(mc._width > maxW) {
				var pctDiff = maxW / mc._width * 100;
				mc._xscale = mc._yscale = pctDiff;
				mc._y = mc._y + ((maxH - mc._height)/2);
			}
			else { // smaller than constraints
				mc._x = mc._x + ((maxW - mc._width)/2);
				mc._y = mc._y + ((maxH - mc._height)/2);			
			}
		}	
		return;
	}

	public static function fill(mc:MovieClip,maxW:Number,maxH:Number):Void 
	{
        var targetAspectRatio:Number = maxW/maxH;
        var srcAspectRatio:Number = mc._width/mc._height;
        var parent:MovieClip = mc._parent;
        if (srcAspectRatio < targetAspectRatio) {
            mc._width = maxW;
            mc._height = maxW / srcAspectRatio;
            
        } else {
            mc._height = maxH;
            mc._width = maxH * srcAspectRatio;
        }
        var mask = parent['mask'];
        if (!mask)
            mask = parent.createEmptyMovieClip("mask",parent.getNextHighestDepth());

        mask._visible = false;
        mask.clear();
        mask._x = -maxW/2;
        mask._y = -maxH/2;

        mask.moveTo(0,0);
        mask.beginFill(0xFF0000);
        mask.lineTo(maxW,0);
        mask.lineTo(maxW,maxH);
        mask.lineTo(0,maxH);
        mask.lineTo(0,0);
        mask.endFill();

		mc.setMask(mask);


	}

	public static function crop(mc:MovieClip,maxW:Number,maxH:Number):Void 
	{
		// centers image into cropped area
		var mask = mc.createEmptyMovieClip("mask",5);
		mask._x -= ((maxW-mc._width)/2);
		mask._y -= ((maxH-mc._height)/2);
		with(mask) {
			moveTo(0,0);
			beginFill(0xFF0000)
			lineTo(maxW,0);
			lineTo(maxW,maxH);
			lineTo(0,maxH);
			lineTo(0,0);
			endFill();
		}
		mc.setMask(mask);
		mc._x += ((maxW-mc._width)/2);
		mc._y += ((maxH-mc._height)/2);
		return;
	}
	public static function removeDragHandler(target:MovieClip):Void
	{
		target.onPress = undefined;
	}
	public static function makeUndraggable(target:MovieClip):Void
	{
		if(target.oldOnPress == undefined)
		{
			delete target.onPress;
		}
		else
		{
			target.onPress = target.oldOnPress;
		}
		if(target.oldOnRelease == undefined)
		{
			delete target.onRelease;
		}
		else
		{
			target.onRelease = target.oldOnRelease;
		}
		if(target.oldOnReleaseOutside == undefined)
		{
			delete target.onReleaseOutside;
		}
		else
		{
			target.onReleaseOutside = target.oldOnReleaseOutside;
		}
		if(target.oldOnMouseMove == undefined)
		{
			delete target.onMouseMove;
		}
		else
		{
			target.onMouseMove = target.oldOnMouseMove;
		}
	}
	public static function makeDraggable(target:MovieClip):Void
	{
		if(arguments[2] != undefined)
		{
			target.dragTargets = arguments[2];
		}
		else
		{
			target.dragTargets = new Array;
		}
		var limit:String;
		if(target instanceof org.caleb.event.Observable == false)
		{
			org.caleb.decorator.Observer.makeObservable(target);
		}
		target.addEventObserver(target, 'onDrop');
		target.addEventObserver(target, 'onDragRollOver');
		target.addEventObserver(target, 'onDragRollOut');
		target.addEventObserver(target, 'onDragInit');
		target.addEventObserver(target, 'onDragInterval');
		target.addEventObserver(target, 'onDragComplete');
		if(target.onPress != undefined)
		{
			target.oldOnPress = target.onPress;
		}
		var e:org.caleb.event.Event = new org.caleb.event.Event('onDragInit');
		if(arguments[1] == DRAG_LIMITATION_HORIZONTAL || arguments[1] == DRAG_LIMITATION_VERTICAL)
		{
			limit = arguments[1];
			//trace('drag limitation: ' + limit)
		}
		target.onPress = function():Void
		{
			this.oldOnPress();
			this.oldOnRelease = this.onRelease;
			this.oldOnReleaseOutside = this.onReleaseOutside;
			this.oldOnMouseMove = this.onMouseMove;
			e.setType('onDragInit');
			e.addArgument('target', target)
			this.dispatchEvent(e);
			var offset:Object = new Object;
			offset.x = this._x - this._parent._xmouse;
			offset.y = this._y - this._parent._ymouse;

			this.onMouseMove = function():Void 
			{
				for(var o in this.dragTargets)
				{
					if(this.dragTargets[o].wasOver == undefined)
					{
						this.dragTargets[o].wasOver = false;
					}
					if (this.dragTargets[o].hitTest(this) == true) 
					{
						//if(this.dragTargets[o].wasOver == false)
						{
							this.dragTargets[o].wasOver = true;
							var dragOverEvent = new org.caleb.event.Event('onDragRollOver');
							dragOverEvent.addArgument('target', this);
							dragOverEvent.addArgument('dragTarget', this.dragTargets[o]);
							this.dispatchEvent(dragOverEvent);

							break;
						}
					}
					else
					{
						if(this.dragTargets[o].wasOver == true)
						{
							this.dragTargets[o].wasOver = false;
							var dragOutEvent = new org.caleb.event.Event('onDragRollOut');
							dragOutEvent.addArgument('target', this);
							dragOutEvent.addArgument('dragTarget', this.dragTargets[o]);
							this.dispatchEvent(dragOutEvent);
							
							break;
						}
					}
				}
				if(limit != MovieClipUtil.DRAG_LIMITATION_VERTICAL)
				{
					this._x = this._parent._xmouse + offset.x;
				}
				if(limit != MovieClipUtil.DRAG_LIMITATION_HORIZONTAL)
				{
					this._y = this._parent._ymouse + offset.y;
				}
				this.oldOnMouseMove();
				e.setType('onDragInterval');
				this.dispatchEvent(e);
				this.updateAfterEvent();
			}
			this.onRelease = function():Void
			{
				for(var o in this.dragTargets)
				{
					if (this.dragTargets[o].hitTest(this) == true) 
					{
						var onDropEvent = new org.caleb.event.Event('onDrop');
						onDropEvent.addArgument('target', this);
						onDropEvent.addArgument('dragTarget', this.dragTargets[o]);
						this.dispatchEvent(onDropEvent);
					}
				}
				this.onMouseMove = this.oldOnMouseMove;
				this.onRelease = this.oldOnRelease;
				this.onReleaseOutside = this.oldOnReleaseOutside;
				this.onRelease();
				e.setType('onDragComplete');
				this.dispatchEvent(e);
			}
			this.onReleaseOutside = function():Void
			{
				this.onReleaseOutside = this.oldOnReleaseOutside;
				this.onReleaseOutside();
				this.onRelease();
			}
		}
	}
	/**
	 * This method simple applys a complete alpha fade (start:0, end: 100) to an object and makes it visible
	 * 
	 * @usage   fadeIn(myMC, 10, myContextObject, myFunction);
	 * @param   target (MovieClip) to fadeIn
	 * @param   time (Number) the duration of the transition
	 * @param   context (Object) The scope of the target
	 * @param   callback (Function) method to invoke upon completion
	 */
	public static function fadeIn(target:MovieClip, time:Number, context:Object, callback:Function, delay:Number)
	{
		target._visible = true;
		var start = 0;
		var end = 100;
		if(isNaN(arguments[5]) != true)
		{
			end = arguments[5];
		}
		if(isNaN(arguments[6]) != true)
		{
			start = arguments[6];
		}
		target._alpha = start;
		trace('tweening tooooooooooooooooooo: ' + end + ' from ' + start);
		MovieClipUtil.tween(target, '_alpha', end, time, 'easeinquad', delay, [context, callback])
	}
	/**
	 * This method simple applys a complete alpha fade (start:100, end: 0) to an object and makes it invisible upon completion
	 * 
	 * @usage   fadeOut(myMC, 10, myContextObject, myFunction);
	 * @param   target (MovieClip) to fadeIn
	 * @param   time (Number) the duration of the transition
	 * @param   context (Object) The scope of the target
	 * @param   callback (Function) method to invoke upon completion
	 */
	public static function fadeOut(target:MovieClip, time:Number, context:Object, callback:String, delay:Number)
	{
		var start = 100;
		var end = 0;
		if(isNaN(arguments[5]) != true)
		{
			end = arguments[5];
		}
		if(isNaN(arguments[6]) != true)
		{
			start = arguments[6];
		}
		target._alpha = start;
		MovieClipUtil.tween(target, '_alpha', end, time, 'easeinquad', delay, [context, callback])
	}
	/**
	 * This method loads a swf into a MovieClip and draws a progress bar to illustrate the load progress
	 * 
	 * @usage   MovieClipUtil.loadContent(myTargetMC, 'foo.swf', 100, 200, this, this.onIntroComplete);
	 * @param   target (MovieClip) the instance to load the content into
	 * @param   url    (String) the url of the content to load
	 * @param   x      (Number) the x position of the loading progress bar
	 * @param   y      (Number) the y position of the loading progress bar
	 * @param   context [Optional] (MovieClip) The scope of the target     
	 * @param   callback [Optional] (Function) method to invoke upon completion     
	 */
	public static function loadContent(target:MovieClip, url:String, x:Number, y:Number):Void
	{		
		var $loader = new DynamicPreloader(target, target._name + '_DyanamicPreloader')
		// check for load handler
		if(arguments[4] != undefined)
		{
			if((org.caleb.util.ObjectUtil.isSet(arguments[4]) == true) && (typeof(arguments[5]) == typeof(Function)))
			{
				$loader.context = arguments[4];
				$loader.onLoadComplete = arguments[5];
			}
		}
		// load
		$loader.doLoad(url, x, y);
	}
	/**
	 * 
	 * @usage   MovieClipUtil.hasLoaded(myMC);
	 * @param   target (MovieClip) MovieClip instance to check load status of
	 * @return  Boolean
	 */
	public static function hasLoaded(target:MovieClip):Boolean{
		return (target.getBytesLoaded() >= target.getBytesTotal());
	}

	public static function loadClip(scope:Object, target:MovieClip, callback:String, url:String):Void
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		var listener:Object = new Object;
		listener.context = scope;
		listener.callback = callback;

		listener.onLoadInit = function(mc:MovieClip) 
		{
			this.context[callback](true);
		}
		listener.onLoadError = function(target_mc:MovieClip, errorCode:String) 
		{
			//trace("ERROR CODE = "+errorCode);
			//trace("Your load failed on movie clip = "+target_mc+"\n");
			this.context[callback](false);
		}

		mcLoader.addListener(listener);
		mcLoader.loadClip(url, target);
	}

	/**
	 * 
	 * @usage   MovieClipUtil.getPercentLoaded(myMC);
	 * @param   target (MovieClip) MovieClip instance to get load percentage of
	 */
	public static function getPercentLoaded(target:MovieClip):Number
	{
		return 100 * (target.getBytesLoaded() / target.getBytesTotal());
	}
	/**
	* Deprecated, candidate for removal
	* MovieClipLoader provides most of the functionality this method was intended to address
	*/
	public static function setLoadCallbacks(target:MovieClip,
						dataCallbackObject:Object,
						dataCallbackMethod:Function,
						dataCallbackArgs:Object,
						completeCallbackObject:Object,
						completeCallbackMethod:Function,
						completeCallbackArgs:Object):Void{
		if(typeof $checks != 'object'){
			$checks = new Object();
		}
		var checksId = target;
		var key = '' + target + '';
		var o;
		if(typeof $checks[key] != 'object'){
			o = new Object();
		}
		o.target = target;
		o.dataCallbackObject = dataCallbackObject;
		o.dataCallbackMethod = dataCallbackMethod;
		o.dataCallbackArgs = dataCallbackArgs;
		o.completeCallbackObject = completeCallbackObject;
		o.completeCallbackMethod = completeCallbackMethod;
		o.completeCallbackArgs = completeCallbackArgs;
		o.begin = function(){
			this.interval = setInterval(this, 'checkData', 80);
		}
		o.oldData = -1;
		o.checkData = function(){
			var bl = this.target.getBytesLoaded();
			if(bl > 200 && this.oldData < bl){
				//	we got some new data loaded into (target)
				trace('calling: ' + this.dataCallbackMethod + ' on: ' + this.dataCallbackObject);
				if(typeof this.dataCallbackMethod == 'function'){
					this.dataCallbackMethod.apply(this.dataCallbackObject, this.dataCallbackArgs);
				}
				if(bl >= this.target.getBytesTotal()){
					if(typeof this.completeCallbackMethod == 'function'){ 
						this.completeCallbackMethod.apply(this.completeCallbackObject, this.completeCallbackArgs);
					}
					clearInterval(this.interval);
					delete(this);
				}
			}
		}
		$checks[key] = o;
		$checks[key].begin();
	}
}
