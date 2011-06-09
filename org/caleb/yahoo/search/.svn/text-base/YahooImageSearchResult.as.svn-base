import org.caleb.yahoo.search.YahooSearchResult;
import org.caleb.yahoo.search.YahooSearchThumbnail;

class org.caleb.yahoo.search.YahooImageSearchResult extends YahooSearchResult
{
	private var $RefererUrl:String;
	private var $FileSize:Number;
	private var $FileFormat:String;
	private var $Height:Number;
	private var $Width:Number;
	private var $Thumbnail:YahooSearchThumbnail;
	/*
	 * Sole Constructor 
	 */
	public function YahooImageSearchResult(Title:String, Summary:String, Url:String, ClickUrl:String, RefererUrl:String, FileSize:Number, FileFormat:String, Height:Number, Width:Number, Thumbnail:YahooSearchThumbnail)
	{
		super(Title, Summary, Url, ClickUrl);
		this.$RefererUrl = RefererUrl;
		this.$FileSize = FileSize;
		this.$FileFormat = FileFormat;
		this.$Height = Height;
		this.$Width = Width;
		this.$Thumbnail = Thumbnail;
	}
	/*
	 * Accessor for private $RefererUrl var
	 */
	public function get RefererUrl():String
	{
		return this.$RefererUrl;
	}
	/**
	* Mutator for private $RefererUrl var.
	* @param arg String
	**/
	public function set RefererUrl(arg:String) 
	{
		this.$RefererUrl = arg;
	}
	/*
	 * Accessor for private $FileSize var
	 */
	public function get FileSize():Number
	{
		return this.$FileSize;
	}
	/**
	* Mutator for private $FileSize var.
	* @param arg Number
	**/
	public function set FileSize(arg:Number) 
	{
		this.$FileSize = arg;
	}
	/*
	 * Accessor for private $FileFormat var
	 */
	public function get FileFormat():String
	{
		return this.$FileFormat;
	}
	/**
	* Mutator for private $FileFormat var.
	* @param arg String
	**/

	public function set FileFormat(arg:String) 
	{
		this.$FileFormat = arg;
	}
	/*
	 * Accessor for private $Height var
	 */
	public function get Height():Number
	{
		return this.$Height;
	}
	/**
	* Mutator for private $Height var.
	* @param arg Number
	**/
	public function set Height(arg:Number) 
	{
		this.$Height = arg;
	}
	/*
	 * Accessor for private $Width var
	 */
	public function get Width():Number
	{
		return this.$Width;
	}
	/**
	* Mutator for private $Width var.
	* @param arg Number
	**/

	public function set Width(arg:Number) 
	{
		this.$Width = arg;
	}
	/*
	 * Accessor for private $Thumbnails var
	 */
	public function get Thumbnail():YahooSearchThumbnail
	{
		return this.$Thumbnail;
	}
	/**
	* Mutator for private $Thumbnail var.
	* @param arg YahooSearchThumbnail
	**/
	public function set Thumbnail(arg:YahooSearchThumbnail) 
	{
		trace('setting thumbnail to: ')
		trace(arg);
		this.$Thumbnail = arg;
	}
}