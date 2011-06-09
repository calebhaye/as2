import org.caleb.xml.SimpleXML;
import org.caleb.application.zoom.ZoomController;

/**
 * 
 * @author  calebh
 * @version 1.0
 * @see     SimpleXML	
 * @since   
 */
class org.caleb.application.zoom.ZoomXML extends SimpleXML 
{
	private var $controller:ZoomController;
	private var $imageURLs:Array;
	private var $thumbURLs:Array;
	private var $imageDetailsMap:Array;
	
	function ZoomXML()
	{
		//trace('constructor invoked');
		this.setClassDescription('org.caleb.application.zoom.ZoomXML');
		this.$imageURLs = new Array;
		this.$thumbURLs = new Array;
		this.$imageDetailsMap = new Array;
	}
	/**
	 * 
	 * @usage   
	 * @param   x 
	 * @return  
	 */
	public function set xml(x:XML):Void
	{
		//trace('xml manually set');
		this.doParse(x);
		var e:org.caleb.event.Event = new org.caleb.event.Event('onZoomXMLReady');
		e.addArgument('xml', x)
		this.dispatchEvent(e);
	}
	/**
	 * 
	 * @usage   
	 * @return  
	 */
	private function onParseSuccess()
	{
		//trace('onParseSuccess invoked')
		this.doParse(this);
	}
	/**
	 * 
	 * @usage   
	 * @param   x 
	 * @return  
	 */
	private function doParse(x:XML)
	{
		this.parseXML(x.toString());
		this.$controller.imageDimensions = Number(this.firstChild.attributes.cellDimension);
		this.$controller.columns = Number(this.firstChild.attributes.columns);
		this.$controller.zoomInPercentage = Number(this.firstChild.attributes.zoomInPerc);	
		this.$controller.frameWidth = Number(this.firstChild.attributes.frameWidth);	
		
		this.$controller.width =  this.$controller.imageDimensions * this.$controller.columns;
		this.$controller.height = this.$controller.imageDimensions * this.$controller.maxRows;
		this.$controller.launchX = 150
		this.$controller.launchY = 150
		this.$controller.zoomOutPercentage = Number(this.firstChild.attributes.zoomOutPerc);

		for (var i = 0;i<this.firstChild.childNodes.length;i++)
		{
			var imageDetails = new Array;
			imageDetails['title'] = this.firstChild.childNodes[i].attributes.name;
			imageDetails['url'] = this.firstChild.childNodes[i].firstChild.firstChild.nodeValue;
			imageDetails['size'] = this.firstChild.childNodes[i].attributes.filesize;
			imageDetails['width'] = this.firstChild.childNodes[i].attributes.width;
			imageDetails['height'] = this.firstChild.childNodes[i].attributes.height;
			this.$imageDetailsMap[i] = imageDetails;
		}

		for (var i = 0;i<this.firstChild.childNodes.length;i++)
		{	
			this.$imageURLs.push(this.firstChild.childNodes[i].firstChild.firstChild.nodeValue);
			this.$thumbURLs.push(this.firstChild.childNodes[i].attributes.thumbURL);
		}
		var e:org.caleb.event.Event = new org.caleb.event.Event('onZoomXMLReady');
		e.addArgument('xml', this)
		this.dispatchEvent(e);
	}
	/**
	 * 
	 * @usage   
	 * @param   v 
	 * @return  
	 */
	public function set controller(arg:ZoomController):Void
	{
		this.$controller = arg;
	}
	public function get imageCount():Number
	{
		return this.firstChild.childNodes.length
	}
	public function get imageDetailsMap():Array
	{
		return this.$imageDetailsMap;
	}
	public function get imageURLs():Array
	{
		return this.$imageURLs;
	}
	public function get thumbURLs():Array
	{
		return this.$thumbURLs;
	}
}