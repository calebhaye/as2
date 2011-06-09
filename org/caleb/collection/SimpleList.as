import org.caleb.core.CoreObject;
import org.caleb.collection.Collection;
import org.caleb.collection.ListIterator;
import org.caleb.collection.Iterator;
import org.caleb.collection.Iterable;
import org.caleb.collection.List;
import org.caleb.collection.AbstractList;

/**
 * A class reprezenting a simple list of objects which allows also synchronized access.
 * @see     AbstractList	
 */
class org.caleb.collection.SimpleList extends AbstractList implements List, Iterable
{
	/**
	 * Sole Constructor
	 */
	public function SimpleList(){
		super();
		this.setClassDescription('org.caleb.collection.SimpleList');
	}
}

