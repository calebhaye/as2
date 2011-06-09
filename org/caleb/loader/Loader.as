import org.caleb.core.CoreObject;
import org.caleb.loader.LoaderView;
import org.caleb.event.ObservableObject;
import org.caleb.util.ObjectUtil;
import org.caleb.event.Event;
import org.caleb.event.EventDispatcher;

/**
 * 
 * @see     ObservableObject	
 */
class org.caleb.loader.Loader extends ObservableObject{
	private var $target:MovieClip;
	private var $views:Array;
	private var $timeLimit:Number;
	private var $loadCheckInterval:Number;
	private var $retries:Number;
	private var $frequency:Number;

	private var $previousBytesLoaded:Number;
	private var $previousTime:Number;
	private var $filePath:String;
	private var $loadAttempts:Number;

	public function Loader(Void){
		super();
		this.setClassDescription('org.caleb.loader.Loader');
		this.$views = new Array();
		this.$eventDispatcher = new EventDispatcher();
		this.setTimeLimit(1000);
		this.setRetries(2);
		this.setFrequency(80);
		this.reset();
	}

	private function reset(Void):Void{
		this.$filePath = '';
		this.$loadAttempts = 0;
	}

	//	accessor for private $target var. 
	//	@returns MovieClip.
	public function getTarget():MovieClip{
		return this.$target;
	}
	//	mutator for private $target var. 
	//	@argument arg MovieClip
	/**
	 * 
	 * @param   arg 
	 */
	public function setTarget(arg:MovieClip):Void{
		this.$target = arg;
	}
	//	accessor for private $views var. 
	//	@returns Array.
	public function getViews():Array{
		return this.$views;
	}
	//	mutator for private $views var. 
	//	@argument arg Array
	/**
	 * 
	 * @param   arg 
	 */
	public function setViews(arg:Array):Void{
		this.$views = arg;
	}

	/**
	 * 
	 * @param   view 
	 */
	public function addView(view:LoaderView):Void{
		this.$views.push(view);
		this.addEventObserver(view, 'LoaderDidChange');
		this.addEventObserver(view, 'LoaderDidComplete');
		this.addEventObserver(view, 'LoaderDidFail');
	}

	//	accessor for private $frequency var. 
	//	@returns Number.
	public function getFrequency():Number{
		return this.$frequency;
	}
	//	mutator for private $frequency var. 
	//	@argument arg Number
	/**
	 * 
	 * @param   arg 
	 */
	public function setFrequency(arg:Number):Void{
		this.$frequency = arg;
	}

	//	accessor for private $timeLimit var. 
	//	@returns Number.
	public function getTimeLimit():Number{
		return this.$timeLimit;
	}
	//	mutator for private $timeLimit var. 
	//	@argument arg Number
	/**
	 * 
	 * @param   arg 
	 */
	public function setTimeLimit(arg:Number):Void{
		this.$timeLimit = arg;
	}
	//	accessor for private $retries var. 
	//	@returns Number.
	public function getRetries():Number{
		return this.$retries;
	}
	//	mutator for private $retries var. 
	//	@argument arg Number
	/**
	 * 
	 * @param   arg 
	 */
	public function setRetries(arg:Number):Void{
		this.$retries = arg;
	}

	public function checkLoad(Void):Void{
		var bl = this.$target.getBytesLoaded();
		var bt = this.$target.getBytesTotal();
		if(bl < 100 || this.$previousBytesLoaded == bl){
			var test = getTimer();
			if((test-this.$previousTime) > this.$timeLimit){
				this.retryLoad();
			}
			return;
		}
		if(bl >= bt){
			this.loadChange(bl, bt);
			this.loadComplete(bl, bt);
		}else{
			this.loadChange(bl, bt);
		}
	}

	private function loadFailed(Void):Void{
		clearInterval(this.$loadCheckInterval);
		var e = new org.caleb.event.Event('LoaderDidFail');
		e.addArgument('filepath', this.$filePath);
		this.dispatchEvent(e);
		this.reset();
	}

	private function loadComplete(bl:Number, bt:Number):Void{
		clearInterval(this.$loadCheckInterval);
		var e = new org.caleb.event.Event('LoaderDidComplete');
		e.addArgument('bl', bl);
		e.addArgument('bt', bt);
		e.addArgument('filepath', this.$filePath);
		this.dispatchEvent(e);
		this.reset();
	}

	private function loadChange(bl:Number, bt:Number):Void{
		var e = new org.caleb.event.Event('LoaderDidChange');
		e.addArgument('bl', bl);
		e.addArgument('bt', bt);
		e.addArgument('filepath', this.$filePath);
		this.dispatchEvent(e);
	}

	private function startLoadCheck(Void):Void{
		clearInterval(this.$loadCheckInterval);
		this.$previousBytesLoaded = -1;
		this.$previousTime = getTimer();
		this.$loadCheckInterval = setInterval(this, 'checkLoad', this.getFrequency());
	}

	private function retryLoad(Void):Void{
		if(++this.$loadAttempts >= this.$retries){
			this.loadFailed();
			return;
		}
		if(ObjectUtil.isTypeOf(this.$target, 'movieclip') == false || ObjectUtil.isEmpty(this.$filePath)){
			return;
		}
		this.startLoadCheck();
		this.$target.loadMovie(this.$filePath);
	}

	/**
	 * 
	 * @param   filePath 
	 */
	public function load(filePath:String):Void{
		if(ObjectUtil.isTypeOf(this.$target, 'movieclip') == false || ObjectUtil.isEmpty(filePath)){
			return;
		}
		this.$previousBytesLoaded = 0;
		this.$filePath = filePath;
		this.$loadAttempts = 0;
		this.startLoadCheck();
		this.$target.loadMovie(filePath);
	}
}
