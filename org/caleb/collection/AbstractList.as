import org.caleb.collection.Collection;
import org.caleb.collection.AbstractCollection;
import org.caleb.collection.ListIterator;
import org.caleb.collection.Iterator;
import org.caleb.collection.Iterable;
import org.caleb.collection.List;
import org.caleb.collection.SimpleList;

/**
 * This class provides a skeletal implementation of the List interface to minimize the effort required to implement this interface backed by a "random access" data store (such as an array). For sequential access data (such as a linked list), AbstractSequentialList should be used in preference to this class.
 * To implement an unmodifiable list, the programmer needs only to extend this class and provide implementations for the getElement(int index) and size() methods.
 * To implement a modifiable list, the programmer must additionally override the setElement(int index, Object element) method (which otherwise throws an UnsupportedOperationException. If the list is variable-size the programmer must additionally override the add(int index, Object element) and remove(int index) methods.
 * The programmer should generally provide a void (no argument) and collection constructor, as per the recommendation in the Collection interface specification.
 * Unlike the other abstract collection implementations, the programmer does not have to provide an iterator implementation; the iterator and list iterator are implemented by this class.
 * The documentation for each non-abstract methods in this class describes its implementation in detail. Each of these methods may be overridden if the collection being implemented admits a more efficient implementation. 
 * 
 * @see     AbstractCollection	
 * @see     List	
 */
class org.caleb.collection.AbstractList extends AbstractCollection implements List, Iterable
{
	private var $elements:Array;
	public var $iterator:ListIterator;
	
	/**
	 * Sole constructor.  The constructor is private as this class is intended to be extended.
	 */
	private function AbstractList()
	{
		this.$elements = new Array();
		this.setClassDescription('org.caleb.collection.AbstractList');
		this.refreshIterator();
	}
	
	private function refreshIterator()
	{
		this.$iterator = new ListIterator(this);
	}

	/**
	 * Inserts the specified element at the specified position in this list (optional operation). 
	 * @param   element 
	 * @param   index   
	 * @return  Void
	 */
	public function addElementAtIndex(element:Object, index:Number):Void{
		this.$elements[index] = element;
		this.refreshIterator();
	};

	/**
	 * Appends the specified element to the end of this list (optional operation).
	 * @param   o 
	 * @return  Boolean
	 */
	public function addElement(o:Object):Boolean{
		this.$elements.push(o);
		this.refreshIterator();
		return true;
	};

	/**
	 * Appends all of the elements in the specified collection to the end of this list, in the order that they are returned by the specified collection's iterator (optional operation).
	 * @param   c 
	 * @return  Boolean
	 */
	public function addAll(c:Collection):Boolean
	{
		//	iterate thru the collection and add each item
		var keysIterator = c.iterator();
		var element;
		while(keysIterator.hasNext())
		{
			element = keysIterator.next();
			this.addElement(element);
		}

		this.refreshIterator();
		return true;
	};

	/**
	 * Inserts all of the elements in the specified collection Numbero this list at the specified position (optional operation).
	 * @param   c     
	 * @param   index 
	 * @return  Boolean
	 */
	public function addAllAtIndex(c:Collection, index:Number):Boolean{
		//	iterate thru the collection and add each item, starting at (index)
		var keysIterator = c.iterator();
		var element;
		while(keysIterator.hasNext())
		{
			element = keysIterator.next();
			this.addElementAtIndex(element, index);
			index++;
		}

		this.refreshIterator();
		return true;
	};

	/**
	 * Removes all of the elements from this list (optional operation).
	 * @return  Void
	 */
	public function clear(Void):Void{
		this.$elements = new Array();
		this.refreshIterator();
	};

	/**
	 * Returns true if this list contains the specified element.
	 * @param   o 
	 * @return  Boolean
	 */
	public function contains(o:Object):Boolean{
		if(this.indexOf(o) == -1){
			return false;
		}
		return true;
	};

	/**
	 * Returns true if this list contains all of the elements of the specified collection.
	 * @param   c 
	 * @return  Boolean
	 */
	public function containsAll(c:Collection):Boolean{
		//	for each item in the collection, call contains()
		var keysIterator = c.iterator();
		var element:Object;
		var isInCollection:Boolean = false;
		
		while(keysIterator.hasNext())
		{
			element = keysIterator.next();
			isInCollection = this.contains(element);
			if(isInCollection != true)
			{
				return false;
			}
		}
		
		return true;
	};

	/**
	 * Compares the specified object with this list for equality.
	 * @param   o 
	 * @return  Boolean
	 */
	public function equals(o:Object):Boolean{
		return (o == this);
	};

	/**
	 * Returns the element at the specified position in this list.
	 * @param   index 
	 * @return  Object
	 */
	public function getElementAtIndex(index:Number):Object{
		return this.$elements[index];
	};

	/**
	 * Returns the element.
	 * @param   obj 
	 * @return  Object
	 */
	public function getElement(obj:Object):Object{
		return this.$elements[this.indexOf(obj)];
	};

	/**
	 * Returns the index in this list of the first occurrence of the specified element, or -1 if this list does not contain this element.
	 * @param   o 
	 * @return  Number
	 */
	public function indexOf(o:Object):Number{
		var len:Number = this.$elements.length;
		var pos:Number = -1;
		while(pos < len){
			if(this.$elements[pos] == o){
				return pos;
			}
			pos++;
		}
		return -1;
	};

	/**
	 * Returns true if this list contains no elements.
	 * @return  Boolean
	 */
	public function isEmpty(Void):Boolean{
		return (this.$elements.length < 1);
	};

	/*
	//Returns an iterator over the elements in this list in proper sequence.
	public function iterator(Void):Iterator{
		return this.listIterator();
	};
	*/

	/**
	 * Returns a list iterator of the elements in this list (in proper sequence).
	 * @return  ListIterator
	 */
	public function listIterator(Void):ListIterator{
		// return new ListIterator(this);
		return this.$iterator;
	};

	/**
	 * Returns the index in this list of the last occurrence of the specified element, or -1 if this list does not contain this element.
	 * @param   o 
	 * @return  Number
	 */
	public function lastIndexOf(o:Object):Number{
		var len:Number = this.$elements.length;
		var pos:Number = -1;
		while(len--){
			if(this.$elements[len] == o){
				pos = len;
				break;
			}
		}
		return pos;
	};

	/**
	 * Returns a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list.
	 * @param   index 
	 * @return  ListIterator
	 */
	public function listIteratorAtIndex(index:Number):ListIterator{
		var items:AbstractList = new AbstractList();
		while(index<this.$elements.length){
			items.addElement(this.$elements[index]);
			++index;
		}
		return new ListIterator(items);
	};

	/**
	 * Removes the element at the specified position in this list (optional operation).
	 * @param   index 
	 * @return  Object
	 */
	public function removeElementAtIndex(index:Number):Object{
		var item = this.$elements[index];
		this.$elements[index] = null;
		return item;
	};

	/**
	 * Removes the first occurrence in this list of the specified element (optional operation).
	 * @param   o 
	 * @return  Boolean
	 */
	public function removeElement(o:Object):Boolean{
		var pos:Number = this.indexOf(o);
		if(pos == -1){
			return false;
		}
		this.removeElementAtIndex(pos);
		return true;
	};

	/**
	 * Removes all the elements from this list
	 * @param   c 
	 * @return  Boolean
	 */
	public function removeAll(c:Collection):Boolean{
		this.$elements = new Array();
		return true;
	};

	/**
	 * Retains only the elements in this list that are contained in the specified collection (optional operation).
	 * @param   c 
	 * @return  Boolean
	 */
	public function retainAll(c:Collection):Boolean
	{
		this.clear();
		var keysIterator = c.iterator();
		var element:Object;
		
		while(keysIterator.hasNext())
		{
			element = keysIterator.next();
			this.addElement(element);
		}
		
		return true;
	};

	/**
	 * Replaces the element at the specified position in this list with the specified element (optional operation).
	 * @param   index   
	 * @param   element 
	 * @return  Object
	 */
	public function setElement(index:Number, element:Object):Object{
		this.$elements[index] = element;
		return element;
	};

	/**
	 * Returns the number of elements in this list.
	 * @return  Number
	 */
	public function size(Void):Number{
		return this.$elements.length;
	};

	/**
	 * Returns a view of the portion of this list between the specified fromIndex, inclusive, and toIndex, exclusive. 
	 * @param   fromIndex 
	 * @param   toIndex   
	 * @return  List
	 */
	public function subList(fromIndex:Number, toIndex:Number):SimpleList{
		var out:SimpleList = new SimpleList();
		var i:Number;
		for(i=fromIndex; i<toIndex; i++){
			out.addElement(this.$elements[i]);
		}
		return out;
	};

	/**
	 * Returns an array containing all of the elements in this list in proper sequence. 
	 * @return  Array
	 */
	public function toArray(Void):Array{
		return this.$elements;
	};
}

