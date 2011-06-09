import org.caleb.core.CoreInterface;
import org.caleb.util.ObjectUtil;
import org.caleb.core.CoreObject;

/**
 * 
 * @see     Error	
 * @see     CoreInterface	
 */
class org.caleb.error.SimpleError extends Error implements CoreInterface{

	private var $instanceDescription:String;
	public function SimpleError(Void){
		this.setClassDescription('org.caleb.error.SimpleError');
	}
	public function toString(Void):String{
		return this.$instanceDescription;
	}
	private function setClassDescription(d:String):Void{
		this.$instanceDescription = d;
	}
}
