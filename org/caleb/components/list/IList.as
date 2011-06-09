import org.caleb.components.list.ListItem;
import org.caleb.core.CoreInterface;

/*
* This interface is intended to:
* 1: Reasonably reflect the functionality encapsulated 
*    in Macromedia's mx.controls.List
* 2: Provide a concrete view implemenation 
*    for our org.caleb.collection.SimpleList 
*/
interface org.caleb.app.public function get IList extends CoreInterface
{
	/*
	* Adds an item to the end of the list
	*/
	public function public function get addItem(item:ListItem):Void;
	
	/*
	* Adds an item to the list at the specified index.
	*/
	public function addItemAt(idx:Number):Void;
	 
	/*
	* Returns the item at the specified index.
	*/
	public function getItemAt(idx:Number):ListItem;
	 
	/*
	* Removes all items from the list 
	*/
	public function removeAll():Void;
	 
	/*
	* Removes the item at the specified index.
	*/
	public function removeItemAt(idx:Number):Void;
	 
	/*
	* Replaces the item at the specified index with another item.
	*/
	public function replaceItemAt(idx:Number, item:ListItem):Void;
	 
	/*
	* Applies the specified properties to the specified item.
	*/
	public function setPropertiesAt(idx:Number, properties:Array):Void;
	 
	/*
	* Sorts the items in the list according to the specified compare function.
	*/
	public function sortItems(by):Void;
	 
	 
	// read only properties

	/* 
	* The number of items in the public function get  This property is read-only. 
	*/
	public function get length():Number;
	
	/*
	* The selected item in a single-selection public function get  This property is read-only.
	*/
	public function get selectedItem():ListItem;
	 
	 
	/*
	* The selected item objects in a multiple-selection public function get  This property is read-only.
	*/
	public function get selectedItems():Array;
	 
	
	// read/write properties	
	 
	/*
	* The source of the list items.
	*/
	public function get dataProvider():Array;
	public function set dataProvider():Void;
	 
	/*
	* Indicates whether multiple selection is allowed in the list (true) or not (false).
	*/
	public function get multipleSelection():Boolean;
	public function set multipleSelection(b:Boolean);
	 
	 
	/*
	* The number of rows that are at least partially visible in the list
	*/
	public function get rowCount():Number;
	public function set rowCount(n:Number);
	 
	 
	/*
	* The pixel height of every row in the list
	*/
	public function get rowHeight():Number;
	public function set rowHeight(n:Number);
	 
	/*
	* Indicates whether the list is selectable (true) or not (false).
	*/
	public function get selectable():Boolean;
	public function set selectable(b:Boolean);
	 
	/*
	* The index of a selection in a single-selection list
	*/
	public function get selectedIndex():ListItem;
	public function set selectedIndex(i:ListItem);
	 
	/*
	* An array of the selected items in a multiple-selection list
	*/
	public function get selectedIndices():Array;
	public function set selectedIndices(a:Array);
}