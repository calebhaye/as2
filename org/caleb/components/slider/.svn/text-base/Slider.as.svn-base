import org.caleb.components.slider.SliderTween;
import mx.events.EventDispatcher;

class org.caleb.components.slider.Slider
{
	private var _knobMC:MovieClip;
	private var _baseMC:MovieClip;
	
	private var _orientation:String;
	private var _prop1:String;
	private var _prop2:String;
	
	private var _left:Number;
	private var _right:Number;
	private var _top:Number;
	private var _bottom:Number;
	
	private var pointX:Number;
	private var pointY:Number;
	
	private var mouseListener:Object;
	
	private var _initValue:Number;
	private var _endValue:Number;
	private var _range:Number;
	
	private var _value:Number;
	private var _tw:SliderTween;
	
	//private static var overColor:Number=0xFFFFFF;
	//private static var outColor:Number=0xFF004C;
	
	// required for EventDispatcher:
	private var dispatchEvent:Function;
	public var addEventListener:Function;
	public var removeEventListener:Function;
	
	function Slider ()
	{
		EventDispatcher.initialize (this);
	}
	
	public function init (knob:MovieClip, base:MovieClip, orientation:String, initValue:Number, endValue:Number):Void
	{
		_knobMC = knob;
		_baseMC = base;
		
		_knobMC._x=_baseMC._x;
		_knobMC._y=_baseMC._y;
		
		_orientation = orientation;
		
		if(_orientation == 'horizontal'){
			_prop1='_x';
			_prop2='_width';
		}else{
			_prop1='_y';
			_prop2='_height'
		}
		
		_initValue = initValue;
		_endValue = endValue;
		_range = (_endValue - _initValue);
		
		_knobMC.onPress = Slider.create (this, startDrag);
		_knobMC.onRelease = _knobMC.onReleaseOutside = Slider.create (this, stopDrag);
		
		_baseMC.onPress = Slider.create (this, findValue);
		
		_knobMC.useHandCursor = _baseMC.useHandCursor = false;
		
		_tw=new SliderTween(_knobMC);
		
		redrawLimits ();
	}
	
	private function startDrag ():Void
	{
		//colorize (_knobMC, overColor);
		_tw.abort();
		
		pointX = _knobMC._x - _xmouse;
		pointY = _knobMC._y - _ymouse;

		mouseListener = new Object ();
		mouseListener.onMouseMove = Slider.create (this, updatePos);
		Mouse.addListener (mouseListener);
		dispatchEvent ({target:this, type:'onStartDrag'});
	}
	
	private function stopDrag ():Void
	{
		Mouse.removeListener (mouseListener);
		//colorize (_knobMC, outColor);
		dispatchEvent ({target:this, type:'onStopDrag'});
	}
	private function updatePos ():Void
	{
		var pos:Number = getCurrentValue (_knobMC[_prop1]);
		if (pos >= _initValue && pos <= _endValue) {
			
			_knobMC._x =  (_xmouse + pointX);
			_knobMC._y =  (_ymouse + pointY);
			
		}
		
		checkLimits ();
		updateAfterEvent ();
	}
	
	private function checkLimits ():Void
	{
		if (_knobMC._x < _left) _knobMC._x = _left;
		if (_knobMC._x > _right) _knobMC._x = _right;
		if (_knobMC._y < _top)_knobMC._y = _top;
		if (_knobMC._y > _bottom) _knobMC._y = _bottom;
		
		updateValue();

	}
	public function redrawLimits ():Void
	{
		_left = _baseMC._x;
		_top = _baseMC._y;
		_right = ((_baseMC._x + _baseMC._width) - (_knobMC._width));
		_bottom = ((_baseMC._y + _baseMC._height) - (_knobMC._height));
		
		checkLimits ();
	}
	public function getTarget ():MovieClip
	{
		return _knobMC;
	}
	
	public function getCurrentValue (ref:Number):Number
	{
		return ( ((ref - _baseMC[_prop1]) / (_baseMC[_prop2] - _knobMC[_prop2]) * _range + _initValue));
	}
	
	public function jumpTo (val:Number):Void
	{
		_knobMC[_prop1] = translateValToPos(val)
		checkLimits ();
	}
	
	private function translateValToPos():Number
	{
		var tempValue:Number;
		
		if(arguments.length){
			tempValue=arguments[0];
		}else{
			tempValue=(_orientation == 'horizontal')? getCurrentValue(_xmouse-(_knobMC[_prop2]/2)):getCurrentValue(_ymouse-(_knobMC[_prop2]/2));
		}
		return ( (_baseMC[_prop1] + (((_baseMC[_prop2] - _knobMC[_prop2]) * (tempValue - _initValue)) / (_range))));
	}
	
	private function findValue():Void
	{
		_tw.abort();
		_tw.deleteProperties();
		_tw.duration=250;
		_tw.setSliderTweenProperty (_prop1, _knobMC[_prop1], translateValToPos());
		_tw.addEventListener('onProgress',Slider.create(this,checkLimits));
		_tw.addEventListener('onComplete',Slider.create(this,checkLimits));
		_tw.easingFunction=mx.transitions.easing.Regular.easeIn
		_tw.start();

	}
	
	private function updateValue():Void{

		dispatchEvent ({target:this, type:'onChange', value:Math.round(getCurrentValue (_knobMC[_prop1]))});
	}
	
	private function enableItems(enable:Boolean):Void
	{
		_knobMC.enabled=_baseMC.enabled=enable;
	}
	
	private function colorize (mc:MovieClip, col:Number):Void
	{
		var c:Color = new Color (mc);
		c.setRGB (col);
	}
	public static function create (me:Object, oustsideFunc:Function):Function
	{
		var tempParam:Array = arguments.slice (2);
		var passObject:Boolean = arguments[arguments.length-1].passObject;
		passObject = (passObject != undefined) ? passObject : true;
		
		var tempProxy:Function = function ()
		{
			(!passObject) ? oustsideFunc.apply (null, tempParam) : oustsideFunc.apply (me, arguments.concat (tempParam));
		};
		return tempProxy;
	}
}
