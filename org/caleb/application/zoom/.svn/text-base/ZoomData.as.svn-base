import org.caleb.core.CoreObject;
import org.caleb.application.zoom.ZoomController;

class org.caleb.application.zoom.ZoomData extends CoreObject
{
	private var $controller:ZoomController;
	private var $zoomOutPerc:Number;
	private var $zoomInPerc:Number;
	private var $tweenLen:Number;
	private var $easeInFunction:Object
	private var $easeOutFunction:Object;	
	private var $width:Number;
	private var $height:Number;	
	private var $launchX:Number;
	private var $launchY:Number;
	private var $outX:Number;
	private var $outY:Number;
	private var $zoomedIn:Boolean;
	private var $currentId:Number;
	private var $previousId:Number;
	private var $nextId:Number;
	private var $imageDimensions:Number;
	private var $frameWidth:Number;
	private var $columns:Number;
	private var $maxRows:Number;
	private var $initialScale:Number;
	private var $loadedImages:Array;
	
	public function ZoomData()
	{
		this.setClassDescription('org.caleb.application.zoom.ZoomData');
		//trace('constructor invoked');
		this.$loadedImages = new Array;
	}
	public function get loadedImages():Array
	{
		return this.$loadedImages;
	}
	public function set loadedImages(arg:Array)
	{
		this.$loadedImages = arg;
	}
	/**
	* Accessor for private $zoomOutPerc var.
	* @return Number.
	**/
	public function get zoomOutPerc():Number
	{
		return this.$zoomOutPerc;
	}
	/**
	* Mutator for private $zoomOutPerc var.
	* @param arg Number
	**/
	public function set zoomOutPerc(arg:Number) 
	{
		this.$zoomOutPerc = arg;
	}
	/**
	* Accessor for private $zoomInPerc var.
	* @return Number.
	**/
	public function get zoomInPerc():Number
	{
		return this.$zoomInPerc;
	}
	/**
	* Mutator for private $zoomInPerc var.
	* @param arg Number
	**/
	public function set zoomInPerc(arg:Number) 
	{
		this.$zoomInPerc = arg;
	}
	/**
	* Accessor for private $tweenLen var.
	* @return Number.
	**/
	public function get tweenLen():Number
	{
		return this.$tweenLen;
	}
	/**
	* Mutator for private $tweenLen var.
	* @param arg Number
	**/
	public function set tweenLen(arg:Number) 
	{
		this.$tweenLen = arg;
	}
	/**
	* Accessor for private $easeOutFunction var.
	* @return Object.
	**/
	public function get easeOutFunction():Object
	{
		return this.$easeOutFunction;
	}
	/**
	* Mutator for private $easeOutFunction var.
	* @param arg Object
	**/
	public function set easeOutFunction(arg:Object) 
	{
		this.$easeOutFunction = arg;
	}
	/**
	* Accessor for private $easeInFunction var.
	* @return Object.
	**/
	public function get easeInFunction():Object
	{
		return this.$easeInFunction;
	}
	/**
	* Mutator for private $easeInFunction var.
	* @param arg Object
	**/
	public function set easeInFunction(arg:Object) 
	{
		this.$easeInFunction = arg;
	}
	/**
	* Accessor for private $width var.
	* @return Number.
	**/
	public function get width():Number
	{
		return this.$width;
	}
	/**
	* Mutator for private $width var.
	* @param arg Number
	**/
	public function set width(arg:Number) 
	{
		this.$width = arg;
	}
	/**
	* Accessor for private $height var.
	* @return Number.
	**/
	public function get height():Number
	{
		return this.$height;
	}
	/**
	* Mutator for private $height var.
	* @param arg Number
	**/
	public function set height(arg:Number) 
	{
		this.$height = arg;
	}
	/**
	* Accessor for private $outX var.
	* @return Number.
	**/
	public function get outX():Number
	{
		return this.$outX;
	}
	/**
	* Mutator for private $outX var.
	* @param arg Number
	**/
	public function set outX(arg:Number) 
	{
		this.$outX = arg;
	}
	/**
	* Accessor for private $outY var.
	* @return Number.
	**/
	public function get outY():Number
	{
		return this.$outY;
	}
	/**
	* Mutator for private $outY var.
	* @param arg Number
	**/
	public function set outY(arg:Number) 
	{
		this.$outY = arg;
	}
	/**
	* Accessor for private $zoomedIn var.
	* @return Boolean.
	**/
	public function get zoomedIn():Boolean
	{
		return this.$zoomedIn;
	}
	/**
	* Mutator for private $zoomedIn var.
	* @param arg Boolean
	**/
	public function set zoomedIn(arg:Boolean) 
	{
		this.$zoomedIn = arg;
	}
	/**
	 * 
	 * @usage   
	 * @param   n 
	 * @return  
	 */
	public function set currentId(n:Number):Void
	{
		// trace('SET CURRENT ID INVOKED w/ id: ' + n);
		if(this.$currentId != n && n != undefined && isNaN(n) == false)
		{
			//trace('CURRENT ID BEING SET TO: ' + n);
			//trace('this.$currentId: ' + this.$currentId)
			//trace('this.$previousId: ' + this.$previousId)
			this.$previousId = this.$currentId;
			this.$currentId = n;
			this.$nextId = ((n + 1) > this.$controller.view.items.length) ? (n + 1) : 0;
		}
		else if(this.$currentId == n)
		{
			//trace('REDUNDANT ID PASSED TO SET CURRENT ID')
		}
		else if(this.$currentId == undefined)
		{
			//trace('UNDEFINED ID PASSED TO SET CURRENT ID')
		}
		else if(isNaN(n))
		{
			//trace('NaN PASSED TO SET CURRENT ID')
		}
		else
		{
			//trace('UNKNOWN CONDITION PASSED TO SET CURRENT ID')
		}
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get currentId():Number
	{
		//trace('GET CURRENT ID INVOKED w/ id: ' + this.$currentId);
		return this.$currentId;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get previousId():Number
	{
		return this.$previousId;
	}
	public function get nextId():Number
	{
		return this.$nextId;
	}
	/**
	* Accessor for private $imageDimensions var.
	* @return Number.
	**/	
	public function get imageDimensions():Number
	{
		return this.$imageDimensions;
	}
	/**
	* Mutator for private $imageDimensions var.
	* @param arg Number
	**/	
	public function set imageDimensions(arg:Number) 
	{
		this.$imageDimensions = arg;
	}
	/**
	* Accessor for private $frameWidth var.
	* @return Number.
	**/
	public function get frameWidth():Number
	{
		return this.$frameWidth;
	}
	/**
	* Mutator for private $frameWidth var.
	* @param arg Number
	**/
	public function set frameWidth(arg:Number) 
	{
		this.$frameWidth = arg;
	}
	/**
	* Accessor for private $columns var.
	* @return Number.
	**/
	public function get columns():Number
	{
		return this.$columns;
	}
	/**
	* Mutator for private $columns var.
	* @param arg Number
	**/
	public function set columns(arg:Number) 
	{
		this.$columns = arg;
	}
	public function get maxRows():Number
	{
		return this.$maxRows;
	}
	public function set maxRows(arg:Number) 
	{
		this.$maxRows = arg;
	}
	public function get launchX():Number
	{
		return this.$launchX;
	}
	public function set launchX(arg:Number) 
	{
		this.$launchX = arg;
	}
	public function get launchY():Number
	{
		return this.$launchY;
	}
	public function set launchY(arg:Number) 
	{
		this.$launchY = arg;
	}
	public function get initialScale():Number
	{
		return this.$initialScale;
	}
	public function set initialScale(arg:Number):Void
	{
		this.$initialScale = arg;
	}
	public function get controller():ZoomController
	{
		return this.$controller;
	}
}