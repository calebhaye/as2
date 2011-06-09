import org.caleb.collection.AbstractCollection;
import org.caleb.collection.Collection;
import org.caleb.collection.Iterable;

/**
 * This class provides an implementation of the Collection interface, to minimize the effort required to implement this interface. 
 * 
 * @see     AbstractCollection
 */
class org.caleb.collection.SimpleCollection extends AbstractCollection implements Collection, Iterable
{
	/**
	 * Sole Constructor
	 */
	public function SimpleCollection()
	{
		super();
		this.setClassDescription('org.caleb.collection.SimpleCollection');
	}
}

