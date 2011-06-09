import org.caleb.core.CoreObject;
import org.caleb.reflect.ClassInfo;

/**
 * Incomplete.
 * This puppy needs lots of work. Right now, it's doing essentially nil. We need to have access to the info of the class of the object.
 * @see     CoreObject	
 */
class org.caleb.util.ClassUtil extends CoreObject
{
	/**
	 * Get details about a particular class.
	 * @param   obj (Object) to obtain info on
	 * @return  org.caleb.reflect.ClassInfo
	 * @see ClassInfo
	 */
	public static function getClassInfo(obj:Object):ClassInfo
	{
		return new ClassInfo(obj);
	}
}
