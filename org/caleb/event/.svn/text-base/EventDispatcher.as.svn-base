import org.caleb.core.CoreObject;
import org.caleb.event.EventObserver;
import org.caleb.event.Event;

/**
 * 
 * @see     CoreObject	
 */
class org.caleb.event.EventDispatcher extends CoreObject{

	private var $eventObserverMap:Object;

	public function EventDispatcher(Void){
		super();
		this.setClassDescription('org.caleb.event.EventDispatcher');
		this.$eventObserverMap = new Object();
	}
	public function get eventObserverMap():Object
	{
		return this.$eventObserverMap;
	}
	public function addEventObserver():Void{
		//	check to see if the listeners object has a list of 
		//	listeners for the event id eID. If not, create one.
		var lObj = arguments.shift();
		var eID:String;

		var len:Number = arguments.length;
		var count:Number = 0;

		while(count<len){
			eID = arguments[count];
			if(typeof this.$eventObserverMap[eID] != "object"){
				this.$eventObserverMap[eID] = new Array();
			}
			if(!this.hasEventObserver(this.$eventObserverMap[eID], lObj)){
				this.$eventObserverMap[eID].push(new EventObserver(lObj, eID));
			}
			count++;
		}

	}

	/**
	 * 
	 * @param   lObj 
	 * @param   eID  
	 */
	public function removeEventObserver(lObj:Object, eID:String):Void{
		var list:Array = this.$eventObserverMap[eID];
		var len:Number = list.length;
		if(len < 1) return;
		while(len--){
			if(list[len].getListeningInstance() == lObj){
				list.splice(len, 1);
				return;
			}
		}
	}

	/**
	 * 
	 * @param   eID 
	 */
	public function removeAllEventObservers(eID:String):Void{
		if(typeof eID == "string"){
			delete(this.$eventObserverMap[eID]);
		}else{
			delete(this.$eventObserverMap);
		}
	}

	/**
	 * 
	 * @param   e      
	 * @param   sender 
	 */
	public function dispatchEvent(e:org.caleb.event.Event, sender){
		var eID:String = e.getType();
		// trace('event dispatcher:dispatchEvent: '+eID)
		e.setSender(sender);
		var list:Array = this.$eventObserverMap[eID];
		var len:Number = list.length;
		if(len < 1) 
		{
			// trace('event dispatcher:No observers!')
			return;
		}
		var i:Number = 0;
		while(len--)
		{
			//trace('list[i]: '+list[i].getListeningInstance());
			list[i].callMethod(eID, e);
			i++;
		}
	}

//	Helpers
	private function hasEventObserver(list:Array, lObj:Object):Boolean{
		var len:Number = list.length;
		while(len--){
			if(list[len].getListeningInstance() == lObj) return true;
		}
		return false;
	}
}
