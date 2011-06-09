import org.caleb.core.CoreInterface;
/**
 * An iterator over a collection. Iterator takes the place of Enumeration in the Java collections framework. Iterators differ from enumerations in two ways: 
 * 
 * Iterators allow the caller to remove elements from the underlying collection during the iteration with well-defined semantics. 
 * Method names have been improved. 
 * 
 * @see CoreInterface
 */
interface org.caleb.collection.Iterator extends CoreInterface{
	/**
	 * Returns true if the iteration has more elements.
	 * @return  Boolean
	 */
	public function hasNext(Void):Boolean;

	//	todo: should throw NoSuchElement exception
	/**
	 * Returns the next element in the interation.
	 * @return  Object
	 */
	public function next(Void):Object;

	//	todo: 
	//	should throw UnsupportedOperationException 
	//	(if the remove  operation is not supported by this Iterator.)
	//	should throw IllegalStateException (if the next method has not 
	//	yet been called, or the remove method has already  been called after the last call to the next  method.)
	/**
	 * Removes from the underlying collection the last element returned by the iterator (optional operation).
	 * @return  Void
	 */
	public function remove(Void):Void;

}
