﻿import org.caleb.core.CoreObject;
import org.caleb.core.CoreInterface;
import org.caleb.collection.Iterator;
import org.caleb.collection.List;

/**
 * An iterator for lists that allows the programmer to traverse the list in either direction and modify the list during iteration. 
 * @see     CoreObject	
 * @see     Iterator	
 */
class org.caleb.collection.ListIterator extends CoreObject implements Iterator{
	private var $list:List;
	private var $pointer:Number;	
	
	/**
	 * Sole Constructor
	 * @param   l List
	 */
	public function ListIterator(l:List)
	{
		this.$list = l;
		this.setClassDescription('org.caleb.collection.ListIterator');
		this.reset();
	}

	/**
	 * Returns true if this list iterator has more elements when traversing the list in the forward direction.
	 * @return  Boolean
	 */
	public function hasNext(Void):Boolean
	{
		var canIterate:Boolean = (this.$list.size() > this.nextIndex());
		return canIterate;
	}
	
	/**
	 * Returns the current element in the list.
	 * @return Object 
	 */
	public function current(Void):Object
	{
		return this.$list.getElementAtIndex(this.$pointer);
	}

	/**
	 * Returns the next element in the list.
	 * @return  Object
	 */
	public function next(Void):Object
	{
		++this.$pointer;
		return this.$list.getElementAtIndex(this.$pointer);
	}

	/**
	 * Removes from the list the last element that was returned by next or previous (optional operation).
	 */
	public function remove(Void):Void
	{
		this.$list.remove(this.next());
	}

	/**
	 * Inserts the specified element into the list (optional operation).
	 * @param   o 
	 */
	public function addElement(o:Object):Void
	{
		this.$list.addElement(o);
	}

	/**
	 * Returns true if this list iterator has more elements when traversing the list in the reverse direction.
	 * @return  Boolean
	 */
	public function hasPrevious(Void):Boolean
	{
		return (this.$pointer >= 0);
	}

	/**
	 * Returns the index of the element that would be returned by a subsequent call to next.
	 * @return  Number
	 */
	public function nextIndex(Void):Number
	{
		return this.$pointer + 1;
	}

	/**
	 * Returns the index of the current element.
	 * @return  Number
	 */
	public function index(Void):Number
	{
		return this.$pointer;
	}

	/**
	 * Returns the previous element in the list.
	 * @return  Object
	 */
	public function previous(Void):Object
	{
		--this.$pointer;
		return this.$list.getElementAtIndex(this.$pointer);
	}

	/**
	 * Returns the index of the element that would be returned by a subsequent call to previous.
	 * @return  Number
	 */
	public function previousIndex(Void):Number
	{
		return this.$pointer - 1;
	}

	/**
	 * Replaces the last element returned by next or previous with the specified element (optional operation).
	 * @param   o 
	 */
	public function setElement(o:Object):Void
	{
		this.$list.setElement(this.$pointer, o);
	}

	/**
	 * Reset
	 */
	public function reset(Void):Void
	{
		this.$pointer = -1;
	}
	/**
	 * Go to final position
	 */
	public function end(Void):Void
	{
		this.$pointer = this.$list.size();
	}
	/**
	 * Returns a reference back to the private $list var
	 * @return  List
	 */
	public function get list():List
	{
		return this.$list;
	}
}

