import org.caleb.xml.SimpleXML;
import org.caleb.search.CoreSearchResult;
import org.caleb.application.zoom.ZoomXML;
import org.caleb.application.zoom.search.ZoomSearchController;
import org.caleb.flickr.Photo;

class org.caleb.application.zoom.search.ZoomSearchXML extends ZoomXML
{
	private var $controller:ZoomSearchController;

	public function ZoomSearchXML()
	{
		this.setClassDescription('org.caleb.application.zoom.ZoomSearchXML');
		//trace('constructor invoked');
	}
	public static function getSearchResults(x:XML):CoreSearchResult
	{
		var searchResults:CoreSearchResult;
		//todo:
		return searchResults;
	}
	private function doParse(x:XML)
	{
		trace('doParse invoked, x: ' + x);
		super.doParse(x);
		
		var resultLength = x.firstChild.childNodes.length;
		this.$controller.totalResultsAvailable = x.firstChild.attributes.totalResultsAvailable;
		this.$controller.totalResultsReturned = x.firstChild.attributes.totalResultsReturned;
		this.$controller.firstResultPosition = x.firstChild.attributes.firstResultPosition;
		
		if(this.$controller.totalResultsAvailable > 1000)
		{
			this.$controller.totalResultsAvailable = 1000;
		}
	}
	public static function getFlickrZoomXML(x:XML, photos:Array):SimpleXML
	{
		trace('getFlickrZoomXML invoked');
		trace("x: \n" + x)
		var returnXML:SimpleXML = new SimpleXML;
		var rootNode:XMLNode = returnXML.createElement('GALLERY_DATA');
		rootNode.attributes.cellDimension = "800";
		rootNode.attributes.columns="5";
		rootNode.attributes.zoomOutPerc="15";
		rootNode.attributes.zoomInPerc="100"; 
		rootNode.attributes.frameWidth="10";
		rootNode.attributes.totalResultsAvailable = x.firstChild.attributes.total;
		rootNode.attributes.totalResultsReturned = x.firstChild.attributes.perpage;
		rootNode.attributes.firstResultPosition = Number(Number(x.firstChild.attributes.page) * Number(x.firstChild.attributes.perpage)) - (Number(x.firstChild.attributes.perpage) - 1);
		
		trace('(' + Number(x.firstChild.attributes.page) + ' * ' + Number(x.firstChild.attributes.perpage) + ') - (' + Number(x.firstChild.attributes.perpage) + ' - 1)')
		
		
		trace('rootNode.attributes.firstResultPosition: ' + rootNode.attributes.firstResultPosition);
		for(var i in photos[0]) trace('key: ' + i + ', value: ' + photos[0][i]);
		
		var resultLength = photos.length;
		var i:Number = 0;
		var image:XMLNode;
		var imageURL:XMLNode;
		var imageURLData:XMLNode;
		while(resultLength--)
		{
			var thumb:String = photos[i].smallSquareURL;
			var data:String = photos[i].smallURL;
			var name:String = photos[i].title;
			var size:String = x.firstChild.childNodes[i].childNodes[5].childNodes[0].nodeValue;
			var h:String = x.firstChild.childNodes[i].childNodes[7].childNodes[0].nodeValue;
			var w:String = x.firstChild.childNodes[i].childNodes[8].childNodes[0].nodeValue;
			image = returnXML.createElement('image');
			image.attributes.filesize = size;
			image.attributes.width = w;
			image.attributes.height = h;
			image.attributes.name = name;
			image.attributes.thumbURL = thumb;
			imageURL = returnXML.createElement('url');
			imageURLData = returnXML.createTextNode(data);
			imageURL.appendChild(imageURLData);
			image.appendChild(imageURL);
			rootNode.appendChild(image);
			i++;
		}

		returnXML.appendChild(rootNode);
		// trace('success: '+success);
		trace("returnXML: \n" + returnXML)

		return returnXML;
	}
	public static function getYahooImageSearchZoomXML(x:XML):SimpleXML
	{
		var returnXML:SimpleXML = new SimpleXML;
		var rootNode:XMLNode = returnXML.createElement('GALLERY_DATA');
		rootNode.attributes.cellDimension = "800";
		rootNode.attributes.columns="5";
		rootNode.attributes.zoomOutPerc="15";
		rootNode.attributes.zoomInPerc="100"; 
		rootNode.attributes.frameWidth="10";
		rootNode.attributes.totalResultsAvailable = x.firstChild.attributes.totalResultsAvailable;
		rootNode.attributes.totalResultsReturned = x.firstChild.attributes.totalResultsReturned;
		rootNode.attributes.firstResultPosition = x.firstChild.attributes.firstResultPosition
		
		var resultLength = x.firstChild.childNodes.length;
		var i:Number = 0;
		var image:XMLNode;
		var imageURL:XMLNode;
		var imageURLData:XMLNode;
		while(resultLength--)
		{
			var thumb:String = x.firstChild.childNodes[i].childNodes[9].childNodes[0].childNodes[0].nodeValue;
			var data:String = x.firstChild.childNodes[i].childNodes[2].childNodes[0].nodeValue;
			var name:String = x.firstChild.childNodes[i].childNodes[0].childNodes[0].nodeValue;
			var size:String = x.firstChild.childNodes[i].childNodes[5].childNodes[0].nodeValue;
			var h:String = x.firstChild.childNodes[i].childNodes[7].childNodes[0].nodeValue;
			var w:String = x.firstChild.childNodes[i].childNodes[8].childNodes[0].nodeValue;
			image = returnXML.createElement('image');
			image.attributes.filesize = size;
			image.attributes.width = w;
			image.attributes.height = h;
			image.attributes.name = name;
			image.attributes.thumbURL = thumb;
			imageURL = returnXML.createElement('url');
			imageURLData = returnXML.createTextNode(data);
			imageURL.appendChild(imageURLData);
			image.appendChild(imageURL);
			rootNode.appendChild(image);
			i++;
		}

		returnXML.appendChild(rootNode);
		// trace('success: '+success);
		// trace('returnXML: '+returnXML)
		
		//trace("returnXML: \n" + returnXML)

		return returnXML;
	}
}