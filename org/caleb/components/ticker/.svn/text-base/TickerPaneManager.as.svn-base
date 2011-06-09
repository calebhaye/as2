import org.caleb.components.pane.PaneCollection;
import org.caleb.components.pane.Pane;
import org.caleb.components.pane.PaneManager;

class org.caleb.components.ticker.TickerPaneManager extends PaneManager
{
	private var tickerInterval:Number;
	private var infinite:Boolean;
	
	public function TickerPaneManager(c:MovieClip, pc:PaneCollection, continuous:Boolean)
	{
		super(c,pc);
		this.infinite = continuous;
		this.setClassDescription('org.caleb.components.carousel.TickerPaneManager')
		tickerInterval = setInterval(go, '4000',this.paneContainer, this.panes, this.infinite);
	}
	public function initializePanes():Void
	{
		var paneX:Number = 0;
		while(this.panes.$iterator.hasNext())
		{
			var nextPane:Pane = Pane(panes.$iterator.next());
			var pane = paneContainer.attachMovie(nextPane.getLibraryClip(), nextPane.getLibraryClip(), paneContainer.getNextHighestDepth(),{});
			pane._x = paneX;
			paneX += pane._width;
		}
		this.panes.$iterator.reset();
	}
	
	public function go(target, panes:PaneCollection, infinite:Boolean)
	{
		var p:String;
		var begin:Number, end:Number;
		var newTarget:MovieClip;
		var doNew:Boolean = false;
		
		if(panes.$iterator.hasNext())
		{
			p = panes.$iterator.next().getLibraryClip();
			begin = target._x;
			end   = begin + (-target[p]._width);
			if(Math.abs(end) == Math.abs(target._width))
			{
				trace('aaa:'+infinite)
				if(infinite == true)
				{
					target._x = 0;
					begin = target[p]._width;
					end   = begin + (-target[p]._width);
				}
				else
				{
					begin = -target[p]._width;
					end = 0;
				}
			}
		}
		else
		{
			panes.$iterator.reset();
			p = panes.getElementAtIndex(0).getLibraryClip();
			begin = target._x;
			end   = begin + (-target[p]._width);
		}

		var ease  = mx.transitions.easing.Bounce.easeInOut;
		var time  = .5;
		var paneTween = new mx.transitions.Tween(target, "_x", ease, begin, end, time, true);		
	}
}