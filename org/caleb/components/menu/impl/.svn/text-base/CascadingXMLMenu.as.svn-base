import org.caleb.components.menu.XMLMenuActions;
import org.caleb.components.menu.ICascadingXMLMenu;
import org.caleb.components.menu.impl.CoreXMLMenu;
import org.caleb.components.menu.MenuInfo;
import XMLSocket;
class org.caleb.components.menu.impl.CascadingXMLMenu extends CoreXMLMenu implements ICascadingXMLMenu
{
	private var container:MovieClip;
	private var actions:XMLMenuActions;
	public var foobie:XMLSocket;
	public function CascadingXMLMenu(target:MovieClip, xmlURL:String)
	{
		foobie = new XMLSocket();
		trace('[CascadingXMLMenu] constructor invoked w/ args:');
		trace('target: ' + target);
		trace('xmlURL: ' + xmlURL);
		
		container = target;
		this.ignoreWhite = true;
		this.onLoad = handleLoad;
		this.actions = new XMLMenuActions();
		this.init(xmlURL);
	}
	
	public function init(xmlURL:String):Void
	{
		this.load(xmlURL);
	}
	
	public function handleLoad(success:Boolean):Void
	{
		if (success)
		{
			this.createMainMenu(new MenuInfo(container,'mainmenu_mc',10, 10, 0, this.firstChild));
		}
		else
		{
			// error:  XML not successfully loaded
		}
	}
	public function createSubMenu():Void
	{
		var x = MovieClip(this)._x + MovieClip(this)._width - 5;
		var y = MovieClip(this)._y + 5;
		var subMenu = new MenuInfo(MovieClip(this).curr_menu, "submenu_mc", x, y, 1000, MovieClip(this).node_xml);
		generateMenu(subMenu);
		// -- it's good here .. trace('MovieClip(this).node_xml:'+MovieClip(this).node_xml);
		// show a hover color
		var col = new Color(MovieClip(this).background);
		col.setRGB(0xf4faff);
	}
	public function createMainMenu(m:MenuInfo):Void
	{
		// generate a menu list
		this.generateMenu(m);
	}	
	
	// generates a list of menu items (effectively one menu)
	// given the inputted parameters.  This makes the main menu
	// as well as any of the submenus
	public function generateMenu(m:MenuInfo):Void
	{
		// variable declarations
		var curr_node;
		var curr_item;
		var curr_menu = m.targetClip.createEmptyMovieClip(m.name, m.depth);
		// close only submenus if visible durring a mouseup
		// this main menu (mainmenu_mc) will remain
		curr_menu.onMouseUp = function()
		{
			if (curr_menu.submenu_mc && !curr_menu.hitTest(_root._xmouse, _root._ymouse, true))
			{
				this.closeSubMenus(this);
			}
		}

		var xmlLength = m.xml.childNodes.length;
		var i = 0;
		// for all items or XML nodes (items and menus)
		// within this node_xml passed for this menu
		while(xmlLength--) 
		{
			// movieclip for each menu item
			curr_item = curr_menu.attachMovie("menuitem","item"+i+"_mc", i);
			curr_item._x = m.x;
			curr_item._y = m.y + i*curr_item._height;
			curr_item.trackAsMenu = true;
			curr_item.createSubMenu = createSubMenu;
			
			// item properties assigned from XML
			curr_node = m.xml.childNodes[i];
			curr_item.action = curr_node.attributes.action;
			curr_item.variables = curr_node.attributes.variables;
			curr_item.name.text = curr_node.attributes.name;
			
			// item submenu behavior for rollover event
			if (m.xml.childNodes[i].nodeName == "menu")
			{
				// open a submenu
				curr_item.node_xml = curr_node;
				curr_item.curr_menu = curr_menu;
				curr_item.generateMenu = generateMenu;
				curr_item.onRollOver = curr_item.onDragOver = curr_item.createSubMenu;
			}
			else
			{ // nodeName == "item"
				curr_item.arrow._visible = false;
				// close existing submenu
				curr_item.onRollOver = curr_item.onDragOver = function()
				{
					curr_menu.submenu_mc.removeMovieClip();
					// show a hover color
					var col = new Color(this.background);
					col.setRGB(0xf4faff);
				};
			}
			
			curr_item.onRollOut = curr_item.onDragOut = function()
			{
				// restore color
				var col = new Color(this.background);
				col.setTransform({ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
			};
			
			// any item, menu opening or not can have actions
			curr_item.onRelease = function()
			{
				this.actions[this.action](this.variables);
				this.closeSubMenus(curr_menu);
			};
			i++;
		} // end for loop
	}

	public function closeSubMenus(m:MovieClip)
	{
		m.submenu_mc.removeMovieClip();
	}	
}