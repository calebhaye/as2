import org.caleb.core.CoreInterface;
import org.caleb.collection.Iterator;
/**
 * The root interface in the collection hierarchy. A collection represents a group of objects, known as its elements. Some collections allow duplicate elements and others do not. Some are ordered and others unordered. The SDK does not provide any direct implementations of this interface: it provides implementations of more specific subinterfaces like Set and List. This interface is typically used to pass collections around and manipulate them where maximum generality is desired.
 * Bags or multisets (unordered collections that may contain duplicate elements) should implement this interface directly.
 * All general-purpose Collection implementation classes (which typically implement Collection indirectly through one of its subinterfaces) should provide two "standard" constructors: a void (no arguments) constructor, which creates an empty collection, and a constructor with a single argument of type Collection, which creates a new collection with the same elements as its argument. In effect, the latter constructor allows the user to copy any collection, producing an equivalent collection of the desired implementation type. There is no way to enforce this convention (as interfaces cannot contain constructors) but all of the general-purpose Collection implementations in the SDK comply.
 * 
 * @see     CoreInterface	
 */
interface org.caleb.collection.Collection extends CoreInterface{
	/**
	 * Returns the number of elements in this collection.
	 * @return  Number
	 */
	public function size(Void):Number;
	/**
	 * Returns true if this collection contains no elements.
	 * @return Boolean
	 */
	public function isEmpty(Void):Boolean;
	/**
	 * Returns true if this collection contains the specified element.
	 * @param   element 
	 * @return  Boolean
	 */
	public function contains(element:Object):Boolean;
	/**
	 * 
	 * Ensures that this collection contains the specified element
	 * @param   element 
	 * @return  Boolean
	 */
	public function addElement(element:Object):Boolean;
	/**
	 * Removes a single instance of the specified element from this collection, if it is present (optional operation).
	 * @param   element 
	 * @return  Boolean
	 */
	public function remove(element:Object):Boolean;
	/**
	 * Returns an iterator over the elements in this collection
	 * @return  Iterator
	 */
	public function iterator(Void):Iterator;

	/**
	 * Returns true if this collection contains all of the elements in the specified collection.
	 * @param   c 
	 * @return  Boolean
	 */
	public function containsAll(c:Collection):Boolean;
	/**
	 * Adds all of the elements in the specified collection to this collection (optional operation).
	 * @param   c 
	 * @return  Boolean
	 */
	public function addAll(c:Collection):Boolean;
	/**
	 * Removes  all of the elements in the specified collection from this collection, if present (optional operation).
	 * @param   c 
	 * @return  Boolean
	 */
	public function removeAll(c:Collection):Boolean;
	/**
	 * Retains only the elements in this collection that are contained in the specified collection (optional operation).
	 * @param   c 
	 * @return  Boolean
	 */
	public function retainAll(c:Collection):Boolean;
	/**
	 * Removes all of the elements from this collection (optional operation).
	 * @return  Void
	 */
	public function clear(Void):Void;

	/**
	 * Returns an array containing all of the elements in this collection
	 * @return  Array
	 */
	public function toArray(Void):Array;
}
