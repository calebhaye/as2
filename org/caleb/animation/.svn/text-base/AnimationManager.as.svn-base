import org.caleb.core.CoreObject;
/*
 * AnimationManager.as
 *
 * Class based on prototypes created by Robert Penner (http://www.robertpenner.com), Ze Fernando (http://newsfeed.fatorcaos.com.br/wp/), and Nicholas Mitrousis (http://www.mybluemonkey.com)
 * @see CoreObject
 */

 

class org.caleb.animation.AnimationManager extends CoreObject
{
	
	private var clip;
	private var $tweenId:Number;
	/**
	 * AnimationManager Constructor
	 * @usage	org.caleb.animation.AnimationManager(objectReference);
	 * @param	objectReference (Object) object to be affected by AnimationManager
	 **/
	 
	public function AnimationManager (ref)
	{
		clip = ref;
		this.setClassDescription('org.caleb.animation.AnimationManager');
	};
	
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
	
	public function tween (prop, propDest, timeSeconds, animType, delay, callback, extra1, extra2):Number
	{
		this.$tweenId++;
		// Sets default values if undefined/invalid
		if (timeSeconds < 0.001) timeSeconds =.5;
		// default time length
		if (animType == undefined || animType == "") animType = "easeOutExpo";
		// default equation!
		if (delay == undefined) delay = 0;
		// default delay
		// Starts tweening.. prepares to create handling mcs
		var properties;
		var oldProperties;
		var newProperties;
		
		if (typeof (prop) == "string")
		{
			// Single property
			properties = [prop];
			// Properties, as in "_x"
			oldProperties = [clip [prop]];
			// Old value, as in 0
			newProperties = [propDest];
			// New (target) value, as in 100
			
		} else 
		{
			// Array of properties
			properties = [];
			// Properties, as in "_x"
			oldProperties = [];
			// Old value, as in 0
			newProperties = [];
			// New (target) value, as in 100
			for (var i in prop) oldProperties.push (clip [prop [i]]); 
			for (var i in prop) properties.push (prop [i]); 
			for (var i in propDest) newProperties.push (propDest [i]); 
		}
		var $_callback_assigned = false;
		// 1.7.4: Knows if callback has already been assigned to a movieclip
		// Checks if the master movieClip (which controls all tweens) exists
		if (_root.__tweenController__ == undefined)
		{
			// Doesn't exist: create, and set its methods/data
			var tweenHolder = _root.createEmptyMovieClip ("__tweenController__", 123432);
			// Any level
			tweenHolder.$_tweenPropList = new Array ();
			// Create reference to class
			tweenHolder.classRef = this;
			// Will hold the list of properties beeing tweened. an array of objects.
			tweenHolder.onEnterFrame = function ()
			{
				// On each pass, it should check and update the properties
				var tTime = getTimer ();
				for (var i = 0; i < this.$_tweenPropList.length; i ++)
				{
					var objProp = this.$_tweenPropList [i];
					// Temporary shortcut to this property controller object
					if (objProp._timeStart + (objProp._delay * 1000) <= tTime)
					{
						// Starts tweening already
						if (objProp._timeDest + (objProp._delay * 1000) <= tTime)
						{
							// Past the destiny time: ended.
							// Set it to its final value to make sure
							// there are no discrepancies
							objProp._targ [objProp._prop] = objProp._propDest;
							// Removes from the tweening properties list array. So simpler than the previous versions :)
							// (objProp still exists so it works further on)
							this.$_tweenPropList.splice (i, 1);

							i --;
							objProp._targ.$_tweenCount --;
							if (objProp._targ.$_tweenCount == 0) delete objProp._targ.$_tweenCount;
							if (objProp._callback != undefined)
							{
								
								// New method for 2.12.9: use the mc scope
								// So simpler. I should have done this from the start...
								// ...instead of trying the impossible (using the scope from which the tween was called)
								var e:org.caleb.event.Event = new org.caleb.event.Event(objProp._callback[1]);
								/*
								e.addArgument('clip', this.classRef.clip)
								e.addArgument('prop', prop)
								e.addArgument('propDest', propDest)
								e.addArgument('timeSeconds', timeSeconds)
								e.addArgument('animType', animType)
								e.addArgument('delay', delay)
								e.addArgument('callback', callback)
								e.addArgument('extra1', extra1)
								e.addArgument('extra2', extra2)
								*/
								if(org.caleb.util.ObjectUtil.isTypeOf(objProp._callback[1], 'String'))
								{
									objProp._callback[0][objProp._callback[1]].apply(objProp._callback[0], [e]);
								} 
								else 
								{
									objProp._callback.apply (objProp._targ, [e]);
								}
								
								
							}
							// Deletes the tweener movieclip if no tweens are left
							if (this.$_tweenPropList.length == 0) this.removeMovieClip ();
						} 
						else 
						{
							// Continue, simply set the correct property value.
							if (objProp._propStart == undefined) objProp._propStart = objProp._targ [objProp._prop];
							// "first-time" update to allow dinamically changed values for delays (2.14.9)
							objProp._targ [objProp._prop] = this.classRef.findTweenValue (objProp._propStart, objProp._propDest, objProp._timeStart, tTime - (objProp._delay * 1000) , objProp._timeDest, objProp._animType, objProp._extra1, objProp._extra2);
							if (typeof (objProp._targ) != "movieclip" && (objProp._prop == "__special_text_b__"))
							{
								// Special case: textfield, B value for textColor value. B being the last one to update, so also set the textfield's textColor
								objProp._targ.textColor = (objProp._targ.__special_text_r__ << 16) + (objProp._targ.__special_text_g__ << 8) + objProp._targ.__special_text_b__;
							}
						}
					}
				}
			};
		}
		var tweenPropList = _root.__tweenController__.$_tweenPropList;
		// Now set its data (adds to the list of properties being tweened)
		var tTime = getTimer ();
		// fix on 2.13.9 for a more uniform time (uses the exactly same time on different properties)
		for (var i in oldProperties)
		{
			// Set one new object for each property that should be tweened
			if (newProperties [i] != undefined && ! clip.$_isTweenLocked)
			{
				// Only creates tweenings for properties that are not undefined. That way,
				// certain properties can be optional on the shortcut functions even though
				// they are passed to the tweening function
				// Checks if it's at the tween list already
				if (clip.$_tweenCount > 0)
				{
					for (var pti = 0; pti < tweenPropList.length; pti ++)
					{
						if (tweenPropList [pti]._targ == clip && tweenPropList [pti]._prop == properties [i])
						{
							// Exists for the same property... checks if the time is the same (if the NEW's start time would be before the OLD's ending time)
							if (tTime + (delay * 1000) < tweenPropList [pti]._timeDest)
							{
								// It's a property that is already being tweened, BUT has already started, so it's ok to overwrite.
								// So it deletes the old one(s) and THEN creates the new one.
								tweenPropList.splice (pti, 1);
								pti --;
								clip.$_tweenCount --;
							}
						}
					}
				}
				// Finally, adds the new tween data to the list
				tweenPropList.push (
				{
					_prop : properties [i] ,
					_targ : clip,
					_propStart : undefined, // was "oldProperties[i]" (2.14.9). Doesn't set: it must be read at the first update time, to allow animating with correct [new] values when using the delay parameter
					_propDest : newProperties [i] ,
					_timeStart : tTime,
					_timeDest : tTime + (timeSeconds * 1000) ,
					_animType : animType,
					_extra1 : extra1,
					_extra2 : extra2,
					_delay : delay,
					_callback : $_callback_assigned ? undefined : callback
				});
				// $tweenCount is used for a faster start
				clip.$_tweenCount = clip.$_tweenCount > 0 ? clip.$_tweenCount + 1 : 1;	
				// to avoid setting ++ to undefined
				$_callback_assigned = true;
				// 1.7.4
				
			}
		}		
		
		return this.$tweenId;
	};
	
	/**
	* Prevents object from being tweened
	* @usage: org.caleb.animation.AnimationManager.lockTween()
	**/
	
	public function lockTween ()
	{
		clip.$_isTweenLocked = true;
		
	};
	
	
	/**
	* Allows object to be tweened
	**/
	
	public function unlockTween () {
		delete (clip.$_isTweenLocked);
	};
	
	/**
	* Returns the number of tweenings actually being executed
	* @return	Number
	**/
	
	public function getTweens (){
		return (clip.$_tweenCount);
	};
	
	/**
	* Returns true if there's at least one tweening being executed, otherwise false
	* @return	Boolean
	**/
	
	public function isTweening() {
		return (clip.$_tweenCount > 0 ? true : false);
	};
	
	/**
	* Removes tweenings immediately, leaving objects as-is. Examples:
	* @usage	org.caleb.animation.AnimationManager.stopTween ("_x"); // Stops _x tweening
	* @usage	org.caleb.animation.AnimationManager.stopTween (["_x", "_y"]);  // Stops _x and _y tweening
	* @usage	org.caleb.animation.AnimationManager.stopTween ();   // Stops all tweening processes
	**/
	
	public function stopTween (props) {
		
		var tweenPropList = _root.__tweenController__.$_tweenPropList;
		switch (typeof (props))
		{
			case "string" : // one property. example: "_alpha"
			props = [props];
			case "object" : // several properties. example: ["_alpha", "_rotation"]
			for (var i in props)
			{
				for (var pti in tweenPropList)
				{
					if (tweenPropList [pti]._targ == clip && tweenPropList [pti]._prop == props [i])
					{
						tweenPropList.splice (pti, 1);
					}
				}
			}
			// Updates the tween count "cache"
			clip.$_tweenCount = 0;
			for (var pti in tweenPropList)
			{
				if (tweenPropList [pti]._targ == clip) clip.$_tweenCount ++;
			}
			if (clip.$_tweenCount == 0) delete (clip.$_tweenCount);
			break;
			default : // empty. deletes/stops everything *for this movieclip*
			for (var pti in tweenPropList)
			{
				if (tweenPropList [pti]._targ == clip) tweenPropList.splice (pti, 1);
			}
			delete (clip.$_tweenCount);
		}
		if (tweenPropList.length == 0)
		{
			// No tweenings remain, remove it
			_root.__tweenController__.removeMovieClip ();
			clip.__tweenController_ADVhelper__.removeMovieClip ();
		}
	};
	
	/**
	* Does an alpha tween.
	* @usage	org.caleb.animation.AnimationManager.alphaTo(100, 3, "easeinoutquad");
	* @param	propDest_a (Number) final values for associated object properties
	* @param	timeSeconds (Number) seconds to reach the end values
	* @param 	animType (String) animation equation type
	* @param	delay (Number) number of seconds to delay before beginning tween
	* @param	callback (Array) object and method to call when tween has completed. [obj:Object, function:Function]
	* @param	extra1 (Number) optional animation parameter defining amplitude in animType='elastic' or overshoot amount in animType='back'
	* @param	extra2 (Number) optional animation parameter defining period in animType='elastic'
	**/
		
	public function alphaTo(propDest_a, timeSeconds, animType, delay, callback, extra1, extra2)
	{
		
		tween ("_alpha", propDest_a, timeSeconds, animType, delay, callback, extra1, extra2);
	};
	
	/**
	* Rotates an object given a degree. 
	* @usage	org.caleb.animation.AnimationManager.movieclip>.rotateTo(180)
	* @param	propDest_rotation (Number) final values for associated object properties
	* @param	timeSeconds (Number) seconds to reach the end values
	* @param 	animType (String) animation equation type
	* @param	delay (Number) number of seconds to delay before beginning tween
	* @param	callback (Array) object and method to call when tween has completed. [obj:Object, function:Function]
	* @param	extra1 (Number) optional animation parameter defining amplitude in animType='elastic' or overshoot amount in animType='back'
	* @param	extra2 (Number) optional animation parameter defining period in animType='elastic'
	**/
	
	public function rotateTo (propDest_rotation, timeSeconds, animType, delay, callback, extra1, extra2) {
		tween ("_rotation", propDest_rotation, timeSeconds, animType, delay, callback, extra1, extra2);
	};
	
	/**
	* Scales an object uniformly.
	* @usage	org.caleb.animation.AnimationManager.scaleTo(200)
	**/
	
	public function scaleTo (propDest_scale, timeSeconds, animType, delay, callback, extra1, extra2) {
		tween (["_xscale", "_yscale"] , [propDest_scale, propDest_scale] , timeSeconds, animType, delay, callback, extra1, extra2);
	};
	
	/**
	* Tweens the scroll property of a textfield to allow an easing scroll to a line
	* @param	propDest_scroll (Number) final values for associated object properties
	* @param	timeSeconds (Number) seconds to reach the end values
	* @param 	animType (String) animation equation type
	* @param	delay (Number) number of seconds to delay before beginning tween
	* @param	callback (Array) object and method to call when tween has completed. [obj:Object, function:Function]
	* @param	extra1 (Number) optional animation parameter defining amplitude in animType='elastic' or overshoot amount in animType='back'
	* @param	extra2 (Number) optional animation parameter defining period in animType='elastic'
	**/
	public function scrollTo (propDest_scroll, timeSeconds, animType, delay, callback, extra1, extra2){ 
		tween ("scroll", propDest_scroll, timeSeconds, animType, delay, callback, extra1, extra2);
	};
	
	/**
	* Does a xy sliding tween. 
	* @usage	org.caleb.animation.AnimationManager.slideTo(100, 100)
	* @param	propDest_x (Number) final x value for associated object
	* @param	propDest_y (Number) final y value for assocated object
	* @param	timeSeconds (Number) seconds to reach the end values
	* @param 	animType (String) animation equation type
	* @param	delay (Number) number of seconds to delay before beginning tween
	* @param	callback (Array) object and method to call when tween has completed. [obj:Object, function:Function]
	* @param	extra1 (Number) optional animation parameter defining amplitude in animType='elastic' or overshoot amount in animType='back'
	* @param	extra2 (Number) optional animation parameter defining period in animType='elastic'
	**/
	
	public function slideTo (propDest_x, propDest_y, timeSeconds, animType, delay, callback, extra1, extra2){
		tween (["_x", "_y"] , [propDest_x, propDest_y] , timeSeconds, animType, delay, callback, extra1, extra2);
	};
	
	/**
	* Does a simple color transformation (tint) tweening. Works like Flash MX's color.setRGB method.
	* @usage	org.caleb.animation.AnimationManager.colorTo(0xFF6CD9);
	* @param	propDest_color (Number) final color (in a hexidecimal format)
	* @param	timeSeconds (Number) seconds to reach the end values
	* @param 	animType (String) animation equation type
	* @param	delay (Number) number of seconds to delay before beginning tween
	* @param	callback (Array) object and method to call when tween has completed. [obj:Object, function:Function]
	* @param	extra1 (Number) optional animation parameter defining amplitude in animType='elastic' or overshoot amount in animType='back'
	* @param	extra2 (Number) optional animation parameter defining period in animType='elastic'
	**/
	
	public function colorTo (propDest_color, timeSeconds, animType, delay, callback, extra1, extra2)
	{
		var new_r = propDest_color >> 16;
		var new_g = (propDest_color & 0x00FF00) >> 8;
		var new_b = propDest_color & 0x0000FF;
		this.colorTransformTo (0, new_r, 0, new_g, 0, new_b, undefined, undefined, timeSeconds, animType, delay, callback, extra1, extra2);
		
	};
	
	/**
	* Does a color transformation tweening, based on Flash's "advanced" color transformation settings. Works like Flash MX's color.setTransform method, although it uses properties directly as parameters and not a color object
	* @usage	org.caleb.AnimationManager.colorTo(200, 0, 200, 0, 200, 0, undefined, undefined, 2)
	* @param	propDest_ra Number red alpha, % of the original object's color to remain on the new object
	* @param	propDest_rb Number red offset, how much to add to the red color
	* @param	propDest_ga Number green alpha, % of the original object's color to remain on the new object
	* @param	propDest_gb Number green offset, how much to add to the red color
	* @param	propDest_ba Number blue alpha, % of the original object's color to remain on the new object
	* @param	propDest_bb Number blue offset, how much to add to the red color
	* @param	propDest_aa Number alpha alpha, % of the original object's color to remain on the new object
	* @param	propDest_ab Number alpha offset, how much to add to the red color
	* @param	timeSeconds (Number) seconds to reach the end values
	* @param 	animType (String) animation equation type
	* @param	delay (Number) number of seconds to delay before beginning tween
	* @param	callback (Array) object and method to call when tween has completed. [obj:Object, function:Function]
	* @param	extra1 (Number) optional animation parameter defining amplitude in animType='elastic' or overshoot amount in animType='back'
	* @param	extra2 (Number) optional animation parameter defining period in animType='elasstic'
	**/
	
	
	public function colorTransformTo (propDest_ra, propDest_rb, propDest_ga, propDest_gb, propDest_ba, propDest_bb, propDest_aa, propDest_ab, timeSeconds, animType, delay, callback, extra1, extra2)
	{
		// 
		// 
		//  Example: 
		// ra = 
		// rb = 
		// ga, gb = same for green
		// ba, bb = same for blue
		// aa, ab = same for alpha
		var $_clrTmp = new Color (clip);
		var $_clrNow = $_clrTmp.getTransform ();
		clip.$_ADVsetter_ra = propDest_ra == undefined ? undefined : $_clrNow.ra;
		// 1.12.9: don't create if undefined (not tweening)
		clip.$_ADVsetter_rb = propDest_rb == undefined ? undefined : $_clrNow.rb;
		clip.$_ADVsetter_ga = propDest_ga == undefined ? undefined : $_clrNow.ga;
		clip.$_ADVsetter_gb = propDest_gb == undefined ? undefined : $_clrNow.gb;
		clip.$_ADVsetter_ba = propDest_ba == undefined ? undefined : $_clrNow.ba;
		clip.$_ADVsetter_bb = propDest_bb == undefined ? undefined : $_clrNow.bb;
		clip.$_ADVsetter_aa = propDest_aa == undefined ? undefined : $_clrNow.aa;
		clip.$_ADVsetter_ab = propDest_ab == undefined ? undefined : $_clrNow.ab;
		clip.$_new_ra = propDest_ra;
		clip.$_new_rb = propDest_rb;
		clip.$_new_ga = propDest_ga;
		clip.$_new_gb = propDest_gb;
		clip.$_new_ba = propDest_ba;
		clip.$_new_bb = propDest_bb;
		clip.$_new_aa = propDest_aa;
		clip.$_new_ab = propDest_ab;
		tween (["$_ADVsetter_ra", "$_ADVsetter_rb", "$_ADVsetter_ga", "$_ADVsetter_gb", "$_ADVsetter_ba", "$_ADVsetter_bb", "$_ADVsetter_aa", "$_ADVsetter_ab"] , [clip.$_new_ra, clip.$_new_rb, clip.$_new_ga, clip.$_new_gb, clip.$_new_ba, clip.$_new_bb, clip.$_new_aa, clip.$_new_ab] , timeSeconds, animType, delay, callback, extra1, extra2);
		clip.__tweenController_ADVhelper__.removeMovieClip ();
		clip.createEmptyMovieClip ("__tweenController_ADVhelper__", 123434);
		clip.__tweenController_ADVhelper__.onEnterFrame = function ()
		{
			var tweenColor = new Color (this._parent);
			// 1.12.9: only adds existing properties :: START
			var ADVToSet = {
			}
			if (this._parent.$_ADVsetter_ra != undefined) ADVToSet.ra = this._parent.$_ADVsetter_ra;
			if (this._parent.$_ADVsetter_rb != undefined) ADVToSet.rb = this._parent.$_ADVsetter_rb;
			if (this._parent.$_ADVsetter_ga != undefined) ADVToSet.ga = this._parent.$_ADVsetter_ga;
			if (this._parent.$_ADVsetter_gb != undefined) ADVToSet.gb = this._parent.$_ADVsetter_gb;
			if (this._parent.$_ADVsetter_ba != undefined) ADVToSet.ba = this._parent.$_ADVsetter_ba;
			if (this._parent.$_ADVsetter_bb != undefined) ADVToSet.bb = this._parent.$_ADVsetter_bb;
			if (this._parent.$_ADVsetter_aa != undefined) ADVToSet.aa = this._parent.$_ADVsetter_aa;
			if (this._parent.$_ADVsetter_ab != undefined) ADVToSet.ab = this._parent.$_ADVsetter_ab;
			// 1.12.9: only adds existing properties :: END
			tweenColor.setTransform (ADVToSet);
			if (this.$_toDelete)
			{
				// These _parent variables were used temporarily as proxy variables
				// So they should be deleted too
				delete this._parent.$_ADVsetter_ra;
				delete this._parent.$_ADVsetter_rb;
				delete this._parent.$_ADVsetter_ga;
				delete this._parent.$_ADVsetter_gb;
				delete this._parent.$_ADVsetter_ba;
				delete this._parent.$_ADVsetter_bb;
				delete this._parent.$_ADVsetter_aa;
				delete this._parent.$_ADVsetter_ab;
				delete this._parent.$_new_ra;
				delete this._parent.$_new_rb;
				delete this._parent.$_new_ga;
				delete this._parent.$_new_gb;
				delete this._parent.$_new_ba;
				delete this._parent.$_new_bb;
				delete this._parent.$_new_aa;
				delete this._parent.$_new_ab;
				this.removeMovieClip ();
			}
			if ((this._parent.$_ADVsetter_ra == this._parent.$_new_ra || this._parent.$_new_ra == undefined) && (this._parent.$_ADVsetter_rb == this._parent.$_new_rb || this._parent.$_new_rb == undefined) && (this._parent.$_ADVsetter_ga == this._parent.$_new_ga || this._parent.$_new_ga == undefined) && (this._parent.$_ADVsetter_gb == this._parent.$_new_gb || this._parent.$_new_gb == undefined) && (this._parent.$_ADVsetter_ba == this._parent.$_new_ba || this._parent.$_new_ba == undefined) && (this._parent.$_ADVsetter_bb == this._parent.$_new_bb || this._parent.$_new_bb == undefined) && (this._parent.$_ADVsetter_aa == this._parent.$_new_aa || this._parent.$_new_aa == undefined) && (this._parent.$_ADVsetter_ab == this._parent.$_new_ab || this._parent.$_new_ab == undefined))
			{
				// Has finished moving, so set this proxy movieclips to be deleted
				// It will only be deleted in the next frame to avoid removing new animations movie clips
				this.$_toDelete = true;
			}
		};
	};
	
	/**
	* 
	===============================================================================
	= _global.findTweenValue()
	=
	= FUNCTION (internal). Returns the current value of a property mid-value given the time.
	= Used by the tween methods to see where the movieclip should be on the current
	= tweening process. All equations on this function are Robert Penner's work.
	
	=
	= How to use:
	=      <var> = findTweenValue(pStart, pEnd, tStart, tNow, tEnd, animType, extra1, extra2)
	=
	= Parameters:
	=      pStart   = initial property value (number)
	=      pEnd     = end property value (number)
	=      tStart   = starting time (seconds, miliseconds, or frames)
	=      tNow     = time now (seconds, miliseconds, or frames)
	=      tEnd     = ending time (seconds, miliseconds, or frames)
	=      animType = animation type (string)
	=      extra1   = optional animation parameter.
	=                 means AMPLITUDE (a) when animType = *elastic
	=                 means OVERSHOOT AMMOUNT (s) when animType = *back
	=      extra2   = optional animation parameter.
	=                 means PERIOD (p) when animType = *elastic
	=
	= Examples:
	=      x = findTweenValue (0, 100, 0, 555, 1000, "linear");
	=      stuff = findTweenValue (0, 100, ti, getTimer(), ti+1000, "easeinout");
	=
	===============================================================================
	**/
	private function findTweenValue (_propStart, _propDest, _timeStart, _timeNow, _timeDest, _animType, _extra1, _extra2):Number {
		var t = _timeNow - _timeStart;
		// current time (frames, seconds)
		var b = _propStart;
		// beginning value
		var c = _propDest - _propStart;
		// change in value
		var d = _timeDest - _timeStart;
		// duration (frames, seconds)
		var a = _extra1;
		// amplitude (optional - used only on *elastic easing)
		var p = _extra2;
		// period (optional - used only on *elastic easing)
		var s = _extra1;
		// overshoot ammount (optional - used only on *back easing)
		switch (_animType.toLowerCase ())
		{
			case "linear" :
			// simple linear tweening - no easing
			return c * t / d + b;
			case "easeinquad" :
			// quadratic (t^2) easing in - accelerating from zero velocity
			return c * (t /= d) * t + b;
			case "easeoutquad" :
			// quadratic (t^2) easing out - decelerating to zero velocity
			return - c * (t /= d) * (t - 2) + b;
			case "easeinoutquad" :
			// quadratic (t^2) easing in/out - acceleration until halfway, then deceleration
			if ((t /= d / 2) < 1) return c / 2 * t * t + b;
			return - c / 2 * (( -- t) * (t - 2) - 1) + b;
			case "easeincubic" :
			// cubic (t^3) easing in - accelerating from zero velocity
			return c * (t /= d) * t * t + b;
			case "easeoutcubic" :
			// cubic (t^3) easing out - decelerating to zero velocity
			return c * ((t = t / d - 1) * t * t + 1) + b;
			case "easeinoutcubic" :
			// cubic (t^3) easing in/out - acceleration until halfway, then deceleration
			if ((t /= d / 2) < 1) return c / 2 * t * t * t + b;
			return c / 2 * ((t -= 2) * t * t + 2) + b;
			case "easeinquart" :
			// quartic (t^4) easing in - accelerating from zero velocity
			return c * (t /= d) * t * t * t + b;
			case "easeoutquart" :
			// quartic (t^4) easing out - decelerating to zero velocity
			return - c * ((t = t / d - 1) * t * t * t - 1) + b;
			case "easeinoutquart" :
			// quartic (t^4) easing in/out - acceleration until halfway, then deceleration
			if ((t /= d / 2) < 1) return c / 2 * t * t * t * t + b;
			return - c / 2 * ((t -= 2) * t * t * t - 2) + b;
			case "easeinquint" :
			// quintic (t^5) easing in - accelerating from zero velocity
			return c * (t /= d) * t * t * t * t + b;
			case "easeoutquint" :
			// quintic (t^5) easing out - decelerating to zero velocity
			return c * ((t = t / d - 1) * t * t * t * t + 1) + b;
			case "easeinoutquint" :
			// quintic (t^5) easing in/out - acceleration until halfway, then deceleration
			if ((t /= d / 2) < 1) return c / 2 * t * t * t * t * t + b;
			return c / 2 * ((t -= 2) * t * t * t * t + 2) + b;
			case "easeinsine" :
			// sinusoidal (sin(t)) easing in - accelerating from zero velocity
			return - c * Math.cos (t / d * (Math.PI / 2)) + c + b;
			case "easeoutsine" :
			// sinusoidal (sin(t)) easing out - decelerating to zero velocity
			return c * Math.sin (t / d * (Math.PI / 2)) + b;
			case "easeinoutsine" :
			// sinusoidal (sin(t)) easing in/out - acceleration until halfway, then deceleration
			return - c / 2 * (Math.cos (Math.PI * t / d) - 1) + b;
			case "easeinexpo" :
			// exponential (2^t) easing in - accelerating from zero velocity
			return (t == 0) ? b : c * Math.pow (2, 10 * (t / d - 1)) + b;
			case "easeoutexpo" :
			// exponential (2^t) easing out - decelerating to zero velocity
			return (t == d) ? b + c : c * ( - Math.pow (2, - 10 * t / d) + 1) + b;
			case "easeinoutexpo" :
			// exponential (2^t) easing in/out - acceleration until halfway, then deceleration
			if (t == 0) return b;
			if (t == d) return b + c;
			if ((t /= d / 2) < 1) return c / 2 * Math.pow (2, 10 * (t - 1)) + b;
			return c / 2 * ( - Math.pow (2, - 10 * -- t) + 2) + b;
			case "easeincirc" :
			// circular (sqrt(1-t^2)) easing in - accelerating from zero velocity
			return - c * (Math.sqrt (1 - (t /= d) * t) - 1) + b;
			case "easeoutcirc" :
			// circular (sqrt(1-t^2)) easing out - decelerating to zero velocity
			return c * Math.sqrt (1 - (t = t / d - 1) * t) + b;
			case "easeinoutcirc" :
			// circular (sqrt(1-t^2)) easing in/out - acceleration until halfway, then deceleration
			if ((t /= d / 2) < 1) return - c / 2 * (Math.sqrt (1 - t * t) - 1) + b;
			return c / 2 * (Math.sqrt (1 - (t -= 2) * t) + 1) + b;
			case "easeinelastic" :
			//
			if (a == undefined) a = 0;
			// elastic (exponentially decaying sine wave)
			if (t == 0) return b;
			if ((t /= d) == 1) return b + c;
			if ( ! p) p = d *.3;
			if (a < Math.abs (c))
			{
				a = c;
				s = p / 4;
				
			} 
			else s = p / (2 * Math.PI) * Math.asin (c / a);
			return - (a * Math.pow (2, 10 * (t -= 1)) * Math.sin ((t * d - s) * (2 * Math.PI) / p )) + b;
			case "easeoutelastic" :
			//
			if (a == undefined) a = 0;
			// elastic (exponentially decaying sine wave)
			if (t == 0) return b;
			if ((t /= d) == 1) return b + c;
			if ( ! p) p = d *.3;
			if (a < Math.abs (c))
			{
				a = c;
				s = p / 4;
				
			} 
			else s = p / (2 * Math.PI) * Math.asin (c / a);
			return a * Math.pow (2, - 10 * t) * Math.sin ((t * d - s) * (2 * Math.PI) / p ) + c + b;
			case "easeinoutelastic" :
			//
			if (a == undefined) a = 0;
			// elastic (exponentially decaying sine wave)
			if (t == 0) return b;
			if ((t /= d / 2) == 2) return b + c;
			if ( ! p) p = d * (.3 * 1.5);
			if (a < Math.abs (c))
			{
				a = c;
				s = p / 4;
				
			} 
			else s = p / (2 * Math.PI) * Math.asin (c / a);
			if (t < 1) return -.5 * (a * Math.pow (2, 10 * (t -= 1)) * Math.sin ((t * d - s) * (2 * Math.PI) / p )) + b;
			return a * Math.pow (2, - 10 * (t -= 1)) * Math.sin ((t * d - s) * (2 * Math.PI) / p ) *.5 + c + b;
			// Robert Penner's explanation for the s parameter (overshoot ammount):
			//  s controls the amount of overshoot: higher s means greater overshoot
			//  s has a default value of 1.70158, which produces an overshoot of 10 percent
			//  s==0 produces cubic easing with no overshoot
			case "easeinback" :
			// back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing in - backtracking slightly, then reversing direction and moving to target
			if (s == undefined) s = 1.70158;
			return c * (t /= d) * t * ((s + 1) * t - s) + b;
			case "easeoutback" :
			// back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing out - moving towards target, overshooting it slightly, then reversing and coming back to target
			if (s == undefined) s = 1.70158;
			return c * ((t = t / d - 1) * t * ((s + 1) * t + s) + 1) + b;
			case "easeinoutback" :
			// back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing in/out - backtracking slightly, then reversing direction and moving to target, then overshooting target, reversing, and finally coming back to target
			if (s == undefined) s = 1.70158;
			if ((t /= d / 2) < 1) return c / 2 * (t * t * (((s *= (1.525)) + 1) * t - s)) + b;
			return c / 2 * ((t -= 2) * t * (((s *= (1.525)) + 1) * t + s) + 2) + b;
			// This were changed a bit by me (since I'm not using Penner's own Math.* functions)
			// So I changed it to call findTweenValue() instead (with some different arguments)
			case "easeinbounce" :
			// bounce (exponentially decaying parabolic bounce) easing in
			return c - findTweenValue (0, c, 0, d - t, d, "easeOutBounce") + b;
			case "easeoutbounce" :
			// bounce (exponentially decaying parabolic bounce) easing out
			if ((t /= d) < (1 / 2.75))
			{
				return c * (7.5625 * t * t) + b;
			} else if (t < (2 / 2.75))
			{
				return c * (7.5625 * (t -= (1.5 / 2.75)) * t +.75) + b;
			} else if (t < (2.5 / 2.75))
			{
				return c * (7.5625 * (t -= (2.25 / 2.75)) * t +.9375) + b;
			} else 
			{
				return c * (7.5625 * (t -= (2.625 / 2.75)) * t +.984375) + b;
			}
			case "easeinoutbounce" :
			// bounce (exponentially decaying parabolic bounce) easing in/out
			if (t < d / 2) return findTweenValue (0, c, 0, t * 2, d, "easeInBounce") *.5 + b;
			return findTweenValue (0, c, 0, t * 2 - d, d, "easeOutBounce") *.5 + c *.5 + b;
		}
	};
	
}
