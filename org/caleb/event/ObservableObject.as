import org.caleb.core.CoreObject;
import org.caleb.core.CoreInterface;
import org.caleb.event.Observable;
import org.caleb.event.Event;
import org.caleb.event.EventDispatcher;

/**
 * 
 * @see     CoreObject	
 * @see     Observable	
 */
class org.caleb.event.ObservableObject extends CoreObject implements Observable{
	private var $eventDispatcher:EventDispatcher;
	public function ObservableObject(Void){
		super();
		this.$instanceDescription = 'org.caleb.event.ObservableObject';
		this.$eventDispatcher = new EventDispatcher();
	}

	/*	conform to the Observable interface	 and delegate calls to this.$eventDispatcher		*/
	/**
	 * 
	 * @param   observerObject 
	 * @param   messageName    
	 */
	public function addEventObserver(observerObject, messageName:String):Void
	{
		this.$eventDispatcher.addEventObserver(observerObject, messageName);
		if(arguments.length > 2)
		{
			for(var i = 2; i < arguments.length; i++)
			{
				this.$eventDispatcher.addEventObserver(observerObject, arguments[i]);
			}
		}
	}
	/**
	 * 
	 * @param   observerObject 
	 * @param   messageName    
	 */
	public function removeEventObserver(observerObject, messageName:String):Void{
		this.$eventDispatcher.removeEventObserver(observerObject, messageName);
	}
	public function removeAllEventObservers():Void{
		this.$eventDispatcher.removeAllEventObservers();
	}

	/*	private dispatch method. delegates to this.$eventDispatcher	*/
	private function dispatchEvent(e:org.caleb.event.Event):Void{
		this.$eventDispatcher.dispatchEvent(e, this);
	}

}

