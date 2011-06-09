import org.caleb.components.menu.ICoreXMLMenu;
import org.caleb.components.menu.MenuInfo;
import org.caleb.xml.SimpleXML;

class org.caleb.components.menu.impl.CoreXMLMenu extends SimpleXML implements ICoreXMLMenu
{
	private var menuItemLibraryClip:String;
	
	public function CoreXMLMenu()
	{
		this.setMenuItemLibaryClip('menuitem');
		this.ignoreWhite = true;
		this.onLoad = handleLoad;
	}
	
	public function setMenuItemLibaryClip(linkageId:String)
	{
		this.menuItemLibraryClip = linkageId;
	}
	public function toString(Void):String
	{
		return 'org.caleb.components.menu.impl.CoreXMLMenu';
	}
	public function init(xmlURL:String):Void{};
	public function generateMenu(m:MenuInfo):Void{};
	public function handleLoad(success:Boolean):Void{};
}
