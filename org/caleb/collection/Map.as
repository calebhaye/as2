import org.caleb.core.CoreInterface;
import org.caleb.collection.Set;
import org.caleb.collection.Collection;

/**
 * An object that maps keys to values. A map cannot contain duplicate keys; each key can map to at most one value.
 * This interface takes the place of the Dictionary class, which was a totally abstract class rather than an interface.
 * The Map interface provides three collection views, which allow a map's contents to be viewed as a set of keys, collection of values, or set of key-value mappings. The order of a map is defined as the order in which the iterators on the map's collection views return their elements. Some map implementations, like the TreeMap class, make specific guarantees as to their order; others, like the HashMap class, do not.
 * Note: great care must be exercised if mutable objects are used as map keys. The behavior of a map is not specified if the value of an object is changed in a manner that affects equals comparisons while the object is a key in the map. A special case of this prohibition is that it is not permissible for a map to contain itself as a key. While it is permissible for a map to contain itself as a value, extreme caution is advised: the equals and hashCode methods are no longer well defined on a such a map.
 * All general-purpose map implementation classes should provide two "standard" constructors: a void (no arguments) constructor which creates an empty map, and a constructor with a single argument of type Map, which creates a new map with the same key-value mappings as its argument. In effect, the latter constructor allows the user to copy any map, producing an equivalent map of the desired class. There is no way to enforce this recommendation (as interfaces cannot contain constructors) but all of the general-purpose map implementations in the SDK comply.
 * 
 * @see     CoreInterface	
 */
interface org.caleb.collection.Map extends CoreInterface{
	/**
	 * Removes all mappings from this map (optional operation).
	 * @return  Void
	 */
	public function clear(Void):Void;
	/**
	 * Returns true if this map contains a mapping for the specified key.
	 * @param   key 
	 * @return  Boolean
	 */
	public function containsKey(key:Object):Boolean;
	/**
	 * Returns true if this map maps one or more keys to the specified value.
	 * @param   value 
	 * @return  Boolean
	 */
	public function containsValue(value:Object):Boolean;
	/**
	 * Returns a set view of the mappings contained in this map.
	 * @return  Collection
	 */
	public function entrySet(Void):Collection;
	/**
	 * Compares the specified object with this map for equality.
	 * @param   o 
	 * @return  Boolean
	 */
	public function equals(o:Object):Boolean;
	/**
	 * Returns the value to which this map maps the specified key.
	 * @param   key 
	 * @return  Object
	 */
	public function getEntry(key:Object):Object;
	/**
	 * Returns true if this map contains no key-value mappings.
	 * @return  Boolean
	 */
	public function isEmpty(Void):Boolean;
	/**
	 * Returns a set view of the keys contained in this map.
	 * @return  Set
	 */
	public function keySet(Void):Set;
	/**
	 * Associates the specified value with the specified key in this map (optional operation).
	 * @param   key   
	 * @param   value 
	 * @return  Object
	 */
	public function putEntry(key:Object, value:Object):Object;
	/**
	 * Copies all of the mappings from the specified map to this map (optional operation).
	 * @param   t 
	 * @return  Void
	 */
	public function putAll(t:Map):Void;
	/**
	 * Removes the mapping for this key from this map if present (optional operation).
	 * @param   key 
	 * @return  Object
	 */
	public function removeEntry(key:Object):Object;
	/**
	 * Returns the number of key-value mappings in this map.
	 * @return  Number
	 */
	public function size(Void):Number;
	/**
	 * Returns a collection view of the values contained in this map.
	 * @return  Collection
	 */
	public function values(Void):Collection;
}
