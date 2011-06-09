import org.caleb.core.CoreObject;

/**
 * Static Math utility methods
 */
class org.caleb.util.MathUtil 
{
	/**
	 * This method provides functionality that simplifies creating perpetual, carouseling behaviors.  
	 * If the given next index is greater than the number of available positions, it will return 0.  
	 * If the given next index is less than 0, it will return the index of the last available position
	 * Otherwise, it will return the given next index.
	 * 
	 * @usage   myObj.index = wrap(2,10);
	 * @param   n (Number) next index position (current index + 1)
	 * @param   t (Number)total number of positions
	 * @return  Number
	 */
	public static function wrap(n,t):Number
	{
		// handle column wrap
		var columns:Number = arguments[2];
		if(columns > 0)
		{
			var wrappedPosition:Number = (n+columns)-t;
			if(n > t)
			{
				return (n+columns)-t;
			}
		}
		// handle normal wrap
		if( n >= t )
		{
			return 0; //wrap past end
		}
		else if(n < 0)
		{
			return t-1; //wrap past start
		}
		else
		{
			return n;
		}
	}
}