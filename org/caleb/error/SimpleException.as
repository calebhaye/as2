/**
 * 
 * @see     Error	
 */
class org.caleb.error.SimpleException extends Error{
	private var $instanceDescription:String;
	public function SimpleException(){
		super('Error: Exception org.caleb.error.SimpleException thrown.');
		this.setClassDescription('org.caleb.error.SimpleException');
	}
	public function toString(Void):String{
		return this.$instanceDescription;
	}
	private function setClassDescription(d:String):Void{
		this.$instanceDescription = d;
	}
}
