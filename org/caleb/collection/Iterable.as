import org.caleb.core.CoreInterface;
import org.caleb.collection.Iterator;
/**
 * Classes that conform to this interface have a publicly accessible Iterator
 */
interface org.caleb.collection.Iterable extends CoreInterface{
	/**
	 * Returns a reference to the iterator
	 * @return  Iterator
	 */
	public function iterator(Void):Iterator;
}
