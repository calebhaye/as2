import org.caleb.collection.AbstractMap;
import org.caleb.collection.Map;

/**
 * A class reprezenting a simple map of objects which allows also synchronized access.
 * 
 * @see     AbstractMap	
 */
class org.caleb.collection.SimpleMap extends AbstractMap implements Map
{
	/**
	 * Sole Constructor
	 */
	public function SimpleMap(){
		super();
		this.setClassDescription('org.caleb.collection.SimpleMap');
	}
}

