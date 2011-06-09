import org.caleb.core.CoreObject;

class org.caleb.wordpress.WordPressPosting extends CoreObject
{
	private var $categories:Array;
	private var $links:Array;
	private var $title:String;
	private var $date:String;
	private var $body:String;
	private var $comments:String;

	public function WordPressPosting()
	{
		this.setClassDescription('org.caleb.wordpress.WordPressPosting');
		this.$categories = new Array;
		this.$links = new Array;
		this.$title = new String;
		this.$date = new String;
		this.$body = new String;
		this.$comments = new String;
	}

	/**
	* Accessor for private $categories var.
	* @return Array.
	**/	
	public function get categories():Array
	{
		return this.$categories;
	}
	/**
	* Accessor for private $links var.
	* @return Array.
	**/	
	public function get links():Array
	{
		return this.$links;
	}
	/**
	* Mutator for private $links var.
	* @param arg String
	**/
	public function set links(arg:Array) 
	{
		this.$links = arg;
	}
	/**
	* Accessor for private $date var.
	* @return String.
	**/
	public function get date():String
	{
		return this.$date;
	}
	/**
	* Mutator for private $date var.
	* @param arg String
	**/
	public function set date(arg:String) 
	{
		this.$date = arg;
	}
	/**
	* Accessor for private $title var.
	* @return String.
	**/
	public function get title():String
	{
		return this.$title;
	}
	/**
	* Mutator for private $title var.
	* @param arg String
	**/
	public function set title(arg:String) 
	{
		this.$title = arg;
	}
	/**
	* Accessor for private $body var.
	* @return String.
	**/
	public function get body():String
	{
		return this.$body;
	}
	/**
	* Mutator for private $body var.
	* @param arg String
	**/
	public function set body(arg:String) 
	{
		this.$body = arg;
	}
	/**
	* Accessor for private $comments var.
	* @return String.
	**/
	public function get comments():String
	{
		return this.$comments;
	}
	/**
	* Mutator for private $comments var.
	* @param arg String
	**/
	public function set comments(arg:String) 
	{
		this.$comments = arg;
	}
}