import org.caleb.core.CoreObject;
import org.caleb.core.CoreInterface;

class org.caleb.components.menu.MenuInfo extends CoreObject implements CoreInterface
{
	public var targetClip:MovieClip;
	public var name:String;
	public var x:Number;
	public var y:Number;
	public var depth:Number;
	public var xml;
	
	function MenuInfo(targetClip:MovieClip, name:String, x:Number, y:Number, depth:Number, xml)
	{
		// the xml argument should be of type XML,
		// but for some reason it isn't working.
		// Thus, it is lazy typed
		this.targetClip = targetClip;
		this.name = name;
		this.x = x;
		this.y = y;
		this.depth = depth
		this.xml = xml;
	}
}