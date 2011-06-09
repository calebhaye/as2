import org.caleb.components.list.ListItem;
import org.caleb.collection.SimpleList;
import org.caleb.movieclip.ObservableMovieClip;

class org.caleb.components.list.SimpleListView extends ObservableMovieClip 
{
	private var $operand:SimpleList;
	private var $tmpItem:ListItem;
	private var $focusedListItem:ListItem;
	private var $selectedItem:ListItem;
	private var $context:Object;
	private var $items:Array;
	private var $selectedItems:Array;
	private var $selectedIndices:Array;
	private var $carousel:Boolean;
	private var $locked:Boolean;
	private var $noMask:Boolean;
	private var $initMouseHandlers:Boolean;
	private var $ignoreMouse:Boolean;
	private var $horizontal:Boolean;
	private var $autoScroll:Boolean;
	private var $itemsDeselectable:Boolean;
	private var $multipleSelection:Boolean;
	private var $selectable:Boolean;
	private var $selectedIndex:Number;
	private var $maskWidth:Number;
	private var $maskHeight:Number;
	private var $minimumSelection:Number;
	private var $offstageIndex:Number;
	private var $mask_id:String = 'listMask_';
	private var $view:MovieClip;
	private var $mask:MovieClip;
	private var $startingX:Number;
	private var $startingY:Number;
	private var $rowCount:Number;
	private var $templateItem:MovieClip;
	private var $maskOffsetX:Number;
	private var $maskOffsetY:Number;

	public function SimpleListView()
	{
		this.setClassDescription('org.caleb.components.list.SimpleListView');
		//this.trace('constructor invoked')
		// default values
		this.$mask_id = 'listMask_';
		this.$selectable = true;
		this.$itemsDeselectable = true;
		this.$maskHeight = 300;
		this.$maskWidth = 200;
		this.$minimumSelection = 0;
		this.$locked = false;
		this.$horizontal = false;
		this.$multipleSelection = true;
		this.$offstageIndex = 0;
		this.$initMouseHandlers = true;
		// init objects
		this.$view = this.createEmptyMovieClip('view',this.getNextHighestDepth());
		this.$items = new Array;
		this.$startingX = this._x;
		this.$startingY = this._y;
		this.$maskOffsetY = 0;
		this.$maskOffsetX = 0;
	}
	/*
	* Handle keyboard interaction
	*/
	public function handleKeyDown() 
	{
		switch(Key.getCode())
		{
			case Key.LEFT:
				if(this.$horizontal == true)
				{
					this.next();
				}
				break;
			case Key.RIGHT:
				if(this.$horizontal == true)
				{
					this.previous();
				}
				break;
			case Key.DOWN:
				if(this.$horizontal == false)
				{
					this.next();
				}
				break;
			case Key.UP:
				if(this.$horizontal == false)
				{
					this.previous();
				}
				break;
			case Key.ENTER:
				this.$focusedListItem.selected = true;
				break;
			case Key.SPACE:
				this.$focusedListItem.selected = true;
				break;
		}
	}
	/* BEGIN PROPERTIES */	
	public function get context():Object
	{
		return this.$context;
	}
	public function set context(c:Object):Void
	{
		this.$context = c;
	}
	public function get operand():SimpleList
	{
		return this.$operand;
	}
	public function set operand(operand:SimpleList):Void
	{
		this.removeAll();
		this.$operand = operand;
		if(this.$noMask != true)
		{
			this.drawMask(this.$maskWidth, this.$maskHeight);
		}
		this.paint();
	}
	public function set horizontal(b:Boolean):Void
	{
		this.$horizontal = b;
		this.paint();
	}
	public function get horizontal():Boolean
	{
		return this.$horizontal;
	}
	public function get minimumSelection():Number
	{
		return this.$minimumSelection;
	}
	public function set minimumSelection(n:Number)
	{
		this.$minimumSelection = n;
	}
	public function get locked():Boolean
	{
		return this.$locked;
	}
	public function set locked(b:Boolean):Void
	{
		//this.trace('[org.caleb.view.collection.List] locked set to: ' + b.toString())
		this.$locked = b;
	}
	public function get ignoreMouse():Boolean
	{
		return this.$ignoreMouse;
	}
	public function set ignoreMouse(b:Boolean):Void
	{
		this.$ignoreMouse = b;
	}
	/*
	* The selected item in a single-selection public function get  This property is read-only.
	*/
	public function get selectedItem():ListItem
	{
		for(var item in this.items)
		{
			if(this.items[item].selected == true)
			{
				return this.items[item];
			}
		}
		
		return undefined;
	}
	public function get focusedListItem():ListItem
	{
		return this.$focusedListItem;
	}
	public function set focusedListItem(i:ListItem):Void
	{
		this.$focusedListItem = i;
	}
	public function set selectedItem(item:ListItem)
	{
		var sel:ListItem = ListItem(this.$operand.getElement(item));
		sel.selected = true;
		this.items[sel.index].selected = true;
	}

	/*
	* The selected item objects in a multiple-selection public function get  This property is read-only.
	*/
	public function get selectedItems():Array
	{
		var tmpItem:ListItem;
		var tmpArray:SimpleList = new SimpleList;
		
		for(var i in this.items)
		{
			if(this.items[i].selected == true)
			{
				if(tmpArray.contains(this.items[i]) == false)
				{
					tmpArray.addElement(this.items[i]);
				}
			}
		}
		
		return tmpArray.toArray();
	}
	public function set selectedItems(a:Array)
	{
		// todo
	}
	/* 
	* The number of items in the public function get  This property is read-only. 
	*/
	public function get length():Number
	{
		return this.$operand.size();
	}	 
	
	public function get items():Array
	{
		return this.$items;
	}	 
	public function get mask():MovieClip
	{
		return this.$mask;
	}
	public function get maskHeight():Number
	{
		return this.$maskHeight;
	}
	public function get maskWidth():Number
	{
		return this.$maskWidth;
	}
	/*
	* The source of the list items.
	*/
	public function get view():MovieClip
	{
		return this.$view;
	}
	public function get dataProvider():Array
	{
		return this.$operand.toArray();
	}
	/*
	* Indicates whether list items should position themselves upon focus change(s)
	*/
	public function get autoScroll():Boolean
	{
		return this.$autoScroll;
	}
	public function set autoScroll(b:Boolean):Void
	{
		this.$autoScroll = b;
	}
	/*
	* Indicates whether multiple selection is allowed in the list (true) or not (false).
	*/
	public function get multipleSelection():Boolean
	{
		return this.$multipleSelection;
	}
	public function set multipleSelection(b:Boolean)
	{
		this.$multipleSelection = b;
	}
	public function set noMask(b:Boolean)
	{
		this.$noMask = b;
	}
	/*
	* Indicates whether items can be deselected
	*/
	public function get itemsDeselectable():Boolean
	{
		return this.$itemsDeselectable;
	}
	public function set itemsDeselectable(b:Boolean)
	{
		this.$itemsDeselectable = b;
	}

	/*
	* Indicates whether the list is selectable (true) or not (false).
	*/
	public function get selectable():Boolean
	{
		return this.$selectable;
	}
	public function set selectable(b:Boolean)
	{
		this.$selectable = b;
	}
	/*
	* The index of a selection in a single-selection list
	*/
	public function get selectedIndex():Number
	{
		for(var item in this.items)
		{
			if(this.items[item].selected == true)
			{
				return this.items[item].index;
			}
		}
		
		return undefined;
	}
	public function set selectedIndex(idx:Number)
	{
		this.$selectedIndex = idx;
	}	
	/*
	* An array of the selected items in a multiple-selection list
	*/
	public function get selectedIndices():Array
	{
		var tmpItem:ListItem;
		var tmpArray:Array = new Array();
		
		while(this.$operand.listIterator().hasNext())
		{
			tmpItem = ListItem(this.$operand.listIterator().next());
			if(tmpItem.selected == true)
			{
				tmpArray.push(tmpItem.index);
			}
		}
		this.$operand.listIterator().reset();
		delete tmpItem;
		
		return tmpArray;
	}
	public function set selectedIndices(a:Array)
	{
		for(var idx:String in a)
		{
			this.$operand.getElementAtIndex(Number(idx)).selected = true;
		}
	}
	/* END PROPERTIES */
	
	/*
	* EVENTS
	*/
	// private events
	private function onSelect(e)
	{
		// override the folowing method
		e.setType('onItemSelect');
		this.dispatchEvent(e);
	}
	private function onDeselect(e)
	{
		// override the folowing method
		e.setType('onItemDeselect');
		this.dispatchEvent(e);
	}
	private function onMotionFinished(e)
	{
		// override the folowing method
		e.setType('onItemMotionFinished');
		this.dispatchEvent(e);
	}
	private function onFocus(e)
	{
		// override the folowing method
		e.setType('onItemFocus');
		this.dispatchEvent(e);
	}
	private function onBlur(e)
	{
		// override the folowing method
		e.setType('onItemBlur');
		this.dispatchEvent(e);
	}

	// public events	
	public function onItemSelect(e:org.caleb.event.Event):Void
	{
		// this.trace('onItemSelect invoked');
	}
	public function onItemDeselect(e:org.caleb.event.Event):Void
	{
		// this.trace('onItemDeselect invoked');
	}
	public function onItemMotionFinished(e:org.caleb.event.Event):Void
	{
		// this.trace('onItemDeselect invoked');
	}
	public function onItemFocus(e:org.caleb.event.Event):Void
	{
		// this.trace('onItemFocus invoked');
	}
	public function onItemBlur(e:org.caleb.event.Event):Void
	{
		// this.trace('onItemRollOut invoked');
	}
	
	/*
	* PUBLIC METHODS
	*/
	/*
	* Draw a mask over the list
	*/
	public function setViewArea(w:Number, h:Number)
	{
		this.drawMask(w, h);
	}
	public function next()
	{
		//this.trace('[org.caleb.collection.views.List] next invoked')
		if(this.$locked == false)
		{
			if(this.$focusedListItem.nextIndex != 0)
			{
				if(this.$focusedListItem == undefined)
				{
					this.$focusedListItem = this.items[0];
					this.$focusedListItem.focused = true;
				}
				else
				{
					var nextItem = this.items[this.$focusedListItem.nextIndex];
					this.$focusedListItem.focused = false;
					this.$focusedListItem = nextItem;
					this.$focusedListItem.focused = true;
				}
			}
		}
	}

	public function previous()
	{
		//this.trace('previous invoked')
		if(this.$locked == false)
		{
			if(this.$focusedListItem.previousIndex != (this.$operand.size() - 1))
			{
				if(this.$focusedListItem == undefined)
				{
					this.$focusedListItem = this.items[this.items.length - 1];
					this.$focusedListItem.focused = true;
				}
				else
				{
					var nextItem = this.items[this.$focusedListItem.previousIndex];
					this.$focusedListItem.focused = false;
					nextItem.focused = true;
					this.$focusedListItem = nextItem;
				}
			}
		}
	}
	// public mutators
	/*
	* Adds an item to the end of the list
	*/
	public function addItem(item:ListItem):Void
	{
		// add to operand
		this.$operand.addElement(item);
		this.paint();
	}
	
	/*
	* Adds an item to the list at the specified index.
	*/
	public function addItemAt(item:ListItem, idx:Number):Void
	{
		this.$operand.addElementAtIndex(item, idx);
		this.paint();
	}
	 
	/*
	* Returns the item at the specified index.
	*/
	public function getItemAt(idx:Number):ListItem
	{
		return ListItem(this.$operand.getElementAtIndex(idx));
	}
	 
	/*
	* Removes all items from the list 
	*/
	public function removeAll():Void
	{
		//trace('removeall');
		this.$operand.removeAll();
		
		for(var itm in this.$view)
		{
			this.$view[itm].removeMovieClip();
		}
		this.paint();
	}
	 
	/*
	* Removes the item at the specified index.
	*/
	public function removeItemAt(idx:Number):Void
	{
		this.$operand.removeElementAtIndex(idx);
		this.paint();
	}
	 
	/*
	* Replaces the item at the specified index with another item.
	*/
	public function replaceItemAt(item:ListItem, idx:Number):Void
	{
		this.$operand.addElementAtIndex(item, idx);
		this.paint();
	}
	// methods that affect all items
	public function setAlphaOnAll(a:Number):Void
	{
		if(a != undefined)
		{
			for(var item in this.items)
			{
				this.items[item]._alpha = a;
			}
		}
		else
		{
			//this.trace('ERROR! - _alpha cannot be set to undefined');
		}
	}
	public function deselectAll()
	{
		for(var item in this.items)
		{
			this.items[item].selected = false;
		}
	}
	public function selectAll()
	{
		if(this.$multipleSelection == true)
		{
			for(var item in this.items)
			{
				this.items[item].selected = true;
			}
		}
	}
	public function blurAll()
	{
		for(var item in this.items)
		{
			if(this.items[item].focused != false)
			{
				this.items[item].focused = false;
			}
		}
	}
	public function focusAll()
	{
		for(var item in this.items)
		{
			this.items[item].focused = true;
		}
	}
	public function hideAll()
	{
		for(var item in this.items)
		{
			this.items[item]._visible = false;
		}
	}
	public function showAll()
	{
		for(var item in this.items)
		{
			this.items[item]._visible = true;
		}
	}
	/*
	* DRAWING METHODS
	*/
	public function initAttachRef(attachRef:ListItem, dataRef:ListItem, idx:Number):Void
	{
		//trace('this.$initMouseHandlers: ' + this.$initMouseHandlers);
		if(this.$initMouseHandlers == true)
		{
			attachRef.onRelease = attachRef.onReleaseHandler;
			attachRef.onRollOut = attachRef.onRollOutHandler;
			attachRef.onRollOver = attachRef.onRollOverHandler;
		}
		attachRef.list 		 = this;
		attachRef.index 	 = idx;
		attachRef.label 	 = dataRef.label;
		attachRef.data 		 = dataRef.data;
		attachRef.selected	 = dataRef.selected;
		attachRef.context 	 = dataRef.context;
		// this list listens to each item
		attachRef.addEventObserver(this, 'onItemRelease');
		attachRef.addEventObserver(this, 'onMotionFinished');
		attachRef.addEventObserver(this, 'onSelect');
		attachRef.addEventObserver(this, 'onDeselect');
		attachRef.addEventObserver(this, 'onFocus');
		attachRef.addEventObserver(this, 'onBlur');			
		this.addEventObserver(this, 'onItemRelease');
		this.addEventObserver(this, 'onItemMotionFinished');
		this.addEventObserver(this, 'onItemSelect');
		this.addEventObserver(this, 'onItemDeselect');
		this.addEventObserver(this, 'onItemFocus');
		this.addEventObserver(this, 'onItemBlur');			
	}
	/*
	* Utility method to draw mask
	*/
	private function drawMask(w:Number, h:Number):Void
	{
		this.$maskWidth = w;
		this.$maskHeight = h;
		// find target
		var maskTarget:MovieClip = this._parent;
		var maskId:String = this.$mask_id + this._name
		// destroy
		if(maskTarget[maskId] != undefined)
		{
			maskTarget[maskId].removeMovieClip();
		}
		// build
		this.$mask = maskTarget.createEmptyMovieClip(maskId, maskTarget.getNextHighestDepth());
		// position
		this._parent[maskId]._y = _parent[this._name]._y;
		this.$mask._x = this._x;
		//this.$mask._x = maskTarget[this._name]._x;
		// color 
		this.$mask.lineStyle(.25, 0x999999, 100);
		// size/fill
		this.$mask.beginFill(0x666666, 100);
		this.$mask.lineTo(this.$maskWidth, 0);
		this.$mask.lineTo(this.$maskWidth, this.$maskHeight);
		this.$mask.lineTo(0, this.$maskHeight);
		this.$mask.lineTo(0, 0);
		this.$mask.endFill();
		// make mask
		this.$view.setMask(this.$mask);
	}
	/*
	* Main method to illustrate list object
	*/
	public function paint()
	{
		//this.trace('paint invoked');
		this.$items = new Array();
		var i:Number = 0;
		while(this.$operand.listIterator().hasNext())
		{
			$tmpItem = ListItem(this.$operand.listIterator().next());
			// movieclip for each menu item
			var attachRef:ListItem;
			if($tmpItem.linkageId == undefined)
			{
				attachRef = ListItem(this.$view.attachMovie(ListItem.SymbolName, "ListItem" + i, this.$view.getNextHighestDepth()));
				attachRef.draw();
			}
			else
			{
				attachRef = ListItem(this.$view.attachMovie($tmpItem.linkageId, "ListItem" + i, i));
			}
			this.initAttachRef(attachRef, $tmpItem, i);

			if(attachRef.selectable == undefined)
			{
				attachRef.selectable = this.$selectable;
			}
			if(this.$operand.listIterator().index() == (this.$operand.listIterator().list.size() - 1))
			{
				// we're at the end
				attachRef.nextIndex = 0;
				attachRef.previousIndex = i - 1;
			}
			else if(i == 0)
			{
				// we're at the beginning
				if(this.$operand.listIterator().list.size() < 2)
				{
					attachRef.nextIndex = 0;
				}
				else
				{
					attachRef.nextIndex = 1;
				}
				attachRef.previousIndex = this.$operand.listIterator().list.size() - 1;
			}
			else
			{
				// we're somewhere in the middle
				attachRef.nextIndex = i + 1;
				attachRef.previousIndex = i - 1;
			}
			// update local collection
			this.$items.push(attachRef);
			// incriment i
			i++;
		}
		this.$operand.listIterator().reset();
		// position items
		this.positionItems();
		
		var args:Array = new Array;
		args['list'] = this;
		this.dispatchEvent(new org.caleb.event.Event('onPaintComplete', args));
	}
	private function getCarouselRepositionX(attachX:Number, attachRef:MovieClip):Number
	{
		// reposition for carousel effect
		if(attachX > this.$maskWidth)
		{
			this.$offstageIndex++;
			attachX = -(Number((this.$operand.size() - (attachRef.index+1)+1))*(attachRef._width));
		}
		return attachX;
	}
	public function positionItems():Void
	{
		var nextAttachX:Number;
		var attachX:Number = 0;
		var attachY:Number = 0;
		var maskFull:Boolean = false;
		var i:Number = 0;
		for(var itm in this.$items)
		{
			var attachRef = ListItem(this.$items[i]);
			if(this.$horizontal == true)
			{
				if(this.$carousel == true)
				{
					if(attachX > this.$maskWidth)
					{
						maskFull = true;
					}
					this.getCarouselRepositionX(attachX);
				}
				attachRef._x = attachX;
				attachRef._y = 0;
			}
			else
			{
				//attachY = this._height;
				attachRef._x = 0;
				attachRef._y = attachY;
			}
			attachX += attachRef._width
			attachY += attachRef._height-1

			i++;
		}
	}
	public function get startingX():Number
	{
		return this.$startingX;
	}	 
	public function get startingY():Number
	{
		return this.$startingY;
	}	 
	public function set carousel(b:Boolean):Void
	{
		this.$carousel = b;
		this.paint();
	}
	public function get carousel():Boolean
	{
		return this.$carousel;
	}
	public function get rowCount():Number
	{
		return this.$rowCount;
	}
	
	public function get itemHeight():Number
	{
		return this.$templateItem._height;
	}	 
	public function get itemWidth():Number
	{
		return this.$templateItem._width;
	}	 
	// read/write properties		
	public function get maskOffsetY():Number
	{
		return this.$maskOffsetY;
	}
	public function set maskOffsetY(n:Number)
	{
		this.$maskOffsetY = n;
		this.drawMask(this.$maskWidth, this.$maskHeight);
	}
	public function get maskOffsetX():Number
	{
		return this.$maskOffsetX;
	}
	public function set maskOffsetX(n:Number)
	{
		this.$maskOffsetX = n;
		this.drawMask(this.$maskWidth, this.$maskHeight);
	}
}