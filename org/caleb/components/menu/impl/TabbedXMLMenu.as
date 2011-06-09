import org.caleb.components.menu.impl.CoreXMLMenu;
import org.caleb.components.menu.ICoreXMLMenu;
import org.caleb.components.menu.MenuInfo;
import org.caleb.components.pane.PaneCollection;
import org.caleb.components.pane.PaneManager;

class org.caleb.components.menu.impl.TabbedXMLMenu extends CoreXMLMenu implements ICoreXMLMenu
{
	public var panes:PaneCollection;
	private var menu:MenuInfo;
	private var xmlURL:String;
	private var container:MovieClip;
	private var paneManager:PaneManager;
	private var paneContainer:MovieClip;
	
	public function TabbedXMLMenu(target:MovieClip, xURL:String)
	{
		this.setClassDescription('org.caleb.components.menu.impl.TabbedXMLMenu')
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
	
	public function handleLoad(success:Boolean):Void
	{
		if(success)
		{
			this.menu = new MenuInfo(this.container, 'SimpleMenu', 0,0, this.container.getNextHighestDepth(),this.firstChild);
			this.initPaneCollection(menu);
			this.paneManager = new PaneManager(this.paneContainer, panes);
			this.generateMenu(menu)
		}
		else
		{
			// handle failure
		}
	}
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
				trace('added pane named: ' + org.caleb.util.StringUtil.replace(curr_node.attributes.paneInstanceId,' ',''))
				this.panes.addPane(curr_node.attributes.pane, curr_node.attributes.name, org.caleb.util.StringUtil.replace(curr_node.attributes.paneInstanceId,' ',''))
			}
			i++;
		}
	}
	
	public function generateMenu(m:MenuInfo):Void
	{
		// variable declarations
		var curr_node;
		var curr_item;
		var curr_menu = m.targetClip.createEmptyMovieClip(m.name, m.depth);

		var xmlLength = m.xml.childNodes.length;
		var i = 0;
		// for all items or XML nodes (items and menus)
		// within this menu_xml passed for this menu
		while(xmlLength--) 
		{
			// movieclip for each menu item
			curr_item = curr_menu.attachMovie(this.menuItemLibraryClip,"item"+i+"_mc", i);
			curr_item._x = m.x +  + i*curr_item._width;
			curr_item._y = m.y;
			curr_item.trackAsMenu = true;
			
			// item properties assigned from XML
			curr_node = m.xml.childNodes[i];
			curr_item.paneMgr = paneManager;
			curr_item.pane = curr_node.attributes.pane;
			curr_item.paneInstanceId = curr_node.attributes.paneInstanceId;
			curr_item.variables = curr_node.attributes.variables;
			curr_item.name.text = curr_node.attributes.name;
			
			curr_item.onRollOver = curr_item.onDragOver = function()
			{
				// show a hover color
				var col = new Color(this.background);
				col.setRGB(0xf4faff);
			};
			curr_item.onRollOut = curr_item.onDragOut = function()
			{
				// restore color
				var col = new Color(this.background);
				col.setTransform({ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
			}
			
			// any item, menu opening or not can have actions
			curr_item.onRelease = function()
			{
				this.paneMgr.showPane(this.paneInstanceId)
				// this.actions[this.action](this.variables);
			}
			i++;
		} // end for loop
	}
}