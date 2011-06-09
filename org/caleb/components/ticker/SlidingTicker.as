import org.caleb.movieclip.CoreMovieClip;
import org.caleb.components.ticker.SlidingTickerItem;

class org.caleb.components.ticker.SlidingTicker extends CoreMovieClip
{
	// mask
	public static var MASK_ID:String = 'slidingTickerMask_';
	private var $mask:MovieClip;
	private var $maskWidth:Number;
	private var $maskHeight:Number;
	// 
	private var $data:Array;
	private var $items:Array;
	private var $isHTML:Boolean;
	private var $activeTween:Object;
	
	public function SlidingTicker()
	{
		this.setClassDescription('org.caleb.components.ticker.SlidingTicker');
		this.$items = new Array;
		this.setViewArea(500, 100);
		this.$isHTML = true;
	}
	public function setupData():Void
	{
		var tempLength = this.$items.length;
		var i = 0;
		while(tempLength--)
		{
			this.$items[i].data = this.$data[i];
			i++;
		}
	}
	public function setupIndices():Void
	{
		var tempLength = this.$items.length;
		var i = 0;
		while(tempLength--)
		{
			var tickerItem:SlidingTickerItem = this.$items[i];
			// current index
			// tickerItem._alpha = 25;
			tickerItem.index = i;
			// next index
			if((i + 1) < this.$data.length)
			{
				tickerItem.nextIndex = i + 1;
			}
			else
			{
				tickerItem.nextIndex = 0;
			}
			// prev index
			if((i - 1) < 0)
			{
				tickerItem.previousIndex = tempLength - 1;
			}
			else
			{
				tickerItem.previousIndex = i - 1;
			}
			i++;
		}
	}
	public function positionItems():Void
	{
		var tempLength = this.$items.length;
		var i = 0;
		while(tempLength--)
		{
			this.$items[i].gotoInitialPosition();
			i++;
		}
		// start the first item
		// it will start the next item, and so on
		this.$items[0].start();
	}
	private function attachItems():Void
	{
		var tempLength = this.$data.length;
		var i = 0;
		while(tempLength--)
		{
			// attach item
			var tickerItem:SlidingTickerItem = SlidingTickerItem(this.attachMovie('tickerDataItem', 'tickerDataItem' + i, this.getNextHighestDepth()));
			// pass in ref to this
			tickerItem.ticker = this;
			// add to local collection
			this.$items.push(tickerItem);
			i++;
		}
	}
	private function drawMask(w:Number, h:Number):Void
	{
		this.$maskHeight = h;
		this.$maskWidth = w;
		// find target
		var maskTarget:MovieClip = this._parent;
		var maskId:String = SlidingTicker.MASK_ID + this._name
		// destroy
		if(maskTarget[maskId] != undefined)
		{
			maskTarget[maskId].removeMovieClip();
		}
		// build
		this.$mask = maskTarget.createEmptyMovieClip(maskId, maskTarget.getNextHighestDepth());
		// position
		this._parent[maskId]._y = _parent[this._name]._y;
		this.$mask._x = this._x;
		//this.$mask._x = maskTarget[this._name]._x;
		// color 
		this.$mask.lineStyle(.25, 0x999999, 100);
		// size/fill
		this.$mask.beginFill(0x666666, 100);
		this.$mask.lineTo(this.$maskWidth, 0);
		this.$mask.lineTo(this.$maskWidth, this.$maskHeight);
		this.$mask.lineTo(0, this.$maskHeight);
		this.$mask.lineTo(0, 0);
		this.$mask.endFill();
		
		// make mask
		this.$mask._alpha = 20; 
		//this.setMask(this.$mask);
	}
	// public event(s)
	public function restart():Void
	{
		this.data = this.$data;
	}
	public function onComplete():Void
	{
		//trace('onComplete invoked');
	}
	public function onLastItemShown():Void
	{
		//trace('onLastItemShown invoked');
	}
	// public view methods
	public function setViewArea(w:Number, h:Number)
	{
		this.drawMask(w, h);
	}
	// mutators
	public function set data(d:Array):Void
	{
		this.$data = d;
		this.attachItems();
		this.setupIndices();
		this.setupData();
		this.positionItems();
	}
	public function set activeTween(tween:Object):Void
	{
		this.$activeTween = tween;
	}
	// accessors
	public function get items():Array
	{
		return this.$items;
	}
	public function get isHTML():Boolean
	{
		return this.$isHTML;
	}
	public function get mask():MovieClip
	{
		return this.$mask;
		//return this.$mask;
	}
	public function get activeTween():Object
	{
		return this.$activeTween;
		//return this.$mask;
	}
}