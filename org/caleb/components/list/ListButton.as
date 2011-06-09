import org.caleb.movieclip.CoreMovieClip;
import org.caleb.components.list.List;

class org.caleb.components.list.ListButton extends CoreMovieClip
{
	public static var MODE_NEXT:String = 'LIST_BUTTON_MODE_NEXT';
	public static var MODE_PREVIOUS:String = 'LIST_BUTTON_MODE_PREVIOUS';
	
	private var $list:List;
	private var $mode:String;
	
	function ListButton()
	{
		// trace('[ListButton] constructor invoked')
		this.$mode = ListButton.MODE_NEXT;
	}
	public function set list(l:List):Void
	{
		// trace('[ListButton] set list invoked w/ list: '+l)
		this.$list = l;
	}
	public function set mode(m:String):Void
	{
		// trace('[ListButton] set mode invoked w/ mode: '+m)
		this.$mode = m;
	}
	// event handlers
	public function onRelease()
	{
		switch(this.$mode)
		{
			case ListButton.MODE_NEXT:
			{
				if(this.$list.locked == false)
				{
					this.$list.next();
				}
			}
			break;
			case ListButton.MODE_PREVIOUS:
			{
				if(this.$list.locked == false)
				{
					this.$list.previous();
				}
			}
			break;
		}
	}
}