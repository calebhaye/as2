import org.caleb.components.table.Table;
import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.animation.AnimationManager;
import flash.geom.Rectangle;
import org.bcdef.util.SmartLoader;
import org.bcdef.util.SmartLoaderInstance;

class org.caleb.components.table.TableCell extends ObservableMovieClip
{
	public static var SymbolName:String = '__Packages.org.caleb.components.table.TableCell';
	public static var SymbolLinked = Object.registerClass(SymbolName, TableCell);
	
	private var __table:Table;
	private var __selected:Boolean;
	private var __w:Number;
	private var __h:Number;
	private var __row:Number;
	private var __column:Number;
	private var __index:Number;
	private var __selectColor:Number;
	private var __deselectColor:Number;
	private var __mode:String;
	private var __loader:MovieClipLoader;

	private var __bg:MovieClip;
	private var __view:MovieClip;
	private var __data:Object;
	private var __dragStart:Rectangle;
	
	public function TableCell()
	{
		this.setClassDescription('org.caleb.components.table.TableCell');
		this.addEventObserver(this, 'onCellRollOver');
		this.addEventObserver(this, 'onCellSelect');
		this.addEventObserver(this, 'onCellDeselect');
	}
	public function init(table:Table, w:Number, h:Number, selectColor:Number, deselectColor:Number):Void
	{
		//trace('init invoked')
		__table = table;
		__loader = new MovieClipLoader;
		__w = w;
		__h = h;
		__selected = false;
		__selectColor = selectColor;
		__deselectColor = deselectColor;
		__dragStart = new Rectangle;
		__data = new Object;
		__view = this.createEmptyMovieClip('__view', this.getNextHighestDepth());
		this.paint();
	}
	private function paint():Void
	{
		//trace('painting '+ __selected)
		if(__selected)
		{
			__bg = org.caleb.util.DrawingUtil.drawRectangle(this, __w, __h, 0, 0, 0, __selectColor, __deselectColor);
		}
		else
		{
			if(__mode == undefined)
			{
				__bg = org.caleb.util.DrawingUtil.drawRectangle(this, __w, __h, 0, 0, 0, __deselectColor, __deselectColor);
			}
			else
			{
				__bg = org.caleb.util.DrawingUtil.drawRectangle(this, __w, __h, 0, 0, 0, __table.getCellColorByMode(__mode), __deselectColor);
			}
		}
		
		this.decorate();
		this.bringViewToFront();
	}
	private function decorate():Void
	{
		__bg.onRollOver = function():Void
		{
			this._alpha = 25;
		}
		__bg.onRollOut = function():Void
		{
			this._alpha = 100;
		}
	}
	public function onCellSelect():Void
	{
		//trace('onCellSelect invoked');
	}
	public function onCellDeselect():Void
	{
		//trace('onCellDeselect invoked');		
	}
	public function get selected():Boolean
	{
		return __selected;
	}
	public function onRollOver():Void
	{
		var e:org.caleb.event.Event = new org.caleb.event.Event('onCellRollOver');
		e.addArgument('cell', this);
		this.dispatchEvent(e);
	}
	public function onRollOut():Void
	{
		var e:org.caleb.event.Event = new org.caleb.event.Event('onCellRollOut');;
		e.addArgument('cell', this);
		this.dispatchEvent(e);
	}
	public function set selected(arg:Boolean):Void
	{
		__selected = arg;
		var e:org.caleb.event.Event = new org.caleb.event.Event;
		e.addArgument('cell', this);
		if(__selected)
		{
			e.setType('onCellSelect');
			this.dispatchEvent(e);
		}
		else
		{
			e.setType('onCellDeselect');
			this.dispatchEvent(e);
		}
		this.paint();
	}
	public function get row():Number
	{
		return __row;
	}
	public function get column():Number
	{
		return __column;
	}
	public function get index():Number
	{
		return __index;
	}
	public function get table():Table
	{
		return __table;
	}
	/*
	public function set row(arg:Number):Void
	{
		__row = arg;
	}
	public function set cell(arg:Number):Void
	{
		__cell = arg;
	}
	*/
	public function set mode(arg:String):Void
	{
		__mode = arg;
		this.paint();
	}
	public function set index(arg:Number):Void
	{
		__index = arg;
	}
	public function onRelease():Void
	{
		__table.selectCell(__index);
	}
	public function get view():MovieClip
	{
		return __view;
	}
	/**
	* Accessor for private __data var.
	* @return Object.
	**/
	public function get data():Object
	{
		return __data;
	}
	/**
	* Mutator for private __data var.
	* @param arg Object
	**/
	public function set data(arg:Object) 
	{
		__data = arg;
	}

	public function unloadImage():Void
	{
		//trace('unloadImage invoked');
		__view.removeMovieClip();
		__view = this.createEmptyMovieClip('__view', this.getNextHighestDepth());
		this.bringViewToFront();
	}
	public function loadImage(url:String):Void
	{
		//trace('*** target: ' + __view + ', loading: ' + url);
		//__loader.setTransition("fadeInFast");
		__loader.loadClip(url, __view);
        __loader.addListener(this);
		this.bringViewToFront();
	}
	public function bringViewToFront():Void
	{
		__view.swapDepths(this.getNextHighestDepth());
	}
	private function onDragInit(e:org.caleb.event.Event):Void
	{
		__dragStart.x = this._x;
		__dragStart.y = this._y;
		
		__table.selectCell(__index);
		this.swapDepths(this._parent.getNextHighestDepth());
		
		e.setType('onTableCellDragInit');
		this.dispatchEvent(e);
	}
	private function onDragComplete(e:org.caleb.event.Event):Void
	{
		// snap back
		this.snapBack();
		e.setType('onTableCellDragComplete');
		this.dispatchEvent(e);
	}
	private function onDrop(e:org.caleb.event.Event):Void
	{
		// snap back
		this.snapBack();
		e.setType('onTableCellDrop');
		this.dispatchEvent(e);
	}
	private function snapBack()
	{
		var y:AnimationManager = new AnimationManager(this);
		y.tween (["_x", "_y"], [__dragStart.x, __dragStart.y], .15, 'linear');
	}
	public function onLoadInit (image:MovieClip):Void 
	{
		var widthOffset:Number = __w / image._width;
		var heightOffset:Number = __h / image._height;
		var scaleOffset:Number = 0;
		(widthOffset < heightOffset) ? (scaleOffset = widthOffset) : (scaleOffset = heightOffset);
		/*
		trace('image._width: ' + image._width);						
		trace('widthOffset: ' + widthOffset);
		trace('heightOffset: ' + heightOffset);
		*/
		//trace('scaleOffset: ' + scaleOffset);
		//if(scaleOffset < 1)
		//if(scaleOffset < 1)
		{
			image._width = image._width * scaleOffset - 5;
			image._height = image._height * scaleOffset - 5;
		}
		centerInsideClip(this, __view)
		var evt:org.caleb.event.Event = new org.caleb.event.Event('onTableCellImageLoadInit');
		evt.addArgument('cell', this);
		evt.addArgument('index', __index);
		this.dispatchEvent(evt);
	}
	public function centerInsideClip(parentClip:MovieClip, clipToBeCentered:MovieClip, vertical:Boolean, horiz:Boolean):Void
	{
		if(horiz != false)
		{
			//trace('parentClip._width: ' + parentClip._width);
			//trace('clipToBeCentered._width: ' + clipToBeCentered._width);
			clipToBeCentered._x = (parentClip._width - clipToBeCentered._width) / 2;
		}
		if(vertical != false)
		{
			clipToBeCentered._y = (parentClip._height- clipToBeCentered._height) / 2;
		}
	}
	public function get width():Number
	{
		return __w;
	}
	public function get height():Number
	{
		return __h;
	}
	public function get bg():MovieClip { return this.bg };
}