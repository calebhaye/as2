import org.caleb.core.CoreObject;
import org.caleb.event.ObservableObject;
import org.caleb.util.ObjectUtil;
import org.caleb.event.Event;
import org.caleb.event.EventDispatcher;

/**
 * This class provides basic timing capability.  Use Macromedia's Timer for Flash 8+
 * 
 * @see     ObservableObject	
 */
class org.caleb.timer.Timer extends ObservableObject
{
	private var $frequency:Number;
	private var $timeLimit:Number;
	private var $interval:Number;
	private var $repetitions:Number;

	private var $repetitionsCompleted:Number;

	private var $target:Object;
	private var $action:Function;
	private var $arguments:Array;

	public function Timer()
	{
		super();
		this.setClassDescription('org.caleb.timer.Timer');
		this.$timeLimit = 1000;
		this.$repetitions = 0;
		this.$frequency = 80;
		this.reset();
	}

	public function reset(Void):Void
	{
		trace('reset invoked');
		this.$repetitionsCompleted = 0;
	}

	//	accessor for private $interval var. 
	//	@return Number.
	public function get interval():Number{
		return this.$interval;
	}
	//	accessor for private $repetitionsCompleted var. 
	//	@return Number.
	public function get repetitionsCompleted():Number{
		return this.$repetitionsCompleted;
	}
	//	mutator for private $repetitionsCompleted var. 
	//	@argument arg Number
	/**
	 * 
	 * @param   arg 
	 */
	public function set repetitionsCompleted(arg:Number):Void{
		this.$repetitionsCompleted = arg;
	}
	//	accessor for private $frequency var. 
	//	@return Number.
	public function get frequency():Number{
		return this.$frequency;
	}
	//	mutator for private $frequency var. 
	//	@argument arg Number
	/**
	 * 
	 * @param   arg 
	 */
	public function set frequency(arg:Number):Void{
		this.$frequency = arg;
	}

	//	accessor for private $timeLimit var. 
	//	@return Number.
	public function get timeLimit():Number{
		return this.$timeLimit;
	}
	//	mutator for private $timeLimit var. 
	//	@argument arg Number
	/**
	 * 
	 * @param   arg 
	 */
	public function set timeLimit(arg:Number):Void{
		this.$timeLimit = arg;
	}

	//	accessor for private $repetitions var. 
	//	@return Number.
	public function get repetitions():Number{
		return this.$repetitions;
	}
	//	mutator for private $repetitions var. 
	//	@argument arg Number
	/**
	 * 
	 * @param   arg 
	 */
	public function set repetitions(arg:Number):Void{
		this.$repetitions = arg;
	}

	/**
	 * 
	 * @param   a 
	 */
	public function set action(a:Function):Void
	{
		this.$action = a;
	}
	/**
	 * 
	 * @param   t 
	 */
	public function set target(t:Object):Void
	{
		this.$target = t;
	}
	/**
	 * 
	 * @param   a 
	 */
	public function set arguments(a:Array):Void
	{
		this.$arguments = a;
	}

	public function start(Void):Void{
//	test target, action, arguments and set the interval accordingly.
		clearInterval(this.$interval);
		this.$interval = setInterval(this.$target, this.$action, this.$arguments);
	}
	public function stop(Void):Void{
		this.reset();
	}

	/**
	 * 
	 * @param   obj        
	 * @param   methodName 
	 * @param   seconds    
	 * @param   args       
	 */
	public function setTimeout(obj:Object, methodName:String, seconds:Number, args:Array):Void
	{
		trace('setTimeout invoked')
		this.$interval = setInterval(this.setTimeoutCountdown, 1000, obj, methodName, seconds, args, this);
	}
	/**
	 * 
	 * @param   obj        
	 * @param   methodName 
	 * @param   seconds    
	 * @param   args       
	 * @param   timer      
	 */
	public function setTimeoutCountdown(obj:Object, methodName:String, seconds:Number, args:Array, timer:Timer):Void
	{
		// trace('setTimeoutCountdown invoked')
		if(timer.repetitionsCompleted < 0)
		{
			timer.repetitionsCompleted = 0;
		}
		// trace(methodName + ' setTimeoutCountdown invoked: repetitionsCompleted = ' + timer.repetitionsCompleted);
		// trace('seconds: ' + seconds)
		if(timer.repetitionsCompleted >= seconds)
		{
			obj[methodName].apply(obj, args);
			clearInterval(timer.interval);
			delete timer;
		}
		timer.repetitionsCompleted++;
	}
}
