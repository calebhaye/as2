/**
 * Simple abstraction layer for interactions with
 * Flash's binary cookie, the SharedObject
 * 
 * @author  calebh
 * @version 1.0
 */
class org.caleb.util.SharedObjectUtil
{
	private function SharedObjectUtil()
	{
	}
	
	public static function get(name:String, key:String):Object
	{
		var so:SharedObject = SharedObject.getLocal(name, '/');
		if(key == undefined)
		{
			key = name;
		}
		return so.data[key];
	}
	public static function save(name:String, key:String, data)
	{
		var so:SharedObject = SharedObject.getLocal(name, '/');
		
		if(so.data == undefined)
		{
			so.data = new Object;
		}
		so.data[key] = data;
		
		if(arguments[3] == undefined)
		{
			so.flush();
		}
		else
		{
			so.flush(Number(arguments[2]));
		}
	}
	public static function clear(name:String):Void
	{
		var so:SharedObject = SharedObject.getLocal(name, '/');
		so.clear();
	}
}