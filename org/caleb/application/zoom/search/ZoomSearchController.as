import org.caleb.application.zoom.ZoomController;
import org.caleb.application.zoom.search.ZoomSearchData;
import org.caleb.application.zoom.search.ZoomSearchXML;

class org.caleb.application.zoom.search.ZoomSearchController extends ZoomController
{
	private var $mode:String;
	private var $data:ZoomSearchData;
	private var $zoomXML:ZoomSearchXML;
	public function ZoomSearchController(zoomViewer)
	{
		super(zoomViewer);
		this.setClassDescription('org.caleb.application.zoom.ZoomSearchController');
		//trace('constructor invoked');
		this.$data = new ZoomSearchData;
		this.initData(zoomViewer);
	}
	public function initXML():Void
	{
		this.$zoomXML = new ZoomSearchXML;
		this.$zoomXML.addEventObserver(this, 'onZoomXMLReady');
		this.$zoomXML.controller = this;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get totalResultsAvailable():Number
	{
		return this.$data.totalResultsAvailable;
	}
	/**
	 * 
	 * @usage   
	 * @param   n 
	 * @return  
	 */
	public function set totalResultsAvailable(n:Number):Void
	{
		this.$data.totalResultsAvailable = n;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get totalResultsReturned():Number
	{
		return this.$data.totalResultsReturned;
	}
	/**
	 * 
	 * @usage   
	 * @param   n 
	 * @return  
	 */
	public function set totalResultsReturned(n:Number):Void
	{
		this.$data.totalResultsReturned = n;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get firstResultPosition():Number
	{
		return this.$data.firstResultPosition;
	}
	/**
	 * 
	 * @usage   
	 * @param   n 
	 * @return  
	 */
	public function set firstResultPosition(n:Number):Void
	{
		this.$data.firstResultPosition = n;
	}
	
	public function get data():ZoomSearchData
	{
		return this.$data;
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	public function get mode():String
	{
		return this.$data.mode;
	}
	/**
	 * 
	 * @usage   
	 * @param   n 
	 * @return  
	 */
	public function set mode(arg:String):Void
	{
		this.$data.mode = arg;
	}
}