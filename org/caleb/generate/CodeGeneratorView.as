import org.caleb.movieclip.CoreMovieClip;
import org.caleb.generate.CodeGenerator;
import org.caleb.collection.SimpleList;
import org.caleb.components.list.ListItem;
import org.caleb.util.StringUtil;

class org.caleb.generate.CodeGeneratorView extends CoreMovieClip
{
	public function CodeGeneratorView()
	{
		trace('constructor invoked');
		CodeGenerator.PARSE_XML = false;
		this.init();
	}
	public func
	//CodeGenerator.PARSE_PHP = false;
	
	/*
	var FLICKR_API_KEY:String = '1a008492633952aa82bcff2081dbc931';
	var tagSearch:String = 'http://www.flickr.com/services/rest/?method=flickr.photos.search&api_key='+FLICKR_API_KEY+'&tags=monkey&per_page=10&page=2';
	var relatedTags:String = 'http://www.flickr.com/services/rest/?method=flickr.tags.getRelated&api_key='+FLICKR_API_KEY+'&tag=monkey';
	var webSearch:String = 'http://api.search.yahoo.com/WebSearchService/V1/webSearch?appid=YahooDemo&query=madonna&results=2';
	var imageSearch:String = 'http://api.search.yahoo.com/ImageSearchService/V1/imageSearch?appid=YahooDemo&query=Madonna&results=2';
	*/
	var phugcData:String = 'http://mig.corp.yahoo.com/phugc/phugc.xml';
	var phugcPrefix:String = 'Phugc';
	var phugcPackage:String = 'org.caleb.phugc';
	var generator:CodeGenerator = new CodeGenerator;
	generator.addEventObserver(this, 'onObjectSaved');
	generator.addEventObserver(this, 'onAllObjectsSaved');
	//generator.init(tagSearch, 'Flickr', 'org.caleb.flickr');
	//generator.init(relatedTags, 'Flickr', 'org.caleb.flickr');
	//generator.init(webSearch, 'YahooSearch', 'org.caleb.search');
	//generator.init(imageSearch, 'YahooSearch', 'org.caleb.search');
	if(_root.dataURL == undefined)
	{
		dataURLInput.text = phugcData;
	}
	if(_root.dataPrefix == undefined)
	{
		dataPrefixInput.text = phugcPrefix;
	}
	if(_root.dataPackage == undefined)
	{
		dataPackageInput.text = phugcPackage;
	}
	
	this.listHeaders._visible = false;
	
	var actionscriptList:SimpleList = new SimpleList;
	var actionscriptTestList:SimpleList = new SimpleList;
	var phpTestList:SimpleList = new SimpleList;
	var phpSourceList:SimpleList = new SimpleList;
	var phpServicesList:SimpleList = new SimpleList;
	
	this.actionscriptListView.multipleSelection= false;
	this.actionscriptListView.paint();
	this.actionscriptListView.onItemSelect = function(e)
	{
		var item = e.getArgument('item');
		getURL(item.data, '_blank');
		item.list.deselectAll();
	}
	
	this.actionscriptTestListView.multipleSelection= false;
	this.actionscriptTestListView.paint();
	this.actionscriptTestListView.onItemSelect = function(e)
	{
		var item = e.getArgument('item');
		getURL(item.data, '_blank');
		item.list.deselectAll();
	}
	
	this.phpListView.multipleSelection= false;
	this.phpListView.paint();
	this.phpListView.onItemSelect = function(e)
	{
		var item = e.getArgument('item');
		getURL(item.data, '_blank');
		item.list.deselectAll();
	}
	
	this.phpTestListView.multipleSelection= false;
	this.phpTestListView.paint();
	this.phpTestListView.onItemSelect = function(e)
	{
		var item = e.getArgument('item');
		getURL(item.data, '_blank');
		item.list.deselectAll();
	}
	
	this.phpServicesListView.multipleSelection= false;
	this.phpServicesListView.paint();
	this.phpServicesListView.onItemSelect = function(e)
	{
		var item = e.getArgument('item');
		getURL(item.data, '_blank');
		item.list.deselectAll();
	}
	
	function onObjectSaved(e:org.caleb.event.Event):Void
	{
		var obj:Object = e.getArgument('object');
		var item:ListItem = new ListItem(obj.filename);
		item.data = CodeGenerator.FILE_SAVE_WWWPATH 
				  + StringUtil.replace(obj.path, CodeGenerator.FILE_SAVE_BASEPATH, '')
				  + obj.filename;
	
		if(StringUtil.endswith(obj.filename, 'Test.php') && StringUtil.startswith(obj.path, CodeGenerator.FILE_SAVE_BASEPATH + 'tests') == true)
		{
			item.label = StringUtil.replace(obj.filename, '.php', '');
			item.data = 'http://mig.corp.scd.yahoo.com/amfphp/browser/details.php'+'?class='
			+ '/generated/'
			+ item.label;
			phpTestList.addElement(item);
		}
		if(StringUtil.endswith(obj.filename, '.php') && !StringUtil.endswith(obj.filename, 'Test.php'))
		{
			item.label = StringUtil.replace(obj.filename, '.php', '');
			phpServicesList.addElement(item);
		}
		else if(StringUtil.endswith(obj.filename, '.phps'))
		{
			item.label = StringUtil.replace(obj.filename, '.phps', '');
			phpSourceList.addElement(item);
		}
		else if(StringUtil.endswith(obj.filename, 'Test.as') && StringUtil.startswith(obj.path, CodeGenerator.FILE_SAVE_BASEPATH + 'tests'))
		{
			actionscriptTestList.addElement(item);
		}
		else if(StringUtil.endswith(obj.filename, '.as'))
		{
			actionscriptList.addElement(item);
		}
		// trace(item.label + ': ' + item.data);
	}
	function onAllObjectsSaved(e:org.caleb.event.Event):Void
	{
		this.submit._visible = false;
		xmlUrlText.text = generator.xmlURL;
		
		this.phpListView.operand = phpSourceList;
		this.phpTestListView.operand = phpTestList;
		this.phpServicesListView.operand = phpServicesList;
		this.actionscriptListView.operand = actionscriptList;
		this.actionscriptTestListView.operand = actionscriptTestList;
		this.listHeaders._visible = true;
	}
	
	this.submit.onRelease = function():Void
	{
		if(this._alpha != 35)
		{
			this._alpha = 35;
			this._parent.listHeaders._visible = false;
			this._parent.generator.init(dataURLInput.text, dataPrefixInput.text, dataPackageInput.text);
		}
	}
	
}