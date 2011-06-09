import org.caleb.collection.Collection;
import org.caleb.collection.AbstractCollection;
import org.caleb.collection.Iterator;
import org.caleb.collection.Iterable;
import org.caleb.collection.StackIterator;
import org.caleb.collection.Stack;

/**
 * The Stack class represents a last-in-first-out stack of objects. 
 * 
 * @see     AbstractCollection	
 * @see     Stack	
 */
class org.caleb.collection.AbstractStack extends AbstractCollection implements Stack, Iterable
{
	private var $elements:Array;

	/**
	* Sole Constructor.  The constructor is private as this class is intended to be extended.
	*/
	private function AbstractStack()
	{
		this.$elements = new Array();
		this.setClassDescription('org.caleb.collection.AbstractStack');
	}

	/**
	 * Pushes an element onto the stack.
	 * @param   value 
	 * @return  Void
	 */
	public function push(value):Void{
		this.$elements.push(value);
	};

	/**
	 * Pops the top element off the stack and returns it.
	 * @return  Object
	 */
	public function pop(Void):Object
	{
		if(this.isEmpty()){
			//	Throw new EmptyStackException() if player 7
		}
		return this.$elements.pop();
	};

	/**
	 * Obtains the top element on the stack without removing it.
	 * @return  Object
	 */
	public function peek(Void):Object
	{
		if(this.$elements.length < 1){
			//	Throw new EmptyStackException() if player 7
			return;
		}
		var value = this.$elements[this.$elements.length-1];
		return value;
	};

	/**
	 * Gets whether there are more elements on the stack.
	 * @return  Boolean
	 */
	public function isEmpty(Void):Boolean{
		return (this.$elements.length < 1);
	};

	/**
	 * Returns the index of the given element
	 * @param   value 
	 * @return  Number
	 */
	public function search(value):Number{
		var len:Number = this.$elements.length;
		var pos:Number = -1;
		while(len--){
			if(this.$elements[len] == value){
				pos = len;
			}
		}
		return pos;
	};

	/**
	 * Gets an iterator for elements on the stack.
	 * @return Iterator
	 */
	public function iterator(Void):Iterator{
		return new StackIterator(this);
	};
}

