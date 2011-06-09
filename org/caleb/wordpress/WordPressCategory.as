import org.caleb.wordpress.WordPressPage;

class org.caleb.wordpress.WordPressCategory extends WordPressPage
{
	private var $categoryId:Number;
	private var $postings:Array;
	
	public function WordPressCategory(categoryId:Number)
	{
		this.setClassDescription('org.caleb.wordpress.WordPressCategory');
		this.$categoryId = categoryId;
	}
	/**
	* Accessor for private $categoryId var.
	* @return Number.
	**/	
	public function get categoryId():Number
	{
		return this.$categoryId;
	}
}