import org.caleb.event.Event;
import org.caleb.core.CoreObject;
import org.caleb.util.ObjectUtil;

/**
 * 
 * @see     CoreObject	
 */
class org.caleb.event.EventObserver extends CoreObject{
	private var $listeningInstance:Object;
	private var $methodID:String;
	private var $messageName:String;

	/**
	 * 
	 * @param   listeningInstance 
	 * @param   messageName       
	 */
	public function EventObserver(listeningInstance:Object, messageName:String){
		super();
		this.setClassDescription('org.caleb.event.EventObserver');
		if(ObjectUtil.isTypeOf(listeningInstance, 'object') || ObjectUtil.isTypeOf(listeningInstance, 'movieclip')){
			this.setListeningInstance(listeningInstance);	
		}
		if(ObjectUtil.isTypeOf(messageName, 'string')){
			this.setMessageName(messageName);
		}
	}

	/**
	 * 
	 * @param   listeningInstance 
	 */
	public function setListeningInstance(listeningInstance:Object):Void{
		this.$listeningInstance = listeningInstance;
		// trace('[EventObserver] listeningInstance: '+listeningInstance)
	}

	/**
	 * 
	 * @param   methodName 
	 * @param   e          
	 */
	public function callMethod(methodName:String, e:org.caleb.event.Event):Void{
		this.$listeningInstance[methodName].apply(this.$listeningInstance, [e]);
	}

	public function getListeningInstance():Object{
		return this.$listeningInstance;
	}

	/**
	 * 
	 * @param   messageName 
	 */
	public function setMessageName(messageName:String):Void{
		this.$messageName = messageName;
	}

	public function getMessageName():String{
		return this.$messageName;
	}

	/**
	 * 
	 * @param   eventObj 
	 */
	public function handleEvent(eventObj:org.caleb.event.Event):Void{
		// trace('[EventObserver: handleEvent invoked]')
		this.$listeningInstance.handleEvent(eventObj);
	}
}