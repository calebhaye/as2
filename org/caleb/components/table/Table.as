import org.caleb.components.table.TableCell;
import org.caleb.movieclip.ObservableMovieClip;

class org.caleb.components.table.Table extends ObservableMovieClip
{
	public static var SymbolName:String = '__Packages.org.caleb.components.table.Table';
	public static var SymbolLinked = Object.registerClass(SymbolName, Table);

 	private var __multipleSelection:Boolean;
	private var __cellPadding:Number;
	private var __columns:Number;
	private var __cellWidth:Number;
	private var __cellHeight:Number;
	private var __cellColor:Number;
	private var __lastSelectedIndex:Number;
	private var __modes:Array;
	private var __items:Array;
	private var __view:MovieClip;
	
	public function Table()
	{
		this.setClassDescription('org.caleb.components.table.Table');
		//trace('constructor invoked');
		__cellPadding = 0;
	}
	public function init(columns:Number, items:Number, multipleSelection:Boolean, cellWidth:Number, cellHeight:Number, cellPadding:Number, cellColor:Number):Void
	{
		//trace('=== columns: ' + columns); 
		//trace('=== items: ' + items); 
		//trace('=== multipleSelection: ' + multipleSelection); 
		//trace('=== cellWidth: ' + cellWidth); 
		//trace('=== cellHeight: ' + cellHeight); 
		//trace('=== cellPadding: ' + cellPadding); 
		//trace('=== cellColor: ' + cellColor); 
		__cellWidth = cellWidth;
		__cellHeight = cellHeight;
		__cellPadding = cellPadding;
		__cellColor = cellColor;
		__items = new Array;
		__modes = new Array;
		if(__view != undefined)
		{
			__view.removeMovieClip();
		}
		__view = this.createEmptyMovieClip('__view', this.getNextHighestDepth());
		
		__multipleSelection = multipleSelection;
		__columns = columns;
		for(var i:Number = 0; i < items; i++)
		{
			this.addCell();
		}
		this.positionCells();
		this.dispatchEvent(new org.caleb.event.Event('onTableInit'))
	}
	public function unloadImages():Void
	{
		//trace('unloadImages invoked');
		for(var i:Number = 0; i < __items.length; i++)
		{
			__items[i].unloadImage();
		}
	}
	public function selectCell(index:Number):Boolean
	{
		//trace('selectCell invoked');
		var exists:Boolean = false;
		var cell:TableCell;
		for(var i:Number = 0; i < __items.length; i++)
		{
			cell = TableCell(__items[i]);
			
			if(i == index)
			{
				__lastSelectedIndex = i;
				exists = true;
				trace('--------------------cell.selected: ' + cell.selected);
				if(cell.selected != true)
				{
					cell.selected = true
				}
			}
			else
			{
				if(cell.selected == true)
				{
					cell.selected = false;
				}
			}
		}
		return exists;
	}
	public function setCellMode(index:Number, mode:String):Void
	{
		__items[index].mode = mode;
	}
	public function getCellMode(index:Number):String
	{
		return __items[index].mode;
	}
	public function addMode(mode:String, color:Number):Void
	{
		__modes[mode] = color;
	}
	private function addCell():TableCell
	{
		//trace('********************: ' + __cellColor);
		if(__cellColor == undefined)
		{
			__cellColor = 0x000000;
		}
		var cell:TableCell = TableCell(__view.attachMovie(TableCell.SymbolName, 'cell' + __items.length, __view.getNextHighestDepth()));
		cell.init(this, __cellWidth, __cellHeight, __cellColor, __cellColor);
		cell.index = __items.length;
		cell.addEventObserver(this, 'onCellSelect');
		cell.addEventObserver(this, 'onTableCellImageLoadInit');
		__items.push(cell);
		return cell;
	}
	public function positionCells():Void
	{
		//trace('positionCells invoked');
		//trace('__items.length: ' + __items.length);
		//trace('__columns: ' + __columns);
		var cell:TableCell;
		var previousCell:TableCell;
		var cellRow:Number;
		var cellColumn:Number;
		var cellX:Number;
		var cellY:Number;
		var padding:Number;
		for(var i:Number = 0; i < __items.length; i++)
		{
			//trace('cell width: ' + cell.width)
			cell = TableCell(__items[i]);
			previousCell = TableCell(__items[i - 1]);
			cellRow = Math.floor(i / __columns);
			cellColumn = Number(i - (__columns * cellRow));
			cellX = Number(cellColumn * (cell.width + __cellPadding));
			cellY = Number(cellRow * (cell.height + __cellPadding));
			cell._x = cellX;
			cell._y = cellY;
		}
		this.dispatchEvent(new org.caleb.event.Event('onTableCellsPositioned'));
	}
	public function onTableCellImageLoadInit(e:org.caleb.event.Event):Void
	{
		//trace('onTableCellImageLoadInit invoked');
		this.dispatchEvent(e);
	}
	public function onCellSelect(e:org.caleb.event.Event):Void
	{
		//trace('onCellSelect invoked');
		this.dispatchEvent(e);
	}
	public function deselectAll():Void
	{
		//trace('deselectAll invoked');
		var cell:TableCell;
		for(var i:Number = 0; i < __items.length; i++)
		{
			cell = TableCell(__items[i]);
			if(cell.selected != false)
			{
				cell.selected = false;
			}
		}
	}
	public function set multipleDragTargets(arg:Boolean):Void
	{
		var cell:TableCell;
		for(var i:Number = 0; i < __items.length; i++)
		{
			cell = TableCell(__items[i]);
			cell['multipleDragTargets'] = arg
		}
	}
	public function set draggable(arg:Boolean):Void
	{
		//trace('set draggable invoked');
		var cell:TableCell;
		for(var i:Number = 0; i < __items.length; i++)
		{
			cell = TableCell(__items[i]);
			if(arg == true)
			{
				org.caleb.util.MovieClipUtil.makeDraggable(cell);
			}
			else
			{
				org.caleb.util.MovieClipUtil.makeUndraggable(cell);
			}
		}
	}
	public function get cellCount():Number
	{
		return __items.length;
	}	
	public function get view():MovieClip
	{
		return __view;
	}
	public function get columns():Number
	{
		return __columns;
	}
	public function set columns(arg:Number):Void
	{
		__columns = arg;
		this.positionCells();
	}
	public function get cellPadding():Number
	{
		return __cellPadding;
	}
	public function set cellPadding(arg:Number):Void
	{
		__cellPadding = arg;
	}
	public function get multipleSelection():Boolean
	{
		return __multipleSelection;
	}
	public function get selectedCell():TableCell
	{
		return __items[__lastSelectedIndex];
	}
	public function set multipleSelection(arg:Boolean):Void
	{
		__multipleSelection = arg;
	}
	public function getCellColorByMode(mode:String):Number
	{
		return Number(__modes[mode]);
	}
	public function getCell(index:Number):TableCell
	{
		return TableCell(__items[index]);
	}
	public function loadImage(index:Number, url:String)
	{
		__items[index].loadImage(url);
	}
	public function get cellWidth():Number
	{
		return __cellWidth;
	}
	public function set cellWidth(arg:Number) 
	{
		__cellWidth = arg;
	}
	public function get cellHeight():Number
	{
		return __cellHeight;
	}
	public function set cellHeight(arg:Number) 
	{
		__cellHeight = arg;
	}
	public function get cellColor():Number
	{
		return this.cellColor;
	}
	public function set cellColor(arg:Number) 
	{
		this.cellColor = arg;
	}
}