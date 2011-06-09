import org.caleb.core.CoreObject;

class org.caleb.wordpress.WordPressPage extends CoreObject
{
	private var $pageId:String;
	private var $postings:Array;
	
	public function WordPressPage(id:String)
	{
		this.setClassDescription('org.caleb.wordpress.WordPressPage');
		this.$pageId = id;
		this.$postings = new Array;
	}
	/**
	* Accessor for private $pageId var.
	* @return Number.
	**/	
	public function get pageId():String
	{
		return this.$pageId;
	}

	/**
	* Accessor for private $postings var.
	* @return Array of WordPressPosting objects.
	**/	
	public function get postings():Array
	{
		return this.$postings;
	}
}