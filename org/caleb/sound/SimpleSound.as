/**
 * An abstract wrapper for the native Sound object.  Provides more verbose self descriptors.
 * 
 * @see     Sound	
 */
class org.caleb.sound.SimpleSound extends Sound
{
	private var $instanceDescription:String;
	private var $context:Object;
	
	public function SimpleSound(obj)
	{
		super(obj);
		this.setClassDescription('org.caleb.media.sound.SimpleSound');
	}

	/**
	 * Returns the class name registered with this.setClassDescription(className:String);
	 * 
	 * @return  String
	 */
	public function toString(Void):String{
		return this.$instanceDescription;
	}
	private function setClassDescription(d:String):Void{
		this.$instanceDescription = d;
	}
	public function get context():Object
	{
		return this.$context;
	}

	/**
	 * Mutator for private context var. 
	 * @param   arg (Object) the context Object to associate with this instance
	 */
	public function set context(arg:Object):Void
	{
		this.$context = arg;
	}

}
