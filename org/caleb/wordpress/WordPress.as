import org.caleb.xml.SimpleXML;
import org.caleb.util.TraceUtil;
import org.caleb.util.StringUtil;
import org.caleb.event.Event;
import org.caleb.event.ObservableObject;
import org.caleb.wordpress.WordPressPage;
import org.caleb.wordpress.WordPressPosting;
import org.caleb.wordpress.WordPressCategory;

class org.caleb.wordpress.WordPress extends ObservableObject
{
	public static var TEMPLATE_DEFAULT:Number = 0x000000;
	public static var BLOG_URL:String = 'http://mig.corp.yahoo.com/blog/?foo=bar';
	private static var HOME_PAGE_KEY:String = 'home';
	private var $templateToParse:Number;
	private var $categoriesToDisplay:Array;
	private var $xmlList;
	private var $categories:Array;
	private var $homepage:WordPressPage;
	
	public function WordPress(observer:Object, template:Number)
	{
		this.setClassDescription('org.caleb.wordpress.WordPress');
		// set the recursion level on TraceUtil
		TraceUtil.RECURSION_DEPTH = 20;	
		
		this.addEventObserver(observer, 'onHomePageLoaded');
		this.addEventObserver(observer, 'onCategoriesLoaded');
		this.$templateToParse = template;
		this.$categoriesToDisplay = new Array;

		this.$xmlList = new Array;
	}
	public function loadHomePage():Void
	{
		var xmlURL:String = WordPress.BLOG_URL;
		// create a new SimpleXML
		this.$xmlList[HOME_PAGE_KEY] = new SimpleXML();
		// listen to the onParseSuccess event
		this.$xmlList[HOME_PAGE_KEY].addEventObserver(this, 'onParseSuccess');
		// load the XML
		this.$xmlList[HOME_PAGE_KEY].load(xmlURL);
	}
	public function loadCategories():Void
	{
		if(arguments == undefined)
		{
			return;
		}
		this.$categoriesToDisplay = new Array;
		for(var i:Number = 0; i < arguments.length; i++)
		{
			this.$categoriesToDisplay.push(arguments[i]);
		}
		this.$categories = new Array;
		this.getCategories();
	}
	public function onParseSuccess(e:org.caleb.event.Event)
	{
		var url:String = e.getArgument('SimpleXML').filePath;
		if(url == BLOG_URL)
		{
			this.viewHomePagePosts();
		}
		else
		{
			var categoryId:Number = Number(url.substr(url.length-1, url.length));
			this.$categories.push(this.viewCategoryPosts(categoryId));
			this.categoriesLoadCheck();
		}
	}
	private function getCategories():Void
	{
		switch(this.$templateToParse)
		{
			case WordPress.TEMPLATE_DEFAULT:
			{
				// get categories
				for (var a:Number = 0; a < this.$categoriesToDisplay.length; a++)
				{
					this.getPosts(this.$categoriesToDisplay[a]);
				}
			}
			break;
		}
	}
	private function getPosts(categoryId:Number)
	{
		var xmlURL:String = WordPress.BLOG_URL + '?cat=' + categoryId;
		// create a new SimpleXML
		this.$xmlList[categoryId] = new SimpleXML();
		// listen to the onParseSuccess event
		this.$xmlList[categoryId].addEventObserver(this, 'onParseSuccess');
		// load the XML
		this.$xmlList[categoryId].load(xmlURL);
	}
	private function viewCategoryPosts(categoryId:Number):WordPressCategory
	{
		var category:WordPressCategory = new WordPressCategory(categoryId);
		var wordpress:Object = this.$xmlList[categoryId].toObject();
		this.createPostings(category, wordpress.html.body.div.div[1].div);

		return category;
	}
	private function viewHomePagePosts():Void
	{
		var page:WordPressPage = new WordPressPage(HOME_PAGE_KEY);
		var wordpress:Object = this.$xmlList[HOME_PAGE_KEY].toObject();
		this.createPostings(page, wordpress.html.body.div.div[1].div);

		this.$homepage = page;

		trace('BLOG HOMEPAGE LOADED');
		var args:Array = new Array;
		args['homepage'] = this.$homepage;
		var e = new Event('onHomePageLoaded', args);
		this.dispatchEvent(e);
	}
	private function createPostings(page:WordPressPage, htmlDiv:Object)
	{
		var posting:WordPressPosting;
		var totalPosts:Number = (htmlDiv.length - 2);
		
		// BEGIN CATEGORY
		for(var i:Number = 0; i <= totalPosts; i++)
		{
			// BEGIN POST
			posting = new WordPressPosting;
			
			posting.title =  htmlDiv[i].h2.a.data;
			posting.date =  htmlDiv[i].small.data;
			
			var postingCategories:String = new String;
			var numberOfCategories:Number = htmlDiv[i].p.a.length - 1;
			for(var ii:Number = 0; ii < numberOfCategories; ii++)
			{
				posting.categories.push(htmlDiv[i].p.a[ii].data);
			}
			
			posting.comments = StringUtil.strip(htmlDiv[i].p.a[htmlDiv[i].p.a.length - 1].data);
			
			var singleParagraph:String = htmlDiv[i].div.p.data;
	
			var singleParagraphPosting:Boolean = (singleParagraph != undefined);
			if(singleParagraphPosting)
			{
				posting.body = StringUtil.strip(singleParagraph)
			}
			else
			{
				var paragraphs:Array = htmlDiv[i].div.p;
				for(var iii:Number = 0; iii < paragraphs.length; iii++)
				{
					posting.body += paragraphs[iii].data + "\n\n";
				}
			}
			// END POST
			page.postings.push(posting);
		}
	}
	private function categoriesLoadCheck():Void
	{
		if(this.$categories.length == this.$categoriesToDisplay.length)
		{
			var args:Array = new Array;
			args['categories'] = this.$categories;
			var e = new Event('onCategoriesLoaded', args);
			this.dispatchEvent(e);
		}
	}
	/**
	* Accessor for private $categories var.
	* @return Array of WordPressCategory objects.
	**/	
	public function get categories():Array
	{
		return this.$categories;
	}
	/**
	* Accessor for private $homepage var.
	* @return Array of WordPressCategory objects.
	**/	
	public function get homepage():WordPressPage
	{
		return this.$homepage;
	}
}
