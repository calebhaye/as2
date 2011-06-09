import org.caleb.event.EventObserver;

class org.caleb.decorator.Observer
{
	static var yahooED:Observer;
	//	should be a Vector
	private var yahoo_Observer_listeners:Object;

	//	Initialization method. Called by an instance of a class
	//	conforming to the Observable interface
	/**
	 * 
	 * @param   obj 
	 */
	static function makeObservable(obj:Object):Void
	{
		//  if the object is already observable, return
		if(obj instanceof org.caleb.event.Observable)
		{
			return;
		}
		//	if this is the first time this method is called, instantiate
		//	the yahooED object so that we have a way to clone over
		//	our methods to the obj passed in for initialization
		if (yahooED == undefined){
			yahooED = new Observer;
		}

		//	If the listeners object hasn't yet been created, do so now.
		if(typeof obj.yahoo_Observer_listeners == "undefined"){
			obj.yahoo_Observer_listeners = new Object();
			_global.ASSetPropFlags(obj, obj.yahoo_Observer_listeners, 1);
		}

		obj.addEventObserver = yahooED.addEventObserver;
		obj.removeEventObserver = yahooED.removeEventObserver;
		obj.removeAllEventObservers = yahooED.removeAllEventObservers;
		obj.dispatchEvent = yahooED.dispatchEvent;
		obj.hasObserver = yahooED.hasObserver;
	}

	private function addEventObserver():Void
	{
		//	check to see if the listeners object has a list of 
		//	listeners for the event id eID. If not, create one.
		var lObj = arguments.shift();
		var eID:String;

		var len:Number = arguments.length;
		var count:Number = 0;

		while(count<len){
			eID = arguments[count];
			if(typeof yahoo_Observer_listeners[eID] != "object"){
				yahoo_Observer_listeners[eID] = new Array();
			}
			if(!hasObserver(yahoo_Observer_listeners[eID], lObj)){
				yahoo_Observer_listeners[eID].push(new org.caleb.event.EventObserver(lObj, eID));
			}
			count++;
		}

	}

	private function removeEventObserver(lObj:Object, eID:String):Void{
		//trace('#removeEventObserver');
		var list:Array = yahoo_Observer_listeners[eID];
		var len:Number = list.length;
		if(len < 1) return;
		while(len--){
			if(list[len].getObject() == lObj){
				list.splice(len, 1);
				return;
			}
		}
	}

	private function removeAllEventObservers(eID:String):Void
	{
		if(typeof eID == "string"){
			delete(yahoo_Observer_listeners[eID]);
		}else{
			delete(yahoo_Observer_listeners);
		}
	}

	private function dispatchEvent(e:org.caleb.event.Event)
	{
		// trace('dispatchEvent invoked')
		var eID:String = e.getType();
		e.setSender(this);
		var list:Array = yahoo_Observer_listeners[eID];
		var len:Number = list.length;
		if(len < 1) return;
		var i:String;
		var t:String;
		var l:Object;
		for(i in list)
		{
			list[i].callMethod(e.getType(), e);
		}
	}

//	Helpers
	private function hasObserver(list:Array, lObj:Object):Boolean{
		var len:Number = list.length;
		while(len--){
			if(list[len].getObject() == lObj) return true;
		}
		return false;
	}
}
