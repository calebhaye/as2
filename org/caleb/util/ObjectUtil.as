import org.caleb.core.CoreObject;

class org.caleb.util.ObjectUtil extends CoreObject
{	
	public static function insertAt(arg:Array, data, index:Number):Array 
	{
		var oldArray:Array = new Array();
		oldArray = oldArray.concat(arg);
		var count:Number = 0;
		for (var i:Number=0; i<oldArray.length; i++) 
		{
			if (i == index) {
			arg[count] = data;
			count++;
		}
		arg[count] = oldArray[i];
		count++;
		}
		return arg;
	}
	/**
	 * Check whether the object can be seen.
	 * Loop thru the object, testing for member. if the member does not exist,
	 * this method will return false. if the member is hidden (via ASSetPropFlags),
	 * this method will return false.
	 * 
	 * @usage   ObjectUtil.isEnumerable(myObj, myMemberCandidate);
	 * @param   obj    (Object)
	 * @param   member (Object)
	 * @return  Boolean
	 */
	public static function isEnumerable(obj:Object, member:Object):Boolean{
		var i:String;
		for(i in obj){
			if(obj[i] == member){
				return true;	
			}
		}
		return false;
	}

	/**
	 * Modded from FlashCoders, this function will try to delete the object, 
	 * then restore it. It will report the success of the delete operation.
	 * 
	 * The delete operator may fail and return false if the reference parameter does not exist, 
	 * or may not be deleted. Predefined objects and properties, and variables declared with var , 
	 * may not be deleted. You cannot use the delete operator to remove movie clips.
	 * 
 	 * @usage   var canDestroy:Boolean = ObjectUtil.isDeletable(myObj);
	 * @param   obj (Object) candidate object
	 */
	public static function isDeletable(obj:Object):Boolean{
		var snapShot:Object = obj;
		var success:Boolean = false;
		delete(obj);
		if(isUndefined(obj)){
			success = true;
			obj = snapShot;
		}
		return success;
	}

	/**
	 * If this object is empty, return true. Otherwise, false.
	 * 
	 * @param   obj 
	 */
	public static function isEmpty(obj:Object):Boolean{
		return isUndefined(obj);
	}

	/**
	 * Return the typeof the object.
	 * 
	 * @param   obj 
	 */
	public static function getTypeOf(obj:Object):String{
		return typeof obj;
	}

	/**
	 * Return true if the object is typeof type.
	 * 
	 * @param   obj  
	 * @param   type 
	 */
	public static function isTypeOf(obj:Object, type:String):Boolean{
		return (getTypeOf(obj).toLowerCase() == type.toLowerCase());
	}

	/**
	 * Return true if the object is a primitive type.
	 * 
	 * @param   obj 
	 */
	public static function isFlashPrimitive(obj:Object):Boolean{
		return (isTypeOf(obj, "number") || isTypeOf(obj, "boolean") || isTypeOf(obj, "string"));
	}

	/**
	 * If obj is an instance of classPtr or an instance of a classPtr subclass, return true.
	 * 
	 * @param   obj      
	 * @param   classPtr 
	 */
	public static function isInstanceOf(obj:Object, classPtr:Function):Boolean{
		//	if the two args are exactly the same:
		if(obj === classPtr) return true;
		return (obj instanceof classPtr);
	}

	/**
	 * Make sure obj is not a subclass of classPtr, but a direct instance of it
	 * 
	 * @param   obj      
	 * @param   classPtr 
	 */
	public static function isExplicitInstanceOf(obj:Object, classPtr:Function):Boolean{
		if(isInstanceOf(obj, classPtr)){
			if(isInstanceOf(obj.__proto__, classPtr) == false){
				return true;
			}
		}
		return false;
	}

	/**
	 * Return true if obj is defined, false otherwise
	 * 
	 * @param   obj 
	 */
	public static function isSet(obj:Object):Boolean{
		return (obj != undefined && !isNull(obj));
	}

	/**
	 * Return true if objects are equal
	 * 
	 * @param   a 
	 * @param   b 
	 */
	public static function isEqual(a:Object, b:Object):Boolean{
		return (a == b);
	}


	/**
	 * Return true if obj is undefined, false otherwise
	 * 
	 * @param   obj 
	 */
	public static function isUndefined(obj:Object):Boolean{
		return (obj == undefined);
	}

	/**
	 * Return true if obj is null, false otherwise
	 * 
	 * @param   obj 
	 */
	public static function isNull(obj:Object):Boolean{
		return (obj == null);
	}


	/**
	 * Return true if obj is a Function, false otherwise
	 * 
	 * @param   obj (Object)
	 */
	public static function isFunction(obj:Object):Boolean{
		return (isTypeOf(obj, 'function'));
	}

	/**
	 * invoke a method on an object
	 * optional 3rd argument should contain an array whose elements are passed to the target function as parameters
	 * 
	 * @param   obj        (Object)
	 * @param   methodName (String)
	 */
	public static function callMethod(obj:Object, methodName:String):Void
	{
		if(arguments[2] != undefined)
		{
			var args = arguments[2];
			obj[methodName].apply(obj, [args]);
		}
		else
		{
			obj[methodName].apply(obj, []);
		}
	}
	/**
	 * 
	 * @usage   ObjectUtil.setTimeout(myObj, 'timeoutHandler', 7, new Array('stringParam', refParam)); 
	 * @param   obj (Object)        
	 * @param   methodName (String)
	 * @param   seconds    (Number)
	 * @param   args       (Array)
	 */
	public static function setTimeout(obj:Object, methodName:String, seconds:Number, args:Array):Void
	{
		var timer:org.caleb.timer.Timer = new org.caleb.timer.Timer;
		timer.setTimeout(obj, methodName, seconds, args);
	}
	/**
	 * 
	 * @usage   var myXML:XML = ObjectUtil.toXML(myObj);
	 * @param   obj          (Object)
	 * @param   rootNodeName (String)
	 * @return  XML
	 */
	public static function toXML(obj:Object, rootNodeName:String):XML
	{
		return org.caleb.xml.XMLObject(new org.caleb.xml.XMLObject()).parseObject(obj, rootNodeName);
	}
}