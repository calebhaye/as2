import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.geom.Matrix;
import flash.geom.ColorTransform;

/**
 * Bitmap Util Class.  Requires Flash 8.
 * 
 * @usage   
 * @param   mc 
 * @param   x  
 * @param   y  
 * @param   w  
 * @param   h  
 * @return  
 */

class org.caleb.util.BitmapUtil   
{
	public static function getMovieClipSnapshot(mc, x, y, w, h):BitmapData
	{	
		var returnBitmap:BitmapData = new BitmapData(w, h, true);
		var myMatrix:Matrix = new Matrix;
		var translateMatrix:Matrix = new Matrix;
		translateMatrix.translate(-x, -y);
		myMatrix.concat(translateMatrix);
		var blendMode:String = "normal";
		var myRectangle:Rectangle = new Rectangle(0, 0, w, h);
		var smooth:Boolean = true;	
		returnBitmap.draw(mc, myMatrix, new ColorTransform(), blendMode, myRectangle, smooth);
		
		return returnBitmap;
	}
}