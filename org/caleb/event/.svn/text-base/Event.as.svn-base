import org.caleb.core.CoreObject;

/**
 * The root class from which all event state objects shall be derived.
 * 
 * @version 1.0
 * @see     CoreObject	
 * 
 */
class org.caleb.event.Event extends CoreObject{
	private var $type:String;
	private var $sender:Object;
	private var $arguments:Object;

	//	mod this to use the ObjectUtil instead of typeof
	public function Event(type:String, args:Object){
		super();
		this.setClassDescription('org.caleb.event.Event');
		this.$arguments = new Object();
		if(typeof type == "string"){
			this.setType(type);
			if(typeof args == "object"){
				this.setArguments(args);
			}
		}
	}

	/**
	 * 
	 * @param   t 
	 */
	public function setType(t:String):Void{
		this.$type = t;
	}

	public function getType():String{
		return this.$type;
	}

	/**
	 * 
	 * @param   s 
	 */
	public function setSender(s:Object):Void{
		this.$sender = s;
	}

	public function getSender():Object{
		return this.$sender;
	}

	/**
	 * 
	 * @param   a 
	 */
	public function setArguments(a:Object):Void{
		this.$arguments = a;
	}

	public function getArguments():Object{
		return this.$arguments;
	}

	/**
	 * 
	 * @param   id  
	 * @param   val 
	 */
	public function addArgument(id:String, val:Object):Void{
		/*
		trace('this.$arguments: '+this.$arguments);
		trace('id: '+id)
		trace('val: '+val)
		*/
		this.$arguments[id] = val;
	}

	/**
	 * 
	 * @param   id 
	 */
	public function getArgumentById(id:String):Object{
		return this.$arguments[id];
	}

	/**
	 * 
	 * @param   key 
	 */
	public function getArgumentByKey(key:String):Object{
		return this.$arguments[key];
	}

	/**
	 * 
	 * @param   name 
	 */
	public function getArgumentByName(name:String):Object{
		return this.$arguments[name];
	}

	/**
	 * 
	 * @param   key 
	 */
	public function getArgument(key:String):Object{
		return this.$arguments[key];
	}
}
