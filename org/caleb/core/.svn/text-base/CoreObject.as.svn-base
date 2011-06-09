import org.caleb.core.CoreInterface;
import org.caleb.util.ObjectUtil;
import org.caleb.Configuration;
/**
 * 
 * @see     CoreInterface	
 */

class org.caleb.core.CoreObject implements CoreInterface
{
	private var $instanceDescription:String;
	/*
	* Sole Constructor
	*/
	public function CoreObject(Void)
	{
		this.setClassDescription('org.caleb.core.CoreObject');
	}
	/**
	 * Returns a reference to internal $instanceDescription var
	 */
	public function toString(Void):String{
		return this.$instanceDescription;
	}
	private function setClassDescription(d:String):Void
	{
		if(org.caleb.util.ObjectUtil.isExplicitInstanceOf(this, eval(d)) == false)
		{
			d = 'subclass of ' + d;
		}
		this.$instanceDescription = d;
	}
	public function get classType():String
	{
		return this.$instanceDescription.toString().substring(this.$instanceDescription.toString().lastIndexOf('.') + 1);
	}
}
