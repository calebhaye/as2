import org.caleb.core.CoreInterface;

/**
 * 
 * @see     CoreInterface	
 */
interface org.caleb.loader.LoaderView extends CoreInterface{
	/**
	 * 
	 * @param   e 
	 */
	public function LoaderDidChange(e:org.caleb.event.Event):Void;
	/**
	 * 
	 * @param   e 
	 */
	public function LoaderDidComplete(e:org.caleb.event.Event):Void;
	/**
	 * 
	 * @param   e 
	 */
	public function LoaderDidFail(e:org.caleb.event.Event):Void;
}


