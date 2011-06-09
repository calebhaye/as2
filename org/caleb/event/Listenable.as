import org.caleb.core.CoreInterface;
/**
 * 
 * @see     CoreInterface	
 */
interface org.caleb.event.Listenable extends CoreInterface{
	/**
	 * 
	 * @param   e 
	 */
	public function handleEvent(e:org.caleb.event.Event):Void;
}