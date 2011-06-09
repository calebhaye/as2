/**
 * SliderTween, version 1
 * @class:   org.caleb.components.slider.SliderTween
 * @usage:   var oListener:Object = new Object();
 
             oListener.onInit = function(oEvent:Object):Void {...};
			 oListener.onProgress = function(oEvent:Object):Void {...};
			 oListener.onComplete = function(oEvent:Object):Void {...};
			 
			 //outside the object
			 function test():Void{...}

             var twCircle:SliderTween = new SliderTween(circle_mc,
										   [{prop:'_x',start:10,end:200},
										    {prop:'_alpha',start:10,end:100}],
											1000,
										    mx.transitions.easing.Regular.easeIn,
											false);
			 
			 // alternative--> var twCircle:SliderTween = new SliderTween(circle_mc);
			 //                twCircle.duration=1000;
			 //				   twCircle.setSliderTweenProperty ('_x', 0, 100)
			 //                twCircle.easingFunction=mx.transitions.easing.Regular.easeIn
			 //				   twCircle.start();
			 
 
             twCircle.addEventListener("onInit", oListener);
			 twCircle.addEventListener("onProgress", oListener);
			 twCircle.addEventListener("onComplete", oListener);
			 //twCircle.addEventListener("onComplete", lessrain.lib.utils.Slider.create(this, test));
             
 */
import org.caleb.components.slider.Slider;
import mx.events.EventDispatcher;

class org.caleb.components.slider.SliderTween

{
/**
 * @property properties_array  (Array)    -- SliderTween more than one property at a time.
 * @property _duration         (Number)   -- Duration in milliseconds.
 * @property _tweenInterval         (Number)   --
 * @property _oTarget          (Object)   -- the target could be a movieclip or an object.
 * @property _startTime        (Number)   -- start timer.
 * @property _ease )           (Function) -- easing function.
 */
	
	private var properties_array:Array;
	private var _duration:Number;
	private var _tweenInterval:Number;
	private var _oTarget:Object;
	private var _startTime:Number;
	private var _ease:Function;
	
	// required for EventDispatcher:
	private var dispatchEvent:Function;
	public var addEventListener:Function;
	public var removeEventListener:Function;
	
	//setter
	public function set duration(nDuration:Number):Void 
	{
		_duration = nDuration;
	}

    public function set easingFunction(fEasingFunction:Function):Void 
    {
	   _ease= (fEasingFunction!=undefined)? fEasingFunction : easingDefault;
	   
	}
  
/**
 * SliderTween constructor
 * @param  target          Object to tween
 * @param  tweenPropList   Properties to tween
 * @param  tweenDuration   duration in milliseconds
 * @param  easingFunction  easing function --> mx.transitions.easing.Regular.easeIn
 */
	function SliderTween (target:Object, tweenPropList:Object, tweenDuration:Number, easingFunction:Function,startFlag:Boolean)
	{
		_oTarget = target;
		
		// defaults to 1 second
		_duration = tweenDuration || 1000;
		
		// defaults to None
		_ease = (easingFunction!=undefined)?easingFunction : easingDefault;
		
		
		properties_array = new Array ();
		
		if(tweenPropList!=undefined) for (var a in tweenPropList) setSliderTweenProperty (tweenPropList[a].prop, tweenPropList[a].start, tweenPropList[a].end);
		
		EventDispatcher.initialize (this);
		
		if(startFlag) start()

	}
	
	public function reset():Void
	{
		properties_array = new Array ();
	}
	
	public function setSliderTweenProperty (sProperty:String, nStart:Number, nEnd:Number):Void
	{
		/*
		the SliderTween class assumes the current value. For example, 
        if the current _alpha value is 100, the following tweens to 0,
        assuming 100 as the starting point. {prop:'_alpha', end: 0}
		*/
		if(nStart==undefined) nStart = _oTarget[sProperty];
        if(nEnd==undefined) nEnd = _oTarget[sProperty];
		
        properties_array.push ({prop:sProperty, start:nStart, end:nEnd});
	}
	
	public function stop ():Void
	{
		clearInterval (_tweenInterval);
		var i:Number = properties_array.length;
		
		while(--i>-1) _oTarget[properties_array[i].prop] =  properties_array[i].end;
		
	}
	
	public function start ():Void
	{
		
		clearInterval (_tweenInterval);
		_startTime = getTimer ();
		
		var i:Number = properties_array.length;
		
		while(--i>-1)_oTarget[properties_array[i].prop] =  properties_array[i].start;
		
		dispatchEvent ({type:"onInit", target:this});
		
		// Proxy fix scope problem when the object is set as local variable
		_tweenInterval = setInterval (Slider.create(this, update), 10);
		
	}
	private function update ():Void
	{
		
		
		if (getTimer () - _startTime >= _duration) {
			
			this.stop ();
			_oTarget[properties_array[i].prop]=nEnd;
			dispatchEvent ({type: "onComplete", target:this});
			
		} else {
			
			var nStart:Number;
			var nEnd:Number;
			var i:Number=properties_array.length+1
			
			while(--i>-1){
				
			    nStart =properties_array[i].start;
				nEnd = properties_array[i].end;
				
				
				_oTarget[properties_array[i].prop] =Math.round( _ease (getTimer () - _startTime, nStart, nEnd - nStart, _duration));
				
			}
			
			dispatchEvent ({type:"onProgress", target:this});
		}
		updateAfterEvent ();
	}
	
	public function deleteProperties(): Void
	{
		properties_array = new Array ();
	}
	
	// abort
	
	public function abort():Void
	{
		clearInterval (_tweenInterval);
	}
	
	// defaults to None
	private function easingDefault(t,b,c,d)
	{
		return c*t/d + b;
		
	}
}