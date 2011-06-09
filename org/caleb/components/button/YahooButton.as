import org.caleb.movieclip.LockingMovieClip;
import org.caleb.event.Event;
//
/**
 * YahooButton is a basic MovieClip wrapper providing button functionality
 * @see     LockingMovieClip	
 */
/**
 * 
 * @author  calebh
 * @version 1.0
 * @see     LockingMovieClip	
 * @since   
 */
class org.caleb.components.button.YahooButton extends LockingMovieClip 
{
	var $hit_mc:MovieClip;
	var dispatchEvent:Function;

	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function YahooButton () 
	{
		super();
		this.stop();
		this.createEventHandlerSnapshot('unlocked');
		if ($hit_mc != undefined)
		{
			this.setHit();
		}
	}
	
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	private function setHit () 
	{
		trace('Setting Hit');
		this.hitArea = this.$hit_mc;
		this.$hit_mc._visible = false;
	}
	
	//BUTTON EVENTS
	/**
	 * dispatches onDown event
	 */
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onPress ():Void {
		this.sendEvent('onDown');
		//this.gotoAndStop('_down');

	}
	/**
	 * dispatches onClick event
	 */
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onRelease ():Void {
		this.sendEvent('onClick');
		//this.gotoAndStop('_hover');
	}
	/**
	 * dispatches onInactive event
	 */
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onReleaseOutside ():Void {
		this.sendEvent('onInactive');
		//this.gotoAndStop('_inactive');
	}
	/**
	 * dispatches onHover event
	 */
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onRollOver ():Void {
		this.sendEvent('onHover');
		//this.gotoAndStop('_hover');
	}
	/**
	 * dispatches onInactive event
	 */
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function onRollOut ():Void {
		this.sendEvent('onInactive');
		//this.gotoAndStop('_inactive');
	}
	
	//LOCKING EVENTS
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	private function onLock():Void 
	{
		this.sendEvent('onLock');
		this.useHandCursor = false;
		// this.gotoAndStop('_active');
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	private function onUnlock():Void {
		this.sendEvent('onUnlock');
		this.useHandCursor = true;
		// this.gotoAndStop('_inactive');
	}
	
	//SENDS EVENTS
	/**
	 * 
	 * @usage   
	 * @param   s 
	 * @return  
	 */
	private function sendEvent (s:String) 
	{
		var e:org.caleb.event.Event = new org.caleb.event.Event(s);
		this.dispatchEvent(e);
	}
	
	/**
	 * 
	 * @usage   
	 * @param   b (Boolean) lock state will reflect this value
	 * @return  
	 */
	public function set lock(b:Boolean):Void
	{
		if(b == true)
		{
			this.onLock();
		}
		else if(b == false)
		{
			this.onUnlock();
		}
	}
}