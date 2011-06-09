
/**
* Class: com.kelvinluck.util.DateFormat
* 
* Just a very simple class to hold some functions for formating a Flash
* Date object.
* 
* No need to create instances of the class -
* just use the static methods it provides...
* 
**/
class org.caleb.util.DateUtil {
	
	/**
	* Function: DateFormat
	* 
	* Private constructor to prevent you creating instances of this class
	**/
	private function DateUtil()
	{
		
	}
	
	/**
	* Function: dateToIso
	* 
	* Static function which converts a given Date object into an ISO / MySQL Date Stamp
	* format (e.g. "yyyy-mm-dd hh:mm:ss")
	* 
	* Parameters:
	* date			-	The Date to convert
	* 
	* Returns:
	* The ISO / MySQL Date Stamp Format String.
	**/
	public static function dateToIso(date:Date):String
	{
		return date.getUTCFullYear()
			+ "-" 
			+ _zeroPad(date.getUTCMonth()+1)
			+ "-" 
			+ _zeroPad(date.getUTCDate())
			+ " "
			+ _zeroPad(date.getUTCHours())
			+ ":"
			+ _zeroPad(date.getUTCMinutes())
			+ ":"
			+ _zeroPad(date.getUTCSeconds())
	}
	
	/**
	* Function: isoToDate
	* 
	* Static function which converts a given ISO / MySQL Date Stamp Format String (e.g.
	* "yyyy-mm-dd hh:mm:ss") into a Date object
	* 
	* Parameters:
	* dateStr		-	The ISO / MySQL Date Stamp Format String
	* 
	* Returns:
	* The converted Date object.
	**/
	public static function isoToDate(dateStr:String):Date
	{
		var parts:Array = dateStr.split(" ");
		var dateParts:Array = parts[0].split("-");
		var timeParts:Array = parts[1].split(":");
		var d:Date = new Date(dateParts[0], dateParts[1]-1, dateParts[2], timeParts[0], timeParts[1], timeParts[2]);
		return d;
	}
	
	/**
	* Function: secsToDate
	* 
	* Static function which converts a number of seconds into a Date object.
	* 
	* Parameters:
	* secs			-	The number of seconds since 1970. Purposefully not strongly 
	* 					typed as the whole point of this very simple function is to 
	* 					save on typing in the cases you may need it.
	* 
	* Returns:
	* The converted Date object.
	**/
	public static function secsToDate(secs):Date
	{
		return new Date(Number(secs) * 1000);
	}
	
	/**
	* Function: _zeroPad
	* 
	* Simple function to make sure a number is the right amount of characters long -
	* used internally by <dateToIso>.
	* 
	* Parameters:
	* value				-	The number you want to zero pad.
	* 
	* TODO:
	* Maybe add a second parameter which is how many zeros you want to pad it with?
	**/
	private static function _zeroPad(value:Number):String
	{
		
		return (value < 9) ? String('0'+value) : String(value);
	}
}