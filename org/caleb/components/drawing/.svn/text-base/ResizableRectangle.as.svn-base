import org.caleb.event.Event;
import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.util.DrawingUtil;
import org.caleb.components.drawing.MarchingAnts;
import flash.geom.Rectangle;

class org.caleb.components.drawing.ResizableRectangle extends ObservableMovieClip
{
	public static var SymbolName:String = '__Packages.org.caleb.components.drawing.ResizableRectangle';
	public static var SymbolLinked = Object.registerClass(SymbolName, ResizableRectangle);
	
	private var $widthRatio:Number;
	private var $heightRatio:Number;
	private var $fillColor:Number;
	private var $fillAlpha:Number;
	private var $strokeColor:Number;
	private var $strokeAlpha:Number;
	private var $strokeWeight:Number;
	private var $cornerRadius:Number;
	private var $handleSize:Number;
	private var $heightHandle:MovieClip;
	private var $widthHandle:MovieClip;
	private var $widthHeightHandle:MovieClip;
	private var $box:MovieClip;
	private var $shape:MovieClip;
	private var $contentContainer:MovieClip;
	private var $resizeStartX;
	private var $resizeStartY;
	private var $resizeStartW;
	private var $resizeStartH;
	private var $resizeEndX;
	private var $resizeEndY;
	private var $dragLimitation:String;
	private var $useRatio:Boolean;
	private var $useMin:Boolean;
	private var $useMax:Boolean;
	private var $useAnts:Boolean;
	private var $isCircle:Boolean;
	private var $isRectangle:Boolean;
	private var $isOval:Boolean;
	private var $minimumWidth:Number;
	private var $minimumHeight:Number;
	private var $maxWidth:Number;
	private var $maxHeight:Number;
	private var $ants:MarchingAnts;

	public function ResizableRectangle()
	{
		this.setClassDescription('org.caleb.components.drawing.ResizableRectangle');
		trace('constructor invoked');
		this.addEventObserver(this, 'onViewUpdate');
	}
	public function draw(w:Number, h:Number, x:Number, y:Number):MovieClip
	{
		/*
		trace('draw invoked');
		trace('w: ' + w);
		trace('h: ' + h);
		trace('x: ' + x);
		trace('y: ' + y);
		*/
		// for some mistaken reason, this call has to happen 
		// prior to creating the box below, or else this.$box is 
		// NOT this.$box, but the box that is being dragged
		
		this.$contentContainer = this.createEmptyMovieClip('$contentContainer', this.getNextHighestDepth());
		this.$ants = MarchingAnts(this.attachMovie(MarchingAnts.SymbolName, '$ants', this.getNextHighestDepth()));
		this.createBox(w, h, x, y);
		this.createHandles(w, h, x, y);
		
		if(this.isCircular)
		{
			this.$box._alpha = 0;
		}
		
		this.minimumWidth = 5;
		this.minimumHeight = 5;
		
		return this.$box;
	}
	public function setRatio(w:Number, h:Number):Void
	{
		this.$useRatio = true;
		this.$widthRatio = w/h;
		this.$heightRatio = h/w;
	}
	public function onViewUpdate(e:org.caleb.event.Event):Void
	{
		//trace('onViewUpdate invoked');
	}
	public function updateHandleDisplay():Void
	{
		//trace('updateHandleDisplay invoked');
		this.$widthHandle._height = this.$box._height;
		// center
		this.$widthHandle._x = this.$box._x + this.$box._width - (this.$handleSize/2) - (this.$strokeWeight/2);
		// don't center
		//this.$widthHandle._x = this.$box._x + this.$box._width - (this.$handleSize/*2*/) - (this.$strokeWeight/*2*/);
		this.$widthHandle._y = this.$box._y;

		this.$heightHandle._width = this.$box._width;
		this.$heightHandle._x = this.$box._x;
		this.$heightHandle._y = this.$box._y + this.$box._height - (this.$handleSize/2) - (this.$strokeWeight/2);
		
		this.$widthHeightHandle._x = this.$box._x + this.$box._width - (this.$handleSize/2) - (this.$strokeWeight/2);
		this.$widthHeightHandle._y = this.$box._y + this.$box._height - (this.$handleSize/2) - (this.$strokeWeight/2);

		this.$widthHandle.swapDepths(this.getNextHighestDepth());
		this.$heightHandle.swapDepths(this.getNextHighestDepth());
		this.$widthHeightHandle.swapDepths(this.getNextHighestDepth());
		
		this.dispatchEvent(new org.caleb.event.Event('onViewUpdate'));
	}
	public function setDisplayProperties(fillColor:Number, fillAlpha:Number, strokeColor:Number, strokeAlpha:Number, strokeWeight:Number, cornerRadius:Number, handleSize:Number)
	{
		//trace('strokeAlpha: ' + strokeAlpha);
		this.$fillColor = fillColor;
		this.$fillAlpha = fillAlpha;
		this.$strokeColor = strokeColor;
		this.$strokeAlpha = strokeAlpha;
		this.$strokeWeight = strokeWeight;
		this.$cornerRadius = cornerRadius;
		this.$handleSize = handleSize;
	}
	private function updateBoxView():Void
	{
		//this.$contentContainer._x = this.$box._x;
		//this.$contentContainer._y = this.$box._y;
		this.$shape._x = this.$box._x;
		this.$shape._y = this.$box._y;
		this.$ants.startPoint = new flash.geom.Point(this.$box._x, this.$box._y);
		this.$ants.endPoint = new flash.geom.Point(this.$box._x + this.$box._width, this.$box._y + this.$box._height);
		if(this.$useAnts == true)
		{			this.$box._alpha = 0;
			this.$ants._visible = true;
		}
		else
		{
			if(this.isCircular) 
			{
				this.$box._alpha = 0;
			}
			else
			{
				this.$box._alpha = 50;
			}
			this.$ants._visible = false;
		}
	}
	
	
	private function createHandles(w:Number, h:Number, x:Number, y:Number):Void
	{
		/*
		trace('createHandles invoked');
		trace('w: ' + w);
		trace('h: ' + h);
		trace('x: ' + x);
		trace('y: ' + y);
		*/
		
		this.$heightHandle.removeMovieClip();
		if(this.$dragLimitation != 'horizontal')
		{
			this.$heightHandle = DrawingUtil.drawRectangle(this, w, this.$handleSize, x, y + h, 0, 0x666666, 0x999999);
			this.$heightHandle._name = '$heightHandle';
			org.caleb.util.MovieClipUtil.makeDraggable(this.$heightHandle);
			this.$heightHandle.addEventObserver(this, 'onDragInit');
			this.$heightHandle.addEventObserver(this, 'onDragComplete');
			this.$heightHandle.addEventObserver(this, 'onDragInterval');
			
			trace('height handle width/height: '+this.$heightHandle._width+' / '+this.$heightHandle._height)
		}
		this.$widthHandle.removeMovieClip();
		if(this.$dragLimitation != 'vertical')
		{
			this.$widthHandle = DrawingUtil.drawRectangle(this, this.$handleSize, h, x + w, y, 0, 0x666666, 0x999999);
			this.$widthHandle._name = '$widthHandle';
			org.caleb.util.MovieClipUtil.makeDraggable(this.$widthHandle, this.$dragLimitation);
			this.$widthHandle.addEventObserver(this, 'onDragInit');
			this.$widthHandle.addEventObserver(this, 'onDragComplete');
			this.$widthHandle.addEventObserver(this, 'onDragInterval');
		}
		this.$widthHeightHandle.removeMovieClip();
		if(this.$dragLimitation != 'vertical' && this.$dragLimitation != 'horizontal')
		{
			this.$widthHeightHandle = DrawingUtil.drawRectangle(this, this.$handleSize, this.$handleSize, x + w, y + h, 0, 0x666666, 0x999999);
			this.$widthHeightHandle._name = '$widthHeightHandle';
			org.caleb.util.MovieClipUtil.makeDraggable(this.$widthHeightHandle, this.$dragLimitation);
			this.$widthHeightHandle.addEventObserver(this, 'onDragInit');
			this.$widthHeightHandle.addEventObserver(this, 'onDragComplete');
			this.$widthHeightHandle.addEventObserver(this, 'onDragInterval');
		}
	/*/
		this.$widthHandle._alpha = 0;
		this.$heightHandle._alpha = 0;
		this.$widthHeightHandle._alpha = 0;
	/*/
		this.updateHandleDisplay();
	}
	private function onDragInit(e:Event):Void
	{
		//trace('onDragInit invoked');
		
		this.$resizeStartX = MovieClip(e.getArgument('target'))._x;
		this.$resizeStartY = MovieClip(e.getArgument('target'))._y;
		// offset by 3 to account for stroke width
		this.$resizeStartW = this.$box._width;
		this.$resizeStartH = this.$box._height;
		
		this.swapDepths(this._parent.getNextHighestDepth());
	}
	private function onDragComplete(e:Event):Void
	{
		this.updateHandleDisplay();
		this.dispatchEvent(e);
	}
	private function onDragInterval(e:Event):Void
	{
		if(MovieClip(e.getArgument('target')) != this.$box)
		{
			this.$resizeEndX = MovieClip(e.getArgument('target'))._x;
			this.$resizeEndY = MovieClip(e.getArgument('target'))._y;
			
			var xDifference = this.$resizeStartX - this.$resizeEndX;
			var yDifference = this.$resizeStartY - this.$resizeEndY;
			
			
			var boxW:Number;
			var boxH:Number;
			var boxX:Number = this.$box._x;
			var boxY:Number = this.$box._y;
			
			//trace("MovieClip(e.getArgument('target')): "+MovieClip(e.getArgument('target')))
			
			boxW = this.$resizeStartW - xDifference;
			boxH = this.$resizeStartH - yDifference;
			
			if(this.$useRatio == true)
			{
				if(e.getArgument('target') == this.$heightHandle)
				{
					boxW = boxH * this.$widthRatio;
				}
				else if(e.getArgument('target') == this.$widthHandle)
				{
					boxH = boxW * this.$heightRatio;
				}
				else
				{
					boxW = boxH * this.$widthRatio;
					boxH = boxW * this.$heightRatio;
				}
			}
			//trace('boxW < this.$maxWidth: '+(boxW < this.$maxWidth))
			//trace('max w: '+boxW)
			//trace('max w: '+boxH)
			//trace('max w: '+this.$maxWidth)
			//trace('max h: '+this.$maxHeight)
			var redrawBox:Boolean = false;
			if($useMin == true)
			{
				if((boxW > this.$minimumWidth) && (boxH > this.$minimumHeight))
				{
					redrawBox = true;
				}
			}
			else if($useMax == true)
			{
				if((boxH + boxY < this.$maxHeight) && (boxW + boxX < this.$maxWidth))
				{
					redrawBox = true;
				}
			}
			else
			{
				redrawBox = true
			}
			
			if(redrawBox)
			{
				this.createBox(boxW, boxH, boxX, boxY);
			}
		}
		this.updateBoxView();
		this.updateHandleDisplay();
		this.dispatchEvent(e);
	}
	public function createBox(w:Number, h:Number, x:Number, y:Number):MovieClip
	{
		//trace('createBox invoked, h: ' + h);
		this.$box.removeMovieClip();
		this.$shape.removeMovieClip();
		//this.$box = DrawingUtil.drawRoundedRectangle(this, w, h, this.$cornerRadius, , this.$fillAlpha, this.$strokeWeight, this.$strokeColor, this.$strokeAlpha, '$boundingBox', this.getNextHighestDepth());
		this.$box = DrawingUtil.drawRectangle(this, w, h, 0, 0, this.$strokeWeight, this.$fillColor, this.$strokeColor);
		
		if(this.$isCircle) 
		{
			trace('drawing circle')
			this.$shape = DrawingUtil.drawCircle(this, h/2,  h/2,  h/2, this.$fillColor, this.$strokeColor, this.$strokeWeight);
		}
		else if(this.$isOval) 
		{
			trace('drawing oval')
			this.$shape = DrawingUtil.drawOval(this, w/2,  h/2,  w/2,h/2, this.$fillColor, this.$strokeColor, this.$strokeWeight);
			this.$shape._x = x;
			this.$shape._y = y;
		}
		this.$shape._alpha = this.$fillAlpha;
		this.$box._alpha = this.$fillAlpha;
		org.caleb.util.MovieClipUtil.makeDraggable(this.$box, this.$dragLimitation);
		this.$box.addEventObserver(this, 'onDragInit');
		this.$box.addEventObserver(this, 'onDragComplete');
		this.$box.addEventObserver(this, 'onDragInterval');
		this.$box._x = x;
		this.$box._y = y;
				
		return this.$box;
	}
	public function updateBox():Void
	{
		if(arguments.length == 1)
		{
			var rect:Rectangle = Rectangle(arguments[0]);
			this.$box._width = rect.width;
			this.$box._height = rect.height;
			this.$box._x = rect.x;
			this.$box._y = rect.y;
		}
		
		org.caleb.util.MovieClipUtil.makeDraggable(this.$box, this.$dragLimitation)
		this.$box.addEventObserver(this, 'onDragInit');
		this.$box.addEventObserver(this, 'onDragComplete');
		this.$box.addEventObserver(this, 'onDragInterval');

		this.createHandles(this.$box._width, this.$box._height, this.$box._x, this.$box._y);
	}
	public function get minimumWidth():Number
	{
		return this.$minimumWidth;
	}
	public function set minimumWidth(arg:Number) 
	{
		this.$useMin = true;
		this.$minimumWidth = arg;
	}
	public function get minimumHeight():Number
	{
		return this.$minimumHeight;
	}
	public function set minimumHeight(arg:Number) 
	{
		this.$useMin = true;
		this.$minimumHeight = arg;
	}
	public function get maxWidth():Number
	{
		return this.$maxWidth;
	}
	public function set maxWidth(arg:Number) 
	{
		this.$useMax = true;
		this.$maxWidth = arg;
	}
	public function get maxHeight():Number
	{
		return this.$maxHeight;
	}
	public function set maxHeight(arg:Number) 
	{
		this.$useMax = true;
		this.$maxHeight = arg;
	}
	public function get box():MovieClip
	{
		return this.$box;
	}
	public function get contentContainer():MovieClip
	{
		return this.$contentContainer;
	}
	public function get rectangle():flash.geom.Rectangle
	{
		return new flash.geom.Rectangle(this.$box._x, this.$box._y, this.$box._width, this.$box._height);
	}
	public function set useAnts(arg:Boolean):Void
	{
		this.$useAnts = arg;
		this.updateBoxView();
	}
	public function set dragLimitation(arg:String):Void
	{
		this.$dragLimitation = arg;
	}
	public function set isCircle(arg:Boolean):Void
	{
		if(arg == true)
		{
			this.setRatio(1,1)
			this.useAnts = false;
			this.$isOval = false;
			this.$isRectangle = false;
		}
		this.$isCircle = arg;
	}
	public function get isCircle():Boolean
	{
		return this.$isCircle;
	}
	public function set isOval(arg:Boolean):Void
	{
		if(arg == true)
		{
			this.useAnts = false;
			this.$isRectangle = false;
			this.$isCircle = false;
		}
		this.$isOval = arg;
	}
	public function set isRectangle(arg:Boolean):Void
	{
		if(arg == true)
		{
			this.useAnts = false;
			this.$isCircle = false;
			this.$isOval = false;
		}
		this.$isRectangle = arg;
	}
	public function get isOval():Boolean
	{
		return this.$isOval;
	}
	public function get isCircular():Boolean
	{
		return this.$isOval || this.$isCircle;
	}
}