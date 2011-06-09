import org.caleb.collection.AbstractList;
import org.caleb.components.pane.Pane;

class org.caleb.components.pane.PaneCollection extends AbstractList
{
	public function PaneCollection()
	{
	}
	
	public function addPane(libraryClip:String, parentNodeName:String, paneInstanceId:String)
	{
		var newPane = new Pane();
		newPane.setLibraryClip(libraryClip)
		newPane.setParentNodeName(parentNodeName);
		newPane.setPaneInstanceId(paneInstanceId);
		this.addElement(newPane)
	}
	public function toString():String
	{
		return 'org.caleb.components.pane.PaneCollection';
	}
}