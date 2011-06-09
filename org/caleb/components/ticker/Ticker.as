import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.collection.AbstractList
import org.caleb.components.ticker.TickerDisplayData;

/**
 * 
 * @author  calebh
 * @version 1.0
 * @see     ObservableMovieClip	
 * @since   
 * @id		$Id: Ticker.as,v 1.1.2.1 2005/12/09 18:55:23 calebh Exp $
 */
class org.caleb.components.ticker.Ticker extends ObservableMovieClip
{
	public static var MASK_ID:String = 'tickerMask_';
	public var tempText:String;
	public var tempIconUrl:String;
	public var tempTitle:String;
	private var $operand:Array;
	private var $currentElement:MovieClip;
	private var $icon:MovieClip;
	private var $mask:MovieClip;
	private var $maskWidth:Number;
	private var $maskHeight:Number;
	private var $tickInterval:Number;
	private var $operandIndex:Number;
	private var $displayIndex:Number;
	private var $displaySeconds:Number;
	private var visibleText:String;
	// 
	private var $started:Boolean;
	private var $ticking:Boolean;
	// assets assumed to be present in fla
	private var display:TextField;
	private var titleDisplay:TextField;
	
	public function Ticker()
	{
		this.setClassDescription('org.caleb.components.ticker.Ticker');
		trace('constructor invoked');
		//
		this.$icon = this.createEmptyMovieClip(this._name + '_TickerImageContainer', this.getNextHighestDepth());
		this.$icon._x = 10;
		//
		this.$ticking = true;
		this.$operandIndex = 0;
		this.$displayIndex = 0;
		this.$displaySeconds = 5;
		//
		this.visibleText= '';
		this.display.wordWrap = false;
		this.display.selectable = false;
		this.$operand = new Array();
	}
	/*
	public function onRollOver()
	{
		this.pause();
	}
	public function onRollOut()
	{
		this.resume();
	}
	*/
	// private methods
	private function drawMask(w:Number, h:Number):Void
	{
		this.$maskHeight = h;
		this.$maskWidth = w;
		// find target
		var maskTarget:MovieClip = this._parent;
		var maskId:String = Ticker.MASK_ID + this._name
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
		this.setMask(this.$mask);
	}
	// public view methods
	public function setViewArea(w:Number, h:Number)
	{
		this.drawMask(w, h);
	}
	public function hide()
	{
		this.pause();
		this._visible = false;
	}
	public function show()
	{
		this.resume();
		this._visible = true;
	}
	// public control methods
	public function tick(ticker:Ticker)
	{
		trace('tick')
		if(ticker.ticking == true)
		{
			if(ticker.started)
			{
				ticker.next();
			}
			else
			{
				ticker.start();
			}
		}
	}
	public function start()
	{
		this.$started = true;
		// tween out
		this.transitionOutUpdate(this.$operand[this.$operandIndex]);
	}
	public function next()
	{
		if(this.$displayIndex >= this.$operand[this.$operandIndex].displayItems.length -1)
		{
			this.$displayIndex = 0;
			if(this.$operandIndex >= this.$operand.length -1)
			{
				this.$operandIndex = 0;
			}
			else
			{
				this.$operandIndex++;
			}			
		}
		else
		{
			this.$displayIndex++;
		}
		// tween out
		this.transitionOutUpdate(this.$operand[this.$operandIndex]);
	}
	public function transitionOutUpdate(displayData:TickerDisplayData):Void
	{
		trace('displayData.displayItems: ' +displayData.displayItems)
		this.tempText = displayData.displayItems[this.$displayIndex];
		this.tempIconUrl = displayData.displayIcons[this.$displayIndex];
		this.tempTitle = displayData.displayTitles[this.$displayIndex];
		var ease  = mx.transitions.easing.Strong.easeIn;
		var begin = 80;
		var end   = 0;
		var time  = .4;
		var tween = new mx.transitions.Tween(this.display, "_alpha", ease, begin, end, time, true);
		var tween2 = new mx.transitions.Tween(this.icon, "_alpha", ease, begin, end, time, true);
		tween.content = this;
		tween.onMotionFinished = function(obj)
		{
			obj.content.iconUrl = obj.content.tempIconUrl;
			if(obj.content.tempTitle != undefined)
			{
				obj.content.visibleText = obj.content.tempTitle.toUpperCase() 
				                         + '   ' +obj.content.tempText;
			}
			else
			{
				obj.content.visibleText = obj.content.tempText;
				trace('obj.content.visibleText: '+obj.content.visibleText)
			}
			obj.content.transitionIn();
		}
		tween2.content = this;
		tween2.onMotionFinished = function(obj)
		{
			obj.content.iconUrl = obj.content.tempIconUrl;
		}
	}
	public function transitionIn():Void
	{
		var ease  = mx.transitions.easing.Strong.easeIn;
		var begin = 0;
		var end   = 80;
		var time  = .4;
		var tween = new mx.transitions.Tween(this.display, "_alpha", ease, begin, end, time, true);
		var tween2 = new mx.transitions.Tween(this.icon, "_alpha", ease, begin, end, time, true);
	}
	public function pause()
	{
		this.$ticking = false;
	}
	public function resume()
	{
		this.$ticking = true;
	}
	// public data methods
	public function get operandIndex():Number
	{
		return this.$operandIndex;
	}
	public function get displayIndex():Number
	{
		return this.$displayIndex;
	}
	public function get operand():Array
	{
		return this.$operand;
	}
	public function set operand(o:Array):Void
	{
		clearInterval(this.$tickInterval)
		this.$operand = o;
		this.tick(this);
		this.$tickInterval = setInterval(this.tick, this.$displaySeconds*1000, this);
		trace('dispatching onTickerInit event')
		this.dispatchEvent(new org.caleb.event.Event('onTickerInit', undefined));
	}
	// tick stuff
	public function get ticking():Boolean
	{
		return this.$ticking;
	}
	public function set ticking(b:Boolean):Void
	{
		this.$ticking = b;
	}
	public function get started():Boolean
	{
		return this.$started;
	}
	public function set displaySeconds(n:Number):Void
	{
		this.$displaySeconds = n;
	}
	public function set started(b:Boolean):Void
	{
		this.$started = b;
	}
	// icon stuff
	public function set iconUrl(iUrl:String):Void
	{
		if(iUrl != undefined)
		{
			_root.debug.text += 'icon: ' + this.$icon + "\n";
			//_root.debug.text += 'iconUrl loading: ' + iUrl + "\n";
			this.$icon.loadMovie(iUrl);
			this.$icon._xscale = this.$icon._yscale = 200;
		}
	}
	// read/write
	public function get icon():MovieClip
	{
		return this.$icon;
	}
	public function set icon(i:MovieClip):Void
	{
		this.$icon = i;
	}
}