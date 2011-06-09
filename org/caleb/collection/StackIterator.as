import org.caleb.core.CoreObject;
import org.caleb.collection.Iterator;
import org.caleb.collection.Stack;

/**
 * An iterator for stacks that allows the programmer to traverse the stack in either direction and modify the stack during iteration. 
 * @see     CoreObject	
 * @see     Iterator	
 */
class org.caleb.collection.StackIterator extends CoreObject implements Iterator{
	private var $stack:Stack;
	private var $pointer:Number;

	/**
	 * Sole Constructor
	 * @param   s 
	 */
	public function StackIterator(s:Stack){
		this.$stack = s;
		this.setClassDescription('org.caleb.collection.StackIterator');
	}

	/**
	 * Returns true if this stack iterator has more elements when traversing the stack in the forward direction.
	 * @return  Boolean
	 */
	public function hasNext(Void):Boolean{
		return !this.$stack.isEmpty();
	};

	/**
	 * Returns the next element in the stack.
	 * @return  Object
	 */
	public function next(Void):Object{
		return this.$stack.pop();
	};

	/**
	 * Removes from the stack the last element that was returned by next or previous (optional operation).
	 */
	public function remove(Void):Void{
		this.$stack.pop();
	};
}
