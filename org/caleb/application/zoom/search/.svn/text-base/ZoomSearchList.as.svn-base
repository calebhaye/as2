import org.caleb.collection.SimpleList;
import org.caleb.components.list.ListItem;
import org.caleb.components.list.List;
import org.caleb.util.SearchUtil;
import org.caleb.xml.SimpleXML;
import org.caleb.application.zoom.search.ZoomMediaSearch;
import org.caleb.animation.AnimationManager;

class org.caleb.application.zoom.search.ZoomSearchList extends List
{
	private var $view:ZoomMediaSearch;
	private var $label:TextField;
	private var $title:String;
	private var $isExpanded:Boolean;
	private var $animationManager:AnimationManager;
	private var $btnFormat:TextFormat;
	private var $labelFormat:TextFormat;
	private var $btn:MovieClip;
	private var $bg:MovieClip;

	public function ZoomSearchList()
	{
		this.setClassDescription('org.caleb.application.zoom.search.ZoomSearchList');
		//trace('constructor invoked')
		this.$isExpanded = false;
		this.$animationManager = new AnimationManager(this);
		//trace('constructor invoked');
		ListItem.LINKAGE_ID = 'list_item';
		
		this.$btn = this.createEmptyMovieClip('btn', this.getNextHighestDepth());
		this.$btn.onRelease = function():Void
		{
			this._parent.expandCollapse(!this._parent.isExpanded);
		}
		
		this.$btnFormat = new TextFormat;
		this.$btnFormat.font = 'extrasExported';
		this.$btnFormat.color = 0xFFFFFF;
		this.$btnFormat.size = 8;
				
		this.$labelFormat = new TextFormat;
		this.$labelFormat.font = 'gothamBookExported';
		this.$labelFormat.color = 0xFFFFFF;
		this.$labelFormat.size = 16;

		this.$label = this.$btn.createTextField('listLabel', this.$btn.getNextHighestDepth(), 0, 0, 165, 20);
		this.$label.embedFonts = true;
		
		this.$noMask = true;
	}
	private function closeOtherLists():Void
	{
		for(var i in _parent)
		{
			if(org.caleb.util.ObjectUtil.isInstanceOf(_parent[i], ZoomSearchList)
			   && _parent[i] != this)
			{
				_parent[i].expandCollapse(false);
			}
		}
	}
	public function expandCollapse(expand:Boolean):Boolean
	{
		if(expand == true && this.$isExpanded != true)
		{
			this.$label._x = 18;
			this.$label._y = -20;
			this.$label._rotation = 0;
			this.$label.text = 'Q ' + this.$title;
			this.$labelFormat.align = 'right';
			this.$label.setTextFormat(0, 1, this.$btnFormat);
			this.$label.setTextFormat(2, this.$title.length + 2, this.$labelFormat);
			this.$animationManager.tween(['_x', '_alpha'], [-(this.$view._width), 85], .25, undefined, undefined, [this, 'onListExpanded']);
			this.$animationManager = new AnimationManager(this.$view);
			this.$animationManager.tween('_alpha', 100, 1);
			this.$animationManager = new AnimationManager(this.$bg);
			this.$animationManager.tween('_alpha', 100, 1);
			this.$animationManager = new AnimationManager(this);
			this.$isExpanded = true;
			this.closeOtherLists();
		}
		else
		{
			this.$label._x = 0;
			this.$label._y = 127;
			this.$label._rotation = 270;
			this.$label.text = this.$title + ' P';
			this.$labelFormat.align = 'left';
			this.$label.setTextFormat(0, this.$title.length, this.$labelFormat);
			this.$label.setTextFormat(this.$title.length, this.$title.length + 2, this.$btnFormat);
			this.$animationManager.tween(['_x', '_alpha'], [-(this.$btn._width - 10), 30], .25, undefined, undefined, [this, 'onListCollapsed']);

			this.$animationManager = new AnimationManager(this.$view);
			this.$animationManager.tween('_alpha', 0, 1);
			this.$animationManager = new AnimationManager(this.$bg);
			this.$animationManager.tween('_alpha', 0, 1);
			this.$animationManager = new AnimationManager(this);

			this.$isExpanded = false;
		}
		
		return this.$isExpanded;
	}
	public function onListExpanded():Void
	{
		//trace('onListExpanded invoked')
	}
	public function onListCollapsed():Void
	{
		//trace('onListCollapsed invoked')
	}
	/**
	 * 
	 * @usage   
	 * @param   e 
	 * @return  
	 */
	public function onItemSelect(e:org.caleb.event.Event):Void
	{
		//trace('value: ' + e.getArgument('item')['$label'][1]);
		this.getURL("javascript:popUp('"+escape(String(e.getArgument('item')['$label'][1])) + "',800,800)");
	}
	/**
	 * 
	 * @usage   
	 * @param   searchType 
	 * @param   targetList 
	 * @return  
	 */
	public function populateList(searchType:String, xmlContext:XML)
	{
		org.caleb.util.MovieClipUtil.fadeIn(this, 1);
		this.$view._x = 20;
		var resultLength = xmlContext.firstChild.childNodes.length;
		var list:SimpleList = new SimpleList;
		var item:ListItem;
		var i:Number = 0;
		if(resultLength > 0)
		{
			//trace('populate list invoked : ' + resultLength)
			while(resultLength--)
			{
				var title:String = XML(xmlContext).firstChild.childNodes[i].childNodes[0].childNodes[0].nodeValue;
				var summary:String = XML(xmlContext).firstChild.childNodes[i].childNodes[1].childNodes[0].nodeValue;
				// todo: figure out why this URL doesn't work
				var itemURL:String = XML(xmlContext).firstChild.childNodes[i].childNodes[2].childNodes[0].nodeValue;
				var clickURL:String = XML(xmlContext).firstChild.childNodes[i].childNodes[3].childNodes[0].nodeValue;
				//trace('itemURL: ' + itemURL);
				if(title != '' && title != undefined)
				{
					item = new ListItem(title, clickURL);
				}
				else
				{
					item = new ListItem(itemURL, clickURL);
				}
				list.addElement(item);
				//trace('ListItem added titled: ' + title + ' w/ value: ' + clickURL);
				i++;
			}
		}
		switch(searchType)
		{
			case SearchUtil.YAHOO_WEB_SEARCH:
			{
				this.$title = 'Web Results';
				item = new ListItem('More...');
				item.data = 'http://search.yahoo.com/search?ei=UTF-8&fr=sfp&b=10&p=' + this.$view.intro.needle.text;
				list.addElement(item);
			}
			break;
			case SearchUtil.YAHOO_VIDEO_SEARCH:
			{
				this.$title = 'Video Results';
				item = new ListItem('More...');
				item.data = 'http://video.search.yahoo.com/search/video?ei=UTF-8&fr=sfp&b=10&p=' + this.$view.intro.needle.text;
				list.addElement(item);
			}
			break;
			case SearchUtil.YAHOO_NEWS_SEARCH:
			{
				this.$title = 'News Results';
				item = new ListItem('More...');
				item.data = 'http://news.search.yahoo.com/news/search?ei=UTF-8&fr=sfp&b=10&p=' + this.$view.intro.needle.text;
				list.addElement(item);
			}
			break;
		}
		//trace(this.$title + ' size: ' + list.size())
		this.operand = list;
		if(this.$bg == undefined)
		{
			this.$bg = org.caleb.util.DrawingUtil.drawRectangle(this, this.$view._width, this.$view._height, 20, 0, .25, 0xFFFFFF, 0x999999);
			this.$bg.swapDepths(this.getNextHighestDepth());
		}
		this.$bg._height = this.$view._height
		this.$view.swapDepths(this.getNextHighestDepth());
		this.closeOtherLists();
	}
	/**
	 * 
	 * @usage   
	 * @param   v 
	 * @return  
	 */
	public function set view(v:ZoomMediaSearch):Void
	{
		this.$view = v;
	}
	public function get isExpanded():Boolean
	{
		return this.$isExpanded;
	}	
	public function get title():String
	{
		return this.$title;
	}	
}