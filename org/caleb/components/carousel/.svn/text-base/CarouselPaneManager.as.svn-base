import org.caleb.components.pane.PaneCollection;
import org.caleb.components.pane.Pane;
import org.caleb.components.pane.PaneManager;

class org.caleb.components.carousel.CarouselPaneManager extends PaneManager
{
	/**
	 * 
	 * @usage   
	 * @param   c  
	 * @param   pc 
	 * @return  
	 */
	public function CarouselPaneManager(c:MovieClip, pc:PaneCollection)
	{
		super(c,pc);
		this.setClassDescription('org.caleb.components.carousel.CarouselPaneManager')
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
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
	/**
	 * 
	 * @usage   
	 * @param   p 
	 * @return  
	 */
	public function showPane(p:String)
	{
		this.paneContainer[p]._visible = true;
		var ease  = mx.transitions.easing.Bounce.easeInOut;
		var begin = paneContainer._x;
		var end   = -paneContainer[p]._x;
		var time  = .5;
		var paneTween = new mx.transitions.Tween(paneContainer, "_x", ease, begin, end, time, true);		
	}
}