import org.caleb.core.CoreInterface;

interface org.caleb.components.menu.ICoreXMLMenu extends CoreInterface
{
	public function init(xmlURL:String):Void;
	public function generateMenu(m:org.caleb.components.menu.MenuInfo):Void;
	public function handleLoad(success:Boolean):Void;
}