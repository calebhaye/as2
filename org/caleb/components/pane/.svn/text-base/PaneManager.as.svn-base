import org.caleb.components.pane.PaneCollection;
import org.caleb.components.pane.Pane;
import org.caleb.movieclip.CoreMovieClip;

class org.caleb.components.pane.PaneManager extends CoreMovieClip
{
	public var paneContainer:MovieClip;
	public var panes:PaneCollection;
	public static var PaneIdentifier = 'pane';
	
	public function PaneManager(c:MovieClip, pc:PaneCollection)
	{
		this.setClassDescription('org.caleb.components.pane.PaneManager')
		this.panes = pc;
		this.paneContainer = c.createEmptyMovieClip('paneContainer', paneContainer.getNextHighestDepth());
		paneContainer._x = 0;
		paneContainer._y = 0;
		this.initializePanes();
	}
	public function initializePanes():Void
	{
		while(this.panes.$iterator.hasNext())
		{
			var nextPane:Pane = Pane(panes.$iterator.next());
			var pane = paneContainer.attachMovie(nextPane.getLibraryClip(), nextPane.getPaneInstanceId(), paneContainer.getNextHighestDepth(),{_visible:false});
		}
	}
	public function hideAll()
	{
		while(this.panes.$iterator.hasNext())
		{	
			var thisPaneId = Pane(panes.$iterator.next()).getPaneInstanceId();
			this.paneContainer[thisPaneId]._visible = false;
		}
		this.panes.$iterator.reset()
	}
	public function showPane(p:String)
	{
		while(this.panes.$iterator.hasNext())
		{	
			var thisPaneId = Pane(panes.$iterator.next()).getPaneInstanceId();
			if(p == thisPaneId)
			{
				this.paneContainer[thisPaneId]._visible = true;
			}
			else
			{
				this.paneContainer[thisPaneId]._visible = false;
			}
		}
		this.panes.$iterator.reset()
	}
}