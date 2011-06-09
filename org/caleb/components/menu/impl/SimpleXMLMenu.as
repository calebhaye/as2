import org.caleb.components.menu.impl.CoreXMLMenu;
import org.caleb.components.menu.ICoreXMLMenu;
import org.caleb.components.menu.MenuInfo;

class org.caleb.components.menu.impl.SimpleXMLMenu extends CoreXMLMenu implements ICoreXMLMenu
{
	private var menu:MenuInfo;
	private var xmlURL:String;
	private var container:MovieClip;
	
	public function SimpleXMLMenu(target:MovieClip, xURL:String)
	{
		trace('[SimpleMenu] constructor invoked w/ args:');
		trace('target: ' + target);
		trace('xURL: ' + xURL);

		this.xmlURL = xURL;
		this.container = target;
		this.init(xURL);
	}
	
	public function init(xURL:String):Void
	{
		this.load(xURL);
	}
	
	public function handleLoad(success:Boolean):Void
	{
		trace('[SimpleMenu] handleLoad invoked w/ success:'+success);
		if(success)
		{
			this.menu = new MenuInfo(this.container, 'SimpleMenu', 0,0, this.container.getNextHighestDepth(),this.firstChild);
			this.generateMenu(menu)
		}
		else
		{
			// handle failure
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
			curr_item._x = m.x;
			curr_item._y = m.y + i*curr_item._height;
			curr_item.trackAsMenu = true;
			
			// item properties assigned from XML
			curr_node = m.xml.childNodes[i];
			curr_item.action = curr_node.attributes.action;
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
				this.actions[this.action](this.variables);
			}
			i++;
		} // end for loop
	}
}