import mx.remoting.*;
import mx.rpc.*;
import mx.remoting.debug.NetDebug;
import org.caleb.core.CoreObject;

/**
 * This class is an abstraction layer for working w/ Macromedia's mx.remoting.* package.  It caches services so that subsequent remote calls to get the service are not required.
 * 
 * @see     CoreObject	
 * @throws onStatus()
 */
class org.caleb.remoting.RemotingManager extends CoreObject
{
	private var $initialized:Boolean = false;
	private var $gateway:String;
	private var $conn:NetConnection;
	private var $serviceCollection:Array;
	
	/**
	 * 
	 * @param   gateway (String) URL of the  gateway
	 */
	public function RemotingManager(gateway:String)
	{
		this.setClassDescription('org.caleb.remoting.RemotingManager');
		this.$serviceCollection = new Array;
		this.$gateway = gateway;
		NetDebug.initialize();
		this.$conn = NetServices.createGatewayConnection(gateway);
	}
	
	/**
	 * 
	 * @param   servicePath (String) path of the service to load
	 */
	public function addService(servicePath:String):Void
	{
		this.$serviceCollection[servicePath] = this.$conn.getService(servicePath);		
	}
	
	/**
	 * Returns a reference to service in cache
	 * 
	 * @param   servicePath (String)
	 * @return  Object
	 */
	public function getService(servicePath:String):Object
	{
		return this.$serviceCollection[servicePath];
	}
	
	/**
	 * This base implementation of onStatus simply outputs the details of the error thrown to the output window
	 * 
	 * @param   error (Object)
	 */
	public function onStatus(error)
	{
		for(var i in error)
		{
			trace('key: ' + i + ', value: ' + error[i]);
		}
	}
}