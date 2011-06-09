import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.util.DrawingUtil;
import org.caleb.util.MovieClipUtil;
import org.caleb.components.list.List;
import org.caleb.event.Event;
import org.caleb.components.list.SimpleListView;

class org.caleb.components.list.ListItem extends ObservableMovieClip
{
	static var SymbolName:String = '__Packages.org.caleb.components.list.ListItem';
	static var SymbolLinked = Object.registerClass(SymbolName, ListItem);
	
	public static var LINKAGE_ID:String = 'list_item';
	public static var FOCUS_FRAME:String = 'focused';
	public static var SELECTED_FRAME:String = 'selected';
	public static var DEFAULT_FRAME:String = 'default';
	// from fla
	private var checkOn:MovieClip;
	private var checkOff:MovieClip;
	//
	private var $linkageId:String;	
	private var $list:SimpleListView;
	private var $context:Object;
	private var $index:Number;
	private var $nextIndex:Number;
	private var $previousIndex:Number;
	private var $label:String;
	private var $icon:MovieClip;
	private var $data:Object;
	private var $focused:Boolean;
	private var $selected:Boolean;
	private var $selectable:Boolean;
	private var $tween;
	private var $speed:Number;
	private var $debug:Boolean = false;
	
	public function ListItem()
	{
		this.setClassDescription('org.caleb.components.list.ListItem');
		this.handleInit(arguments);
		this.$context = new Object;
		this.$speed = .18
		this.$selected = false;
		this.$linkageId = ListItem.LINKAGE_ID;
		this.focus(false);
		this.$icon = this.createEmptyMovieClip('icon', this.getNextHighestDepth());
	}
	private function handleInit(arguments:Array)
	{
		if(arguments[0] != undefined)
		{
			this.$label = arguments[0];
			if(arguments[1] != undefined)
			{
				this.$data = arguments[1];
			}
		}
	}
	private function makeVisible()
	{
		var tweenCandidate = false;
		var relativeY = Number(this._y + this.list._y);
		var relativeX = Number(this._x + this.list._x);
		var ease:Object;
		var begin:Number;
		var end:Number;
		var time:Number;
		if(this.list.horizontal == true)
		{
			// this.trace(relativeX + '+ > (' +this.list.startingX+' + '+this.list.maskWidth+') - ' + this._width + ')')
			if(relativeX < this.list.startingX)
			{
				//this.trace('tween right')
				tweenCandidate = true;
				// move right
				ease  = mx.transitions.easing.Strong.easeIn;
				begin = this.list._x;
				end   = begin + this._width;
				time = this.$speed;
				if(this.list.carousel == true)
				{
					// reposition previous (item to the left) for carousel effect
					this.list.items[this.$previousIndex]._x = this._x - this._width;
				}
			}
			else if(relativeX > (((this.list.startingX - this.list.maskOffsetX) + this.list.maskWidth) - this._width))
			{
				//this.trace('tween left')
				tweenCandidate = true;
				// move left
				ease  = mx.transitions.easing.Strong.easeIn;
				begin = this.list._x;
				end   = begin - this._width;
				time = this.$speed;
				if(this.list.carousel == true)
				{
					// reposition next (item to the right) for carousel effect
					this.list.items[this.$nextIndex]._x = this._x + this._width;
				}
			}
		}
		else
		{
			if(relativeY < this.list.startingY)
			{
				tweenCandidate = true;
				// move down
				ease  = mx.transitions.easing.Strong.easeIn;
				begin = this.list._y;
				end   = begin + this._height;
				time = this.$speed;
				if(this.list.carousel == true)
				{
					// reposition previous (item above) for carousel effect
					this.list.items[this.$nextIndex]._y = this._y - this._height;
				}
			}
			else if(relativeY > ((this.list.startingY + this.list.maskHeight) - (this._height * 2)))
			{
				tweenCandidate = true;
				// move up
				ease  = mx.transitions.easing.Strong.easeIn;
				begin = this.list._y;
				end   = begin - this._height;
				time = this.$speed;
				if(this.list.carousel == true)
				{
					// reposition next (item beneath) for carousel effect
					this.list.items[this.$nextIndex]._y = this._y + this._height;
				}
			}
		}
		if(tweenCandidate == true && this.list.autoScroll == true)
		{
			// lock
			this.list.locked = true;
			// tween
			if(this.list.horizontal)
			{
				this.$tween = new mx.transitions.Tween(this.list, "_x", ease, begin, end, time, true);
			}
			else
			{
				this.$tween = new mx.transitions.Tween(this.list, "_y", ease, begin, end, time, true);
			}
			this.$tween.content = this;
			this.$tween.onMotionFinished = function(obj)
			{
				obj.content.list.locked = false;
				obj.content.onMotionFinished(obj.content.genericEvent('onMotionFinished'));
			}
		}
	}
	private function doFocus():Void
	{
		// make visible
		this.makeVisible();
		// focus
		this.gotoAndStop(ListItem.FOCUS_FRAME);
	}
	public function genericEvent(type:String):Event
	{
		// dispatch event
		var eventArgs = new Array();
		eventArgs['item'] = this;
		var e = new Event(type,eventArgs);
		
		return e;
	}
	
	private function toggleCheck(b:Boolean)
	{
		//this.trace('toggleCheck invoked w/ b: '+b);
		this.checkOn._visible = b;
		this.checkOff._visible = !b;
	}
	private function focus(b:Boolean)
	{
		var wasFocused = this.$focused;
		this.$focused = b;
		if(b == true)
		{
			this.list.blurAll();
			this.$list.focusedListItem = this;
			this.onFocus(this.genericEvent('onFocus'));
			// this.trace('[ListItem.focus] focused item at index position: ' + this.$index);
			if(this.list.locked == false)
			{
				this.doFocus();
			}
		}
		else
		{
			this.onBlur(this.genericEvent('onBlur'));
			// this.trace('[ListItem.focus] de-focused item at index position: ' + this.$index);
			if(this.$selected == true)
			{
				this.gotoAndStop(ListItem.SELECTED_FRAME);
			}
			else
			{
				this.gotoAndStop(ListItem.DEFAULT_FRAME);
			}
		}
	}
	private function select(b:Boolean)
	{
		//this.trace('select invoked');
		if(this.$selectable != false)
		{
			if(b == true)
			{
				this.onSelect(this.genericEvent('onSelect'));
				// this.trace('[ListItem.select] selected item at index position: ' + this.$index);
				if(this.$focused == true)
				{
					this.gotoAndStop(ListItem.FOCUS_FRAME);
				}
				else
				{
					this.gotoAndStop(ListItem.SELECTED_FRAME);
				}
			}
			else
			{
				this.onDeselect(this.genericEvent('onDeselect'));
				// this.trace('[ListItem.select] de-selected item at index position: ' + this.$index);
				this.focus(this.$focused)
				//this.gotoAndStop(ListItem.DEFAULT_FRAME);
			}
		}
	}
	// read only
	public function get cleanId():String
	{
		var cleanId = org.caleb.util.StringUtil.replace(this.$label,' ','');
		cleanId = org.caleb.util.StringUtil.replace(cleanId,'/','');
		cleanId = org.caleb.util.StringUtil.replace(cleanId,':','');
		cleanId = org.caleb.util.StringUtil.replace(cleanId,'&','');
		
		return cleanId;
	}
	public function get offstage():Boolean
	{
		if(this.list.horizontal == true)
		{
			if(((this._x + this._width + this.list._x) < 0) || ((this._x + this._width + this.list._x) > this.list.maskWidth))
			{
				return true;
			}
		}
		else
		{			
			if(((this._y + this._height) < 0) || ((this._y + this._height) > this.list.maskHeight))
			{
				return true;
			}
		}
		
		return false;		
	}
	// get / set
	public function get index():Number
	{
		return this.$index;
	}
	public function set index(idx:Number)
	{
		this.$index = idx;
	}
	public function get previousIndex():Number
	{
		return this.$previousIndex;
	}
	public function set previousIndex(idx:Number)
	{
		this.$previousIndex = idx;
	}
	public function get nextIndex():Number
	{
		return this.$nextIndex;
	}
	public function set nextIndex(idx:Number)
	{
		this.$nextIndex = idx;
	}
	public function get label():String
	{
		return this.$label;
	}
	public function set label(l:String)
	{
		this.$label = l;
		this.$list.operand.getElementAtIndex(this.index).label = l;
	}
	public function get icon():MovieClip
	{
		return this.$icon;
	}
	public function set icon(mc:MovieClip)
	{
		this.$icon = mc;
		this.$list.operand.getElementAtIndex(this.$index).icon = mc;
	}
	public function get data():Object
	{
		return this.$data;
	}
	public function set data(obj:Object)
	{
		this.$data = obj;
		this.$list.operand.getElementAtIndex(this.index).data = obj;
	}
	public function get context():Object
	{
		return this.$context;
	}
	public function set context(obj:Object)
	{
		this.$context = obj;
	}
	private function setSelected(b:Boolean):Void
	{
		//this.trace('setSelected invoked')
		if(this.$selectable != false && this.list.locked != true)
		{
			if(b == true && this.list.multipleSelection == false)
			{
				this.$list.deselectAll();
			}
			if(b == false && this.list.selectedItems.length <= this.list.minimumSelection && this.list.minimumSelection > 0)
			{
				return;
			}
			this.$selected = b;
			this.select(b);
			this.toggleCheck(this.$selected);
		}
	}
	public function get selected():Boolean
	{
		return this.$selected;
	}
	public function set selected(b:Boolean)
	{
		this.setSelected(b);
	}
	private function setFocused(b:Boolean):Void
	{
		this.$focused = b;	
		this.$list.operand.getElementAtIndex(this.index).focused = b;
		this.focus(b);
	}
	public function get focused():Boolean
	{
		return this.$focused;
	}
	public function set focused(b:Boolean)
	{
		this.setFocused(b);
	}
	private function setSelectable(b:Boolean):Void
	{
		this.$selectable = b;
		this.$list.operand.getElementAtIndex(this.index).selectable = b;
	}
	public function get selectable():Boolean
	{
		return this.$selectable;
	}
	public function set selectable(b:Boolean)
	{
		this.setSelectable(b);
	}
	public function get list():SimpleListView
	{
		return this.$list;
	}
	public function set list(l:SimpleListView)
	{
		this.$list = l;
	}
	public function get linkageId():String
	{
		return this.$linkageId;
	}
	public function set linkageId(s:String):Void
	{
		this.$linkageId = s;
		this.$list.paint();
	}
	private function onSelect(e):Void
	{
		if(e == undefined)
		{
			throw('onSelect event is undefined')
		}
		else
		{
			e.setType('onSelect');
			this.dispatchEvent(e);
		}
	}
	private function onDeselect(e):Void
	{
		if(e == undefined)
		{
			throw('onDeselect event is undefined')
		}
		else
		{
			e.setType('onDeselect');
			this.dispatchEvent(e);
		}
	}
	private function onMotionFinished(e):Void
	{
		if(e == undefined)
		{
			throw('onMotionFinished event is undefined')
		}
		else
		{
			e.setType('onMotionFinished');
			this.dispatchEvent(e);
		}
	}
	private function onFocus(e):Void
	{
		//this.trace('onFocus invoked');
		if(e == undefined)
		{
			throw('onFocus event is undefined')
		}
		else
		{
			//this.trace('dispatching onFocus event');
			e.setType('onFocus');
			this.dispatchEvent(e);
		}
	}
	private function onBlur(e):Void
	{
		if(e == undefined)
		{
			throw('onBlur event is undefined')
		}
		else
		{
			e.setType('onBlur');
			this.dispatchEvent(e);
		}
	}
	public function onReleaseHandler():Void
	{
		//this.trace('onRelease invoked')
		if(this.$list.ignoreMouse != true)
		{
			if(this.$list.itemsDeselectable != false)
			{
				this.setSelected(!this.$selected);
			}
			else
			{
				this.setSelected(true);
			}
		}
	}
	public function onRollOverHandler():Void
	{
		if(this.$list.ignoreMouse != true)
		{
			this.setFocused(true);
		}
	}
	public function onRollOutHandler():Void
	{
		if(this.$list.ignoreMouse != true)
		{
			this.setFocused(false);
		}
	}
	public function loadIcon(url:String, w:Number, h:Number):Void
	{
		if(w > 0 && h > 0)
		{
			DrawingUtil.drawMask(this, w, h);
		}
		MovieClipUtil.loadContent(this.$icon, url, 0, 0);
	}
	public function draw():Void
	{
		//this.trace('draw invoked');
		DrawingUtil.drawRectangle(this, 100, 50, 0, 0, .25, 0x666666, 0x999999);
		//var $txt:TextField = TextField(this.createTextField('$txt', this.getNextHighestDepth(), 0, 0, 100, 50));
		//this.$txt.text = 'foo';
		//this.trace('$txt: ' + $txt);
//		$txt.variable = 'label';
	}
}