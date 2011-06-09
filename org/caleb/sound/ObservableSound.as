import org.caleb.sound.SimpleSound;
import org.caleb.event.Event;
import org.caleb.event.Observable;
import org.caleb.event.EventDispatcher;

/**
 * A Sound class that conforms to the Observable interface and delegate calls to org.caleb.event.EventDispatcher
 * 
 * @see     SimpleSound	
 * @see     Observable	
 */
class org.caleb.sound.ObservableSound extends SimpleSound implements Observable{
	private var $eventDispatcher:EventDispatcher;

	public function ObservableSound(obj){
		super(obj);
		this.setClassDescription('org.caleb.media.sound.ObservableSound');
		this.$eventDispatcher = new EventDispatcher();
	}
	public function onLoad():Void
	{
		var e = new Event('onSoundLoaded');
		e.addArgument('sound', this);
		this.dispatchEvent(e);
	}
	public function onID3():Void
	{
		var e = new Event('onID3');
		e.addArgument('sound', this);
		this.dispatchEvent(e);
	}
	public function onSoundComplete():Void
	{
		var e = new Event('onSoundComplete');
		e.addArgument('sound', this);
		this.dispatchEvent(e);
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
		this.$eventDispatcher.dispatchEvent(e);
	}
}
