import org.caleb.components.list.ListItem;
import org.caleb.collection.SimpleList;
import org.caleb.components.list.SimpleListView;

class org.caleb.components.list.List extends SimpleListView
{
	static var SymbolName:String = '__Packages.org.caleb.components.list.List';
	static var SymbolLinked = Object.registerClass(SymbolName, List);

	public function List()
	{
		this.setClassDescription('org.caleb.components.list.List');
	}
	
	public function setViewArea(w:Number, h:Number)
	{
		super.setViewArea(w,h);
		this.paint();
	}
	private function drawMask(w:Number, h:Number):Void
	{
		super.drawMask((w + this.$maskOffsetX), (h + this.$maskOffsetY));
		this.$mask._x = this._x - this.$maskOffsetX;
		var maskId:String = this.$mask_id + this._name;
		this._parent[maskId]._y = _parent[this._name]._y - this.$maskOffsetY;
	}
}