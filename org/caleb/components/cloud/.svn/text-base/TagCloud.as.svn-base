import mx.xpath.XPathAPI;
import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.event.Event;

class org.caleb.components.cloud.TagCloud extends ObservableMovieClip
{
	static var SymbolName:String = '__Packages.org.caleb.components.cloud.TagCloud';
	static var SymbolLinked = Object.registerClass(SymbolName, TagCloud);

	public static var CLOUD_XML_URL:String = 'cloud.xml';
	public static var CSS_URL:String = 'http://mig.corp.scd.yahoo.com/phugc/www/flash/tagCloud.css';
	private var statement:String;
	private var scale:Number;
	private var cloud_nav:MovieClip
	private var display:TextField;
	private var links:TextField;
	private var $userId:Number;
	private var $xml:org.caleb.xml.SimpleXML;
	
	public function TagCloud()
	{
		this.setClassDescription('org.caleb.components.cloud.TagCloud');
		trace('constructor invoked');
		this.init(_parent._parent.userId, _parent._parent.yahooUsername);
	}
	public function init(userId:Number, yahooUsername:String):Void
	{
		this.$userId = userId;
		this.display.autoSize = true;
		this.display.text = 'Tags ' + yahooUsername + ' uses:';
		this.cloud_nav._x = this.display._x + this.display._width + 3;
        this.statement = new String;
		this.loadCSS(TagCloud.CSS_URL);
		this.loadXML(TagCloud.CLOUD_XML_URL);
	}
	private function loadCSS(cssURL):Void
	{
		var myCSS = new TextField.StyleSheet();
		myCSS.links = links;
		myCSS.onLoad = function(success)
		{
			if(success)
			{
				trace('CSS loaded');
				links.styleSheet = myCSS;
			}
		}
		myCSS.load(cssURL);
	}
	private function loadXML(xmlURL:String):Void
	{
		this.$xml = new org.caleb.xml.SimpleXML();
		this.$xml.addEventObserver(this, 'onParseSuccess');
		this.$xml.load(xmlURL);
	}
	public function onParseSuccess():Void
	{
		this.dispatchEvent(new Event('onTagCloudReady', new Array));
		var namePath:String = "/Cloud/Tags/Tag/Name";
		var name_array = mx.xpath.XPathAPI.selectNodeList(this.$xml.firstChild, namePath);
		
		var scalePath:String = "/Cloud/Tags/Tag/Scale";
		var scale_array = mx.xpath.XPathAPI.selectNodeList(this.$xml.firstChild, scalePath);
		
		var titlePath:String = "/Cloud/Tags/Tag/Link";
		var title_array = mx.xpath.XPathAPI.selectNodeList(this.$xml.firstChild, titlePath);
        	
		links.text = "";
        for (var i = 0; i < title_array.length; i++) 
		{
            scale = Number(scale_array[i].firstChild.nodeValue);
            switch(scale)
			{
				case 1:
					scale = 14;
					break;
				case 2:
					scale = 17;
					break;
				case 3:
					scale = 20;
					break;
				case 4:
					scale = 23;
					break;
				case 5:
					scale = 26;
					break;
				case 6:
					scale = 29;
					break;
				case 7:
					scale = 32;
					break;
				case 8:
					scale = 35;
					break;
				case 9:
					scale = 38;
					break;
            }
            
            statement += "<a href='" + title_array[i].firstChild.nodeValue + "'><font size='" + scale + "'>" + name_array[i].firstChild.nodeValue + "</font></a>&nbsp;";
            statement += " ";
        }        
        links.htmlText = statement;
	}
}