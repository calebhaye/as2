import org.caleb.core.CoreObject;
import org.caleb.core.CoreInterface;
import org.caleb.collection.Iterator;
import org.caleb.collection.Set;

/**
 *  An iterator for sets that allows the programmer to traverse the set in either direction and modify the set during iteration.
 * @see     CoreObject	
 * @see     Iterator	
 */
class org.caleb.collection.SetIterator extends CoreObject implements Iterator{
	private var $set:Set;
	private var $pointer:Number;
	private var $removeCandidateIndex:Number;

	/**
	 * Sole Constructor
	 * @param   s 
	 */
	public function SetIterator(s:Set){
		this.$set = s;
		this.setClassDescription('org.caleb.collection.SetIterator');
		this.$pointer = -1;
	}

	/**
	 * Returns true if this set iterator has more elements when traversing the set in the forward direction.
	 * @return  Boolean
	 */
	public function hasNext(Void):Boolean{
		return (this.$set.size() > this.nextIndex());
	}

	/**
	 * Returns the next element in the set.
	 * @return  Object
	 */
	public function next(Void):Object{
		++this.$pointer;
		this.$removeCandidateIndex = this.$pointer;
		return this.$set.toArray()[this.$pointer];
	}

	/**
	 * Returns true if this set iterator has more elements when traversing the list in the reverse direction.
	 * @return  Boolean
	 */
	public function hasPrevious(Void):Boolean{
		return (this.$pointer >= 0);
	}

	/**
	 * Returns the previous element in the set.
	 * @return  Object
	 */
	public function previous(Void):Object{
		--this.$pointer;
		this.$removeCandidateIndex = this.$pointer;
		return this.$set.toArray()[this.$pointer];
	}

	/**
	 * Removes from the set the last element that was returned by next or previous (optional operation).
	 */
	public function remove(Void):Void
	{
		this.$set.remove(this.next());
	}
	/**
	 * Returns the index of the element that would be returned by a subsequent call to next.
	 * @return  Number
	 */
	public function nextIndex(Void):Number{
		return (this.$pointer + 1);
	}
	/**
	 * Returns the index of the element that would be returned by a subsequent call to previous.
	 * @return  Number
	 */
	public function previousIndex(Void):Number{
		return (this.$pointer - 1);
	}
	/**
	 * Reset
	 */
	public function reset(Void):Void
	{
		this.$pointer = -1;
	}
}