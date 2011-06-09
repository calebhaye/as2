import org.caleb.core.CoreObject;

class org.caleb.wordpress.WordPressHomePage extends CoreObject
{
	private var $postings:Array;
	
	public function WordPressHomePage(categoryId:Number)
	{
		this.setClassDescription('org.caleb.wordpress.WordPressHomePage');
		this.$categoryId = categoryId;
		this.$postings = new Array;
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