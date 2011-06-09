import org.caleb.util.Base64;
/**
 * Utility string class
 */
class org.caleb.util.StringUtil
{
	/**
	* Shortens the input string (inString) by the given amount (shortenBy)
	* 
	* @param inString (String)
	* @param shortenBy (Number)
	* @return String
	*/
	public static function shorten(inString:String, shortenBy:Number):String
	{
	var tempString:String = inString;
	tempString = tempString.slice(0,tempString.length-shortenBy);

	return tempString;
	}
	/**
	* Check if input string (inString) terminates with the given char/string (sChar)
	* 
	* @param inString (String)
	* @param sChar (String)
	* @return Boolean
	*/
	public static function endswith(inString:String, sChar:String):Boolean
	{
			var l_index:Number = inString.lastIndexOf(sChar);
			var s_count = inString.length;
			var c_count = sChar.length;
			return (s_count - c_count == l_index);
	}
	/**
	* Check if input string (inString) begin with the given char/string (sChar)
	* 
	* @param inString (String)
	* @param sChar (String)
	* @return Boolean
	*/
	public static function startswith(inString:String, sChar:String):Boolean
	{
			return inString.indexOf(sChar) == 0;
	}
	/**
	* Trim left a string
	* 
	* @param inString (String)
	* @return String
	*/
	public static function lstrip(inString:String):String
	{
			var index:Number = 0;
			while(inString.charCodeAt(index) < 33){
					index++;
			}
			return inString.substr(index)
	}
	/**
	* Trim right a string
	* 
	* @param inString (String)
	* @return String
	*/
	public static function rstrip(inString:String):String
	{
			var index:Number = inString.length - 1;
			while(inString.charCodeAt(index) < 33){
					index--;
			}
			return inString.substr(0,index + 1)
	}
	/**
	* Trim a string
	* 
	* @param inString (String)
	* @return String
	*/
	public static function strip(inString:String):String
	{
			return StringUtil.rstrip(StringUtil.lstrip(inString))
	}
	/**
	* Convert the first char of every string words in uppercase
	* @param inString (String)
	* @return String
	*/
	public static function capitalize(inString:String):String
	{
			var a:Number = 0;
			var aString:Array = inString.split(" ");
			for(a = 0; a < aString.length; a++)
			{
					aString[a] = aString[a].substring(0,1).toUpperCase() + aString[a].substring(1, aString[a].length);
			}
			return aString.join(" ");
	}

	/**
	* Replace all occurrence of a char into a string with the new char
	* 
	* @param inStr (String) to be converted
	* @param oldChar (String) value to replace
	* @param newChar (String) new value replaced
	* @return String
	*/
	public static function replace(inStr:String, oldChar:String, newChar:String):String
	{
			if(inStr == undefined || inStr == null)
			{
					return inStr;
			}
			return inStr.split(oldChar).join(newChar);
	}

	public static function Base64Encode( str:String ) : String
	{
		return Base64.Encode(str);
	}

	public static function Base64Decode( str:String ) : String
	{
		return Base64.Decode(str);
	}
	/**
	* Encrypt a string using the MD5 crypt hash
	* 
	* @param str (String) string to be crypted
	* @return String
	*/
	static public function md5(str:String):String
	{
		return org.caleb.util.md5.calculate(str);
	}

	/**
	 * Convert a decimal number into binary string
	 *
	 * @param       num     (Number)
	 * @return      String
	 */
	public static function dec2bin(num:Number):String {
			var bin:Array = new Array();
			var result:Number = num;
			var rest:Number;
			do
			{
					rest = result%2;
					result = Math.floor(result/2);
					bin.push(rest);
			} while(result != 0);
			bin.reverse()
			return bin.join('');
	}

	/**
	 * Returns a string with the char repeated n times
	 *
	 * @param       st      (String)
	 * @param       num     (Number)
	 * @return      String
	 */
	public static function string_repeat(st:String, num:Number):String 
	{
		var ret:String = new String;
		for(var a = 0; a < num; a++)
		{
				ret = ret.concat(st);
		}
		return ret;		
	}
	public static function formatTime(milliseconds):String
	{
		// derive values (centiseconds = 100th of a second)
		var centiseconds = Math.floor(milliseconds/10);
		var seconds = Math.floor(centiseconds/100);
		var minutes = Math.floor(seconds/60);
		
		// make sure values dont go beyond their
		// respective ranges
		centiseconds %= 100;
		seconds %= 60;
		minutes %= 60;
		
		// padd with 0's if values less than 2 digits (less than 10)
		if (centiseconds < 10) centiseconds = "0" + centiseconds;
		if (seconds < 10) seconds = "0" + seconds;
		if (minutes < 10) minutes = "0" + minutes;
		
		// return values separated by :
		return minutes +":"+ seconds +":"+ centiseconds;
	}
	public static function truncate(str:String, len:Number):String
	{
		var tmpstrLetter:String = '';
		var sText:String;
		if (str.length > len) 
		{
			sText = str.substring(0, len-3).concat('...');
		} 
		else
		{
			sText = str;
		}
		return sText;
	} 
}
