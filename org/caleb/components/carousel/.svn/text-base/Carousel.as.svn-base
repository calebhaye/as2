import org.caleb.components.menu.impl.TabbedXMLMenu;
import org.caleb.components.menu.MenuInfo;
import org.caleb.components.carousel.CarouselPaneManager;

/**
 * 
 * @see     TabbedXMLMenu	
 */
class org.caleb.components.carousel.Carousel extends TabbedXMLMenu
{
	public function Carousel(target:MovieClip, xURL:String)
	{
		super(target,xURL);
		this.setClassDescription('org.caleb.components.carousel.Carousel')
	}
	/**
	 * 
	 * @param   success 
	 * @return  
	 */
	public function handleLoad(success:Boolean):Void
	{
		if(success)
		{
			this.menu = new MenuInfo(this.container, 'SimpleMenu', 0,0, this.container.getNextHighestDepth(),this.firstChild);
			this.initPaneCollection(menu);
			this.paneManager = new CarouselPaneManager(this.paneContainer, panes);
			this.generateMenu(menu)
		}
		else
		{
			// handle failure
		}
	}

	/**
	 * 
	 * @param   m 
	 * @return  
	 */
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
			curr_item = curr_menu.attachMovie("menuitem","item"+i+"_mc", i);
			curr_item._x = m.x +  + i*curr_item._width;
			curr_item._y = m.y;
			curr_item.trackAsMenu = true;
			
			// item properties assigned from XML
			curr_node = m.xml.childNodes[i];
			curr_item.paneMgr = paneManager;
			curr_item.pane = curr_node.attributes.pane;
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
				this.paneMgr.showPane(this.pane)
				// this.actions[this.action](this.variables);
			}
			i++;
		} // end for loop
	}
}