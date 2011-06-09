import org.caleb.xml.SimpleXML;
import org.caleb.components.menu.MenuInfo;
import org.caleb.components.pane.PaneCollection;
import org.caleb.components.ticker.TickerPaneManager;

/**
 * 
 * @author  calebh
 * @version 1.0
 * @see     SimpleXML	
 * @since   
 */
class org.caleb.components.ticker.XMLTicker extends SimpleXML
{
	public var panes:PaneCollection;
	private var menu:MenuInfo;
	private var xmlURL:String;
	private var paneManager:TickerPaneManager;
	private var container:MovieClip;
	private var paneContainer:MovieClip;
	private var infinite:Boolean;

	/**
	 * 
	 * @usage   
	 * @param   target     
	 * @param   xURL       
	 * @param   continuous 
	 * @return  
	 */
	public function XMLTicker(target:MovieClip, xURL:String, continuous:Boolean)
	{
		this.setClassDescription('org.caleb.components.ticker.XMLTicker')
		this.infinite = continuous;
		this.ignoreWhite = true;
		this.onLoad = handleLoad;
		this.xmlURL = xURL;
		this.container = target;
		this.panes = new PaneCollection();
		this.paneContainer = this.container.createEmptyMovieClip('tabMenuPanes', this.container.getNextHighestDepth());
		// init
		this.init(xURL);
	}
	public function init(xURL:String):Void
	{
		this.load(xURL);
	}
	/**
	 * 
	 * @usage   
	 * @param   success 
	 * @return  
	 */
	public function handleLoad(success:Boolean):Void
	{
		if(success)
		{
			this.menu = new MenuInfo(this.container, 'TickerMenu', 0,0, this.container.getNextHighestDepth(),this.firstChild);
			this.initPaneCollection(menu);
			this.paneManager = new TickerPaneManager(this.paneContainer, panes, infinite);
			/**/
		}
		else
		{
			// handle failure
		}
	}
	/**
	 * 
	 * @usage   
	 * @param   m 
	 * @return  
	 */
	public function initPaneCollection(m:MenuInfo)
	{
		var curr_node;

		var xmlLength = m.xml.childNodes.length;
		var i = 0;

		while(xmlLength--) 
		{
			curr_node = m.xml.childNodes[i];
			if(curr_node.attributes.pane != undefined)
			{
				this.panes.addPane(curr_node.attributes.pane, curr_node.attributes.name)
			}
			i++;
		}
	}
}