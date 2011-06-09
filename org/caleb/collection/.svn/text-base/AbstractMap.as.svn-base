import org.caleb.core.CoreObject;
import org.caleb.collection.Collection;
import org.caleb.collection.AbstractCollection;
import org.caleb.collection.AbstractList;
import org.caleb.collection.Map;
import org.caleb.collection.Set;
import org.caleb.collection.SetIterator;
import org.caleb.collection.SimpleSet;
import org.caleb.util.ObjectUtil;

/**
 * This class provides a skeletal implementation of the Map interface, to minimize the effort required to implement this interface. 
 * To implement an unmodifiable map, the programmer needs only to extend this class and provide an implementation for the entrySet method, which returns a set-view of the map's mappings. Typically, the returned set will, in turn, be implemented atop AbstractSet. This set should not support the add or remove methods, and its iterator should not support the remove method.
 * To implement a modifiable map, the programmer must additionally override this class's put method (which otherwise throws an UnsupportedOperationException), and the iterator returned by entrySet().iterator() must additionally implement its remove method.
 * The programmer should generally provide a void (no argument) and map constructor, as per the recommendation in the Map interface specification.
 * The documentation for each non-abstract methods in this class describes its implementation in detail. Each of these methods may be overridden if the map being implemented admits a more efficient implementation. 
 * 
 * @see     CoreObject	
 * @see     Map	
 */
class org.caleb.collection.AbstractMap extends CoreObject implements Map
{
	private var $elements:Object;

	/**
	 * Sole constructor.  The constructor is private as this class is intended to be extended.
	 */
	private function AbstractMap()
	{
		var m:Map = Map(arguments[0]);
		if(m != undefined)
		{
			this.putAll(m);
		}
		this.$elements = new Object();
		this.setClassDescription('org.caleb.collection.AbstractMap');
	}

	/**
	 * Removes all mappings from this map (optional operation).
	 * @return  Void
	 */
	public function clear(Void):Void{
		this.$elements = new Object();
	}

	/**
	 * Returns true if this map contains a mapping for the specified key.
	 * @param   key 
	 * @return  Boolean
	 */
	public function containsKey(key:Object):Boolean{
		var k;
		for(k in this.$elements){
			if(ObjectUtil.isEqual(k, key)){
				return true;
			}
		}
		return false;
	};

	/**
	 * Returns true if this map maps one or more keys to this value.
	 * @param   value 
	 * @return  Boolean
	 */
	public function containsValue(value:Object):Boolean{
		var k;
		for(k in this.$elements){
			if(ObjectUtil.isEqual(this.$elements[k], value)){
				return true;
			}
		}
		return false;
	};

	/**
	 * Inoperative.  Should return a set view of the mappings contained in this map.
	 * @return  Collection
	 */
	public function entrySet(Void):Collection{
		return new SimpleSet();
	};//	returns a Set of MapEntry objs

	/**
	 * Compares the specified object with this map for equality.
	 * @param   o 
	 * @return  Boolean
	 */
	public function equals(o:Object):Boolean{
		return ObjectUtil.isEqual(o, this);
	};

	/**
	 * Returns the value to which this map maps the specified key.
	 * @param   key 
	 * @return  Object
	 */
	public function getEntry(key:Object):Object{
		return this.$elements[key];
	};

	/**
	 * Returns true if this map contains no key-value mappings.
	 * @return  Boolean
	 */
	public function isEmpty(Void):Boolean{
		return (this.size()==0);
	};

	/**
	 * Returns a Set view of the keys contained in this map.
	 * @return  Set
	 */
	public function keySet(Void):Set{
		var k;
		var keys = new SimpleSet();
		for(k in this.$elements){
			keys.addElement(k);
		}
		//trace(keys.iterator().hasNext())
		return keys;
	};

	/**
	 * Associates the specified value with the specified key in this map (optional operation).
	 * @param   key   
	 * @param   value 
	 * @return  Object
	 */
	public function putEntry(key:Object, value:Object):Object{
		var previous = this.$elements[key];
		this.$elements[key] = value;
		return previous;
	};

	/**
	 * Copies all of the mappings from the specified map to this map (optional operation).
	 * @param   t 
	 * @return  Void
	 */
	public function putAll(t:Map):Void
	{
		var keys = t.keySet();
		var keysIterator = keys.iterator();
		var value, key;
		while(keysIterator.hasNext()){
			key = keysIterator.next();
			value = t.getEntry(key);
			this.putEntry(key, value);
		}
	};

	/**
	 * Removes the mapping for this key from this map if present (optional operation).
	 * @param   key 
	 * @return  Object
	 */
	public function removeEntry(key:Object):Object{
		var r = this.$elements[key];
		delete(this.$elements[key]);
		return r;
	};

	/**
	 * Returns the number of key-value mappings in this map.
	 * @return  Number
	 */
	public function size(Void):Number{
		var k;
		var count=0;
		for(k in this.$elements){
			count++;
		}
		return count;
	};

	/**
	 * Returns a collection view of the values contained in this map.
	 * @return  Collection
	 */
	public function values(Void):Collection{
		var k;
		var values = new SimpleSet();
		for(k in this.$elements){
			values.addElement(this.$elements[k]);
		}
		return values;
	};
}