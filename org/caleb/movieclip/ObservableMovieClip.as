import org.caleb.movieclip.CoreMovieClip;
import org.caleb.event.Observable;
import org.caleb.event.Event;
import org.caleb.event.EventDispatcher;

/**
 * A MovieClip class that conforms to the Observable interface and delegate calls to org.caleb.event.EventDispatcher
 * 
 * @see     CoreMovieClip	
 * @see     Observable	
 */
class org.caleb.movieclip.ObservableMovieClip extends CoreMovieClip implements Observable
{
	private var $eventDispatcher:EventDispatcher;
	public function ObservableMovieClip(Void){
		super();
		this.setClassDescription('org.caleb.event.ObservableMovieClip');
		this.$eventDispatcher = new EventDispatcher();
	}

	/**
	 * conform to the Observable interface	 and delegate calls to org.caleb.event.EventDispatcher
	 * 
	 * @param   observerObject 
	 * @param   messageName    
	 */
	public function addEventObserver(observerObject, messageName:String):Void{
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
	 * conform to the Observable interface	 and delegate calls to org.caleb.event.EventDispatcher
	 * 
	 * @param   observerObject 
	 * @param   messageName    
	 */
	public function removeEventObserver(observerObject, messageName:String):Void{
		this.$eventDispatcher.removeEventObserver(observerObject, messageName);
	}
	
	/**
	 * conform to the Observable interface	 and delegate calls to org.caleb.event.EventDispatcher
	 * 
	 */
	public function removeAllEventObservers():Void{
		this.$eventDispatcher.removeAllEventObservers();
	}

	/**
	 *	public dispatch method. delegates to org.caleb.event.EventDispatcher
	 * 
	 * @param   e 
	 */
	public function dispatchEvent(e:org.caleb.event.Event):Void{
		this.$eventDispatcher.dispatchEvent(e, this);
	}

}

