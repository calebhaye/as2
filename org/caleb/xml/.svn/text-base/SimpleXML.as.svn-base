import org.caleb.core.CoreInterface;
import org.caleb.util.ObjectUtil;
import org.caleb.xml.XMLObject;
import org.caleb.event.Event;
import org.caleb.event.EventDispatcher;
import org.caleb.event.Observable;
import org.caleb.Configuration;

/**
 * SimpleXML is a wrapper of Macromedia's native XML object. It provides a layer of abstraction and simplifies handling events associated with handling xml data.
 * @throws onLoadFailure
 * @throws onParseFailure
 * @see     XML	
 */
class org.caleb.xml.SimpleXML extends XML implements Observable
{
	private var $context:Object;
	private var $instanceDescription:String;

	private var $timeLimit:Number;
	private var $loadCheckInterval:Number;
	private var $retries:Number;
	private var $filePath:String;
	private var $loadAttempts:Number;
	private var $eventDispatcher:EventDispatcher;

	public function SimpleXML()
	{
		if(arguments[0] == undefined)
		{
			super();
		}
		else
		{
			super(arguments[0]);
		}
		this.$loadAttempts = 0;
		this.ignoreWhite = true;
		this.$timeLimit = 1000;
		this.$retries = 2;
		this.setClassDescription('org.caleb.xml.SimpleXML');
		this.$eventDispatcher = new EventDispatcher();
	}

	private function setClassDescription(d:String):Void
	{
		if(org.caleb.util.ObjectUtil.isExplicitInstanceOf(this, eval(d)) == false)
		{
			d = 'subclass of ' + d;
		}
		this.$instanceDescription = d;
	}

	/**
	 * accessor for private context var. 
	 * @return  the context Object associated with this instance
	 */
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

	/**
	 * Load method. Overloads the XML super class load.
	 * @param   file (String) the url of the file to load
	 */
	public function load(file:String):Void
	{
		if(arguments[1] != undefined)
		{
			this.addEventObserver(arguments[1], 'onParseSuccess');
			this.addEventObserver(arguments[1], 'onParseFailure');
			this.addEventObserver(arguments[1], 'onLoadSuccess');
			this.addEventObserver(arguments[1], 'onLoadFailure');
		}
		if(ObjectUtil.isTypeOf(file, 'string') == false || ObjectUtil.isEmpty(file))
		{
			var args:Array = new Array;
			args['SimpleXML'] = this;
			var e = new Event('onLoadFailure', args );
			this.dispatchEvent(e);

			return;
		}
		this.$filePath = file;
		this.$loadAttempts++
		super.load(file);
	}

	/**
	 * Default load handler implementation.  If the load was successful, this method will invoke onLoadSuccess().  If the load failed, this method will invoke retryLoad() (which upon reaching the specified number of failures will throw an onLoadError event)
	 * @param   success (Boolean) Indicates whether or not the load was successful
	 * @see onLoadSuccess()
	 * @see retryLoad()
	 * @see onLoadFailure()
	 */
	public function onLoad(success:Boolean):Void
	{
		trace('Onload called for: ' + this.$filePath);
		this.addEventObserver(this, 'onParseSuccess');
		this.addEventObserver(this, 'onLoadSuccess');
		this.addEventObserver(this, 'onLoadFailure');
		_root.debug.text += 'Onload called for: ' + this.$filePath + "w/ success: "+success+"\n";
		if(!success)
		{
			this.retryLoad();
		}
		else
		{
			var args:Array = new Array;
			args['SimpleXML'] = this;
			var e = new Event('onLoadSuccess', args );
			this.dispatchEvent(e);
		}
	}

	private function startLoadCheck(Void):Void
	{
		clearInterval(this.$loadCheckInterval);
		this.$loadCheckInterval = setInterval(this, 'retryLoad', this.$timeLimit);
	}

	private function retryLoad(Void):Void
	{
		trace('retryLoad called.');
		trace(this.$loadAttempts+' >= '+this.$retries);
		if(this.$loadAttempts >= this.$retries)
		{
			trace('All out of retries...');
			_root.debug.text += "\nAll out of retries...";
			this.$loadAttempts = 0;

			var args:Array = new Array;
			args['SimpleXML'] = this;
			var e = new Event('onLoadFailure', args );
			this.dispatchEvent(e);

			return;
		}
		this.startLoadCheck();
		this.load(this.$filePath);
	}

	/**
	 * accessor for private $filePath var. 
	 * @return  Number
	 */
	public function get filePath():String
	{
		return this.$filePath;
	}
	/**
	 * accessor for private $timeLimit var. 
	 * @return  Number
	 */
	public function get timeLimit():Number
	{
		return this.$timeLimit;
	}
	public function get loadAttempts():Number
	{
		return this.$loadAttempts;
	}
	/**
	 * mutator for private $timeLimit var. 
	 * @param   arg (Number) value of new time limit
	 */
	public function set timeLimit(arg:Number):Void
	{
		this.$timeLimit = arg;
	}
	/**
	 * accessor for private $retries var. 
	 * @return  Number
	 */
	public function get retries():Number
	{
		return this.$retries;
	}
	/**
	 * mutator for private $retries var. 
	 * @param   arg (Number) a number representing the number of load attempts that should be performed
	 */
	public function set retries(arg:Number):Void
	{
		this.$retries = arg;
	}


	private function onLoadSuccess():Void
	{
		this.parse();
	}

	private function onLoadFailure():Void
	{
		clearInterval(this.$loadCheckInterval);
	}

	/**
	 * This method is invoked once the XML file has been loaded and successfully parsed
	 * overload this in the subclasses
	 */
	public function onParseSuccess():Void
	{
	}

	/**
	 * This method is invoked if the XML file has been loaded and was unable to successfully parse
	 * overload this in the subclasses
	 */
	public function onParseFailure():Void
	{
	}

	private function parse():Void
	{
		var args:Array = new Array;
		args['SimpleXML'] = this;
		var e = new Event('onParseSuccess', args );
		this.dispatchEvent(e);
	}
	/**
	 * @return an object of type Object representing this XML instance
	 * @see org.caleb.xml.XMLObject#parseXML()
	 */
	public function toObject():Object
	{
		var x:XMLObject = new XMLObject()

		return x.parseXML(this, arguments[0]);
	}
	/**
	 * @return  a Number representing the interval responsible for polling the status of the file load
	 */
	public function get loadCheckInterval():Number
	{
		return this.$loadCheckInterval;
	}
	/**
	 * conform to the Observable interface	 and delegate calls to this.$eventDispatcher
	 * @param   observerObject (Object) reference to listening object 
	 * @param   eventToObserve (String) name of the event you are listening too.  This is also the name of the method that is invoked on the listening object when the event is dispatched
	 */
	public function addEventObserver(observerObject, eventToObserve:String):Void
	{
		this.$eventDispatcher.addEventObserver(observerObject, eventToObserve);
		if(arguments.length > 2)
		{
			for(var i = 2; i < arguments.length; i++)
			{
				this.$eventDispatcher.addEventObserver(observerObject, arguments[i]);
			}
		}
	}
	/**
	 * conform to the Observable interface	 and delegate calls to this.$eventDispatcher
	 */
	public function removeAllEventObservers():Void
	{
		this.$eventDispatcher.removeAllEventObservers();
	}
	/**
	 * conform to the Observable interface	 and delegate calls to this.$eventDispatcher
	 * @param   observerObject (Object) reference to object to remove from listeners list
	 * @param   eventToObserve (String) name of the event to stop listening to
	 */
	public function removeEventObserver(observerObject, eventToObserve:String):Void
	{
		this.$eventDispatcher.removeEventObserver(observerObject, eventToObserve);
	}

	/**
	 * private dispatch method. delegates to this.$eventDispatcher
	 * @param   e (org.caleb.event.Event) event to dispatch
	 * @see org.caleb.event.Event
	 */
	private function dispatchEvent(e:org.caleb.event.Event):Void
	{
		this.$eventDispatcher.dispatchEvent(e, this);
	}
	public function toString(Void):String
	{
		return super.toString();
	}
}