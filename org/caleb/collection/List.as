import org.caleb.collection.Collection;
import org.caleb.collection.ListIterator;
import org.caleb.collection.Iterator;
import org.caleb.collection.SimpleList;

/**
 * An ordered collection (also known as a sequence). The user of this interface has precise control over where in the list each element is inserted. The user can access elements by their integer index (position in the list), and search for elements in the list.
 * Unlike sets, lists typically allow duplicate elements. More formally, lists typically allow pairs of elements e1 and e2 such that e1.equals(e2), and they typically allow multiple null elements if they allow null elements at all. It is not inconceivable that someone might wish to implement a list that prohibits duplicates, by throwing runtime exceptions when the user attempts to insert them, but we expect this usage to be rare.
 * The List interface places additional stipulations, beyond those specified in the Collection interface, on the contracts of the iterator, add, remove, equals, and hashCode methods. Declarations for other inherited methods are also included here for convenience.
 * The List interface provides four methods for positional (indexed) access to list elements. Lists (like Java arrays) are zero based. Note that these operations may execute in time proportional to the index value for some implementations (the LinkedList class, for example). Thus, iterating over the elements in a list is typically preferable to indexing through it if the caller does not know the implementation.
 * The List interface provides a special iterator, called a ListIterator, that allows element insertion and replacement, and bidirectional access in addition to the normal operations that the Iterator interface provides. A method is provided to obtain a list iterator that starts at a specified position in the list.
 * The List interface provides two methods to search for a specified object. From a performance standpoint, these methods should be used with caution. In many implementations they will perform costly linear searches.
 * The List interface provides two methods to efficiently insert and remove multiple elements at an arbitrary point in the list.
 * Note: While it is permissible for lists to contain themselves as elements, extreme caution is advised: the equals and hashCode methods are no longer well defined on a such a list. 
 * 
 * @see     Collection	
 */
interface org.caleb.collection.List extends Collection{
	/**
	 * Inserts the specified element at the specified position in this list  (optional operation).
	 * 
	 * @param   element 
	 * @param   index   
	 * @return  Void
	 */
	public function addElementAtIndex(element:Object, index:Number):Void;

	/**
   	 * Appends the specified element to the end of this list (optional operation).
	 * 
	 * @param   element 
	 * @return  Boolean
	 */
	public function addElement(element:Object):Boolean;

	/**
	 * Appends all of the elements in the specified collection to the end of  this list, in the order that they are returned by the specified  collection's iterator (optional operation).
	 * 
	 * @param   c 
	 * @return  Boolean
	 */
	public function addAll(c:Collection):Boolean;

	/**
	 * Inserts all of the elements in the specified collection Numbero this  list at the specified position (optional operation).
	 * 
	 * @param   c     
	 * @param   index 
	 * @return  Boolean
	 */
	public function addAllAtIndex(c:Collection, index:Number):Boolean;

	/**
	 * Returns true if this list contains the specified element.
	 * 
	 * @param   element 
	 */
	public function contains(element:Object):Boolean;

	/**
	 * Compares the specified object with this list for equality.
	 * 
	 * @param   element 
	 * @return  Object
	 */
	public function equals(element:Object):Boolean;

	/**
	 * Returns the element at the specified position in this list.
	 * 
	 * @param   index 
	 * @return  Object
	 */
	public function getElementAtIndex(index:Number):Object;

	/**
	 * Returns the index in this list of the first occurrence of the specified  element, or -1 if this list does not contain this element.
	 * 
	 * @param   element 
	 * @return  Number
	 */
	public function indexOf(element:Object):Number;

	/**
	 * Returns the index in this list of the last occurrence of the specified  element, or -1 if this list does not contain this element.
	 * 
	 * @param   element 
	 * @return  Number
	 */
	public function lastIndexOf(element:Object):Number;

	/**
	 * Returns a list iterator of the elements in this list (in proper  sequence).
	 * 
	 * @return  ListIterator
	 */
	public function listIterator(Void):ListIterator;

	/**
	 * Returns a list iterator of the elements in this list (in proper  sequence), starting at the specified position in this list.
	 * 
	 * @param   index 
	 * @return  ListIterator
	 */
	public function listIteratorAtIndex(index:Number):ListIterator;

	/**
	 * Removes the element at the specified position in this list (optional  operation).
	 * 
	 * @param   index 
	 * @return  Object
	 */
	public function removeElementAtIndex(index:Number):Object;

	/**
	 * Replaces the element at the specified position in this list with the  specified element (optional operation).
	 * 
	 * @param   index   
	 * @param   element 
	 * @return  Object
	 */
	public function setElement(index:Number, element:Object):Object;

	/**
	 * Returns a view of the portion of this list between the specified  fromIndex, inclusive, and toIndex, exclusive.
	 * 
	 * @param   fromIndex 
	 * @param   toIndex   
	 * @return  List
	 */
	public function subList(fromIndex:Number, toIndex:Number):SimpleList;
}



