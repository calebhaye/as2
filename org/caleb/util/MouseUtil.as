import org.caleb.event.ObservableObject;
import org.caleb.event.Event;
/**
 *
 * @author
 * @version
 **/
class org.caleb.util.MouseUtil
{
	public static function getClosest(elements:Array):MovieClip
	{
		var count:Number = elements.length;
		var candidate:MovieClip;
		var closestClip:MovieClip;
		var closest:Number;
		var amt:Number;
		var xAmt:Number
		var yAmt:Number
		for(var i:Number = 0; i < count; i++)
		{
			candidate = elements[i];
			xAmt = (candidate._x - _root._xmouse);
			yAmt = (candidate._y - _root._ymouse);
			// optimized for speed
			amt = ((xAmt*xAmt) + (yAmt*yAmt));
			
			if(amt > closest || isNaN(closest))
			{
				closestClip = candidate;
				closest = amt;
			}
		}
		
		return closestClip;
	}
	public static function createSelectionMarquee(target:MovieClip, container:MovieClip):ObservableObject
	{
		_root.__staticMarqueeMouseListener = new ObservableObject;
		_root.__staticMarqueeMouseListener.addEventObserver(container, 'onMarqueeSelection');
		var drawbox:MovieClip;
		var px:Number;
		var py:Number;
		
		var fixedHeight:Number = arguments[2];
		var fixedWidth:Number = arguments[3];
		var fixedX:Number = arguments[4];
		var fixedY:Number = arguments[5];

		_root.__staticMarqueeMouseListener.target = target;
		_root.__staticMarqueeMouseListener.container = container;
		_root.__staticMarqueeMouseListener.onMouseDown = function () 
		{
			var gb = this.target.getBounds (this.container);
			if (this.container._xmouse < gb.xMin || this.container._ymouse < gb.yMin || this.container._xmouse > gb.xMax || this.container._ymouse > gb.yMax) 
			{
				return;
			}
			this.startDraw ();
		};
		_root.__staticMarqueeMouseListener.onMouseUp = function () 
		{
			this.stopDraw ();
		};
		_root.__staticMarqueeMouseListener.stopDraw = function () 
		{
			if (!(drawbox._width > 0)) 
			{
				return;
			}
			this.onMouseMove = undefined;
			var gb = this.container.drawbox.getBounds (target._parent);
			var w = this.container.drawbox._width;
			var h = this.container.drawbox._height;
			var x = gb.xMin;
			var y = gb.yMin;
			var e:Event = new Event('onMarqueeSelection');
			e.addArgument('x', x);
			e.addArgument('y', y);
			e.addArgument('w', w);
			e.addArgument('h', h);
			e.addArgument('rectangle', new flash.geom.Rectangle(x, y, w, h));
			e.addArgument('mc', drawbox);
			this.dispatchEvent(e);
		};
		_root.__staticMarqueeMouseListener.startDraw = function () 
		{
			px = this.container._xmouse;
			py = this.container._ymouse;
			if(this.container.drawbox == undefined)
			{
				drawbox = this.container.createEmptyMovieClip ('drawbox', this.container.getNextHighestDepth());
			}
			else
			{
				drawbox = this.container.drawbox;
			}
			drawbox._x = px;
			drawbox._y = py;
			if (this.container.hitTest(this._xmouse, this._ymouse, true) == false) 
			{
				// user has clicked outside of editing canvas, return.
				return;
			}
			this.onMouseMove = function () 
			{
				px = this.container._xmouse;
				py = this.container._ymouse;
				var gb = this.target.getBounds (this.container);
				if (this.container._xmouse < gb.xMin || this.container._ymouse < gb.yMin || this.container._xmouse > gb.xMax || this.container._ymouse > gb.yMax) 
				{
					//return;
				}
				drawbox.clear ();
				drawbox.lineStyle (1, 0x000066, 100);
				drawbox.beginFill (0x000066, 20);
				drawbox.moveTo (0, 0);
				if(isNaN(fixedWidth))
				{
					drawbox.lineTo (px - drawbox._x, 0);
				}
				else
				{
					drawbox.lineTo (fixedWidth, 0);
				}
				if(isNaN(fixedHeight))
				{
					if(isNaN(fixedWidth))
					{
						drawbox.lineTo (px - drawbox._x, py - drawbox._y);
						drawbox.lineTo (0, py - drawbox._y);
					}
					else
					{
						drawbox.lineTo (fixedWidth, py - drawbox._y);
						drawbox.lineTo (0, py - drawbox._y);
					}
				}
				else
				{
					drawbox.lineTo (px - drawbox._x, fixedHeight);
					drawbox.lineTo (0, fixedHeight);
				}
				drawbox.lineTo (0, 0);
				drawbox.endFill ();
				if(isNaN(fixedY) == false)
				{
					drawbox._y = fixedY
				}
				if(isNaN(fixedX) == false)
				{
					drawbox._x = fixedX
				}
				updateAfterEvent ();
			};
		};
		Mouse.addListener (_root.__staticMarqueeMouseListener);
		
		return _root.__staticMarqueeMouseListener;
	}
}