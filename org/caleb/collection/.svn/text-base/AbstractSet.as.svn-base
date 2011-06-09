import org.caleb.collection.Collection;
import org.caleb.collection.AbstractCollection;
import org.caleb.collection.Iterator;
import org.caleb.collection.Iterable;
import org.caleb.collection.SetIterator;
import org.caleb.collection.Set;
import org.caleb.util.ObjectUtil;

/**
 * This class provides a skeletal implementation of the Set interface to minimize the effort required to implement this interface. 
 * The process of implementing a set by extending this class is identical to that of implementing a Collection by extending AbstractCollection, except that all of the methods and constructors in subclasses of this class must obey the additional constraints imposed by the Set interface (for instance, the add method must not permit addition of multiple intances of an object to a set).
 * Note that this class does not override any of the implementations from the AbstractCollection class. It merely adds implementations for equals
 *
 * @see     AbstractCollection	
 * @see     Set	
 */
class org.caleb.collection.AbstractSet extends AbstractCollection implements Set, Iterable
{
	private var $elements:Array;
	private var $iterator:SetIterator;
	/**
	 * Sole Constructor.  The constructor is private as this class is intended to be extended.
	 */
	private function AbstractSet()
	{
		this.$elements = new Array();
		this.setClassDescription('org.caleb.collection.AbstractSet');
		this.refreshIterator();
	}
	private function refreshIterator()
	{
		this.$iterator = new SetIterator(this);
	}
	/**
	 * Ensures that this set contains 1 instance of the specified element (optional operation).
	 * @param   element 
	 * @return  Boolean
	 */
	public function addElement(element:Object):Boolean
	{
		if(this.contains(element) == false)
		{
			this.$elements.push(element);
			this.refreshIterator();
			return true;
		}
		else
		{
			return false;
		}
	};

	/**
	 * Compares the specified object with this collecton for equality
	 * @param   o 
	 * @return  Boolean
	 */
	public function equals(o:Object):Boolean{
		return ObjectUtil.isEqual(this, o);
	};
	/**
	 * Returns an iterator over the elements contained in this collection.
	 * @return  Iterator
	 */
	public function iterator(Void):Iterator{
		return this.$iterator;
	};
}

