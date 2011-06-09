import org.caleb.event.Event;
import org.caleb.yahoo.search.YahooSearchResult;

class org.caleb.yahoo.search.YahooSearchResultEvent extends Event
{

	private var $Results:Array;
	private var $firstResultPosition:Number;
	private var $totalResultsReturned:Number;
	private var $totalResultsAvailable:Number;
	private var $xsi_schemaLocation:String;
	private var $xmlns:String;
	private var $xmlns_xsi:String;
	/*
	 * Sole Constructor 
	 */
	public function YahooSearchResultEvent(Results:Array, firstResultPosition:Number, totalResultsReturned:Number, totalResultsAvailable:Number, xsi_schemaLocation:String, xmlns:String, xmlns_xsi:String)
	{
		trace('constructor invoked');
		if(arguments[7] != undefined && typeof(arguments[7]) == 'string')
		{
			this.setType(arguments[7]);
		}
		else
		{
			this.setType('onYahooSearchResult');
		}
		this.$arguments = new Object();
			
		this.$Results = Results;
		this.$firstResultPosition = firstResultPosition;
		this.$totalResultsReturned = totalResultsReturned;
		this.$totalResultsAvailable = totalResultsAvailable;
		this.$xsi_schemaLocation = xsi_schemaLocation
		this.$xmlns = xmlns;
		this.$xmlns_xsi = xmlns_xsi;
	}
	
	public function get xml():XML
	{
		return XML(this.$arguments['xml']);
	}
	public function get type():String
	{
		return String(this.$arguments['type']);
	}
	public function get query():String
	{
		return String(this.$arguments['response'].query);
	}
	public function get length():Number
	{
		return this.$Results.length;
	}
	public function getResult(index:Number):YahooSearchResult
	{
		//trace('Results[index]: ' + this.$Results[index]);
		//trace('YahooSearchResult(this.$Results[index]): ' + YahooSearchResult(this.$Results[index]));
		var result:YahooSearchResult = YahooSearchResult(this.$Results[index]);
		if(result == null)
		{
			// for queries that return simple lists, like term extraction or related search: just return the string, no complex object is needed;
			return this.$Results[index];
		}
		else
		{
			return result;
		}
	}
	/*
	 * Accessor for private $firstResultPosition var
	 */
	public function get firstResultPosition():Number
	{
		return this.$firstResultPosition;
	}
	/*
	 * Accessor for private $totalResultsReturned var
	 */
	public function get totalResultsReturned():Number
	{
		return this.$totalResultsReturned;
	}
	/*
	 * Accessor for private $totalResultsAvailable var
	 */
	public function get totalResultsAvailable():Number
	{
		return this.$totalResultsAvailable;
	}
	/*
	 * Accessor for private $xsi:schemaLocation var
	 */
	public function get xsi_schemaLocation():String
	{
		return this.$xsi_schemaLocation;
	}
	/*
	 * Accessor for private $xmlns var
	 */
	public function get xmlns():String
	{
		return this.$xmlns;
	}
	/*
	 * Accessor for private $xmlns:xsi var
	 */
	public function get xmlns_xsi():String
	{
		return this.$xmlns_xsi;
	}
}