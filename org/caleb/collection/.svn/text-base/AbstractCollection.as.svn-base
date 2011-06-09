import org.caleb.core.CoreObject;
import org.caleb.collection.Iterator;
import org.caleb.collection.Iterable;
import org.caleb.collection.CollectionIterator;
import org.caleb.collection.Collection;
import org.caleb.util.ObjectUtil;

/**
 * This class provides a skeletal implementation of the Collection interface, to minimize the effort required to implement this interface. 
 * To implement an unmodifiable collection, the programmer needs only to extend this class and provide implementations for the iterator and size methods. (The iterator returned by the iterator method must implement hasNext and next.)
 * To implement a modifiable collection, the programmer must additionally override this class's add method (which otherwise throws an UnsupportedOperationException), and the iterator returned by the iterator method must additionally implement its remove method.
 * The programmer should generally provide a void (no argument) and Collection constructor, as per the recommendation in the Collection interface specification.
 * The documentation for each non-abstract methods in this class describes its implementation in detail. Each of these methods may be overridden if the collection being implemented admits a more efficient implementation. 
 * 
 * @see     CoreObject	
 * @see     Collection	
 */
class org.caleb.collection.AbstractCollection extends CoreObject implements Collection, Iterable
{
	private var $instanceDescription:String;
	private var $elements:Array;
	private var $iterator:CollectionIterator;
	/**
	 * Sole constructor.  The constructor is private as this class is intended to be extended.
	 */
	private function AbstractCollection()
	{
		super();
		this.$elements = new Array();
		this.setClassDescription('org.caleb.collection.AbstractCollection');
		this.refreshIterator();
	}

	private function refreshIterator()
	{
		this.$iterator = new CollectionIterator(this);
	}

	/**
	 * Returns the number of elements in this collection.
	 * @return  Number
	 */
	public function size(Void):Number{
		return this.$elements.length;
	};

	/**
	 * Returns true if this collection contains no elements.
	 * @return  Boolean
	 */
	public function isEmpty(Void):Boolean{
		return (this.$elements.length < 1);
	};

	// todo: should be rewritten to use an Iterator
	/**
	 * Returns true if this collection contains the specified element.
	 * @param   element 
	 * @return  Boolean
	 */
	public function contains(element:Object):Boolean{
		var len = this.$elements.length;
		var currentElement;
		while(len--){
			currentElement = this.$elements[len];
			if(ObjectUtil.isEqual(currentElement, element)){
				return true;
			}
		}
		return false;
	};

	/**
	 * Ensures that this collection contains the specified element (optional operation).
	 * @param   element 
	 * @return  Boolean
	 */
	public function addElement(element:Object):Boolean{
		this.$elements.push(element);
		this.refreshIterator();
		return true;
	};

	//	todo: should be rewritten to use an Iterator
	/**
	 * Removes a single instance of the specified element from this collection, if it is present (optional operation).
	 * @param   element 
	 * @return  Boolean
	 */
	public function remove(element:Object):Boolean{
		var len = this.$elements.length;
		var currentElement;
		while(len--){
			currentElement = this.$elements[len];
			if(ObjectUtil.isEqual(currentElement, element)){
				this.$elements.splice(len, 1);
				return true;
			}
		}
		this.refreshIterator();
		return false;
	};

	/**
	 * Returns an iterator over the elements contained in this collection.
	 * @return  Iterator
	 */
	public function iterator(Void):Iterator{
		return this.$iterator;
	};

	// Bulk Operations
	/**
	 * Inoperative.  Returns true if this collection contains all of the elements in the specified collection.
	 * @param   c 
	 * @return  Boolean
	 */
	public function containsAll(c:Collection):Boolean{
		return false;
	};

	/**
	 * Inoperative.  Adds all of the elements in the specified collection to this collection (optional operation).
	 * @param   c 
	 * @return  Boolean
	 */
	public function addAll(c:Collection):Boolean{
		return false;
	};
	/**
	 * Inoperative.  Removes from this collection all of its elements that are contained in the specified collection (optional operation).
	 * @param   c 
	 * @return  Boolean
	 */
	public function removeAll(c:Collection):Boolean{
		return false;
	};

	/**
	 * Inoperative.  Retains only the elements in this collection that are contained in the specified collection (optional operation).
	 * @param   c 
	 * @return  Boolean
	 */
	public function retainAll(c:Collection):Boolean{
		return false;
	};

	/**
	 * Removes all of the elements from this collection (optional operation).
	 * @return  Boolean
	 */
	public function clear(Void):Void{
		this.$elements = new Array();
	};

	/**
	 * Returns an array that contains all of the elements in this collection.
	 * @return  Array
	 */
	public function toArray(Void):Array{
		return this.$elements;
	};
}