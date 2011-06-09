import org.caleb.color.CoreRGB;
import org.caleb.core.CoreObject;

/**
 * 
 * @see     CoreObject	
 */
class org.caleb.color.ColorUtil extends CoreObject{
	//takes CoreRGB objects as arg
	/**
	 * 
	 * @param   a 
	 * @param   b 
	 */
	public static function getDifference(a:Object, b:Object)
	{
		var r = Math.abs(b.getRed() - a.getRed());
		var g = Math.abs(b.getGreen() - a.getGreen());
		var b = Math.abs(b.getBlue() - a.getBlue());
		return new CoreRGB(r, g, b);
	}


	//takes CoreRGB objects as arg
	/**
	 * 
	 * @param   a         
	 * @param   b         
	 * @param   stepCount 
	 */
	public static function getDifferenceAsSteps(a:Object, b:Object, stepCount:Number)
	{
		var r = ((b.getRed() - a.getRed()) / stepCount);
		var g =((b.getGreen() - a.getGreen()) / stepCount);
		var b =((b.getBlue() - a.getBlue()) / stepCount);  

		var rgb = new CoreRGB(r, g, b);

		var rgbVector = new Array(); // should be a proper Vector
		var i=0;
		var obj:CoreRGB;
		while(i < stepCount){
			//picks previous color as startpoint
			obj = (i > 0) ? rgbVector[i-1] : a;
			rgbVector.push(new SimpleRGB(obj.getRed() + r, obj.getGreen() + g, obj.getBlue() + b));
			i++;
		}
		return rgbVector;
	}

	public static function paintRGB(target:MovieClip, newRed:String, newGreen:String, newBlue:String):String
	{
		// todo: see if the signature will allow casting to Number for FF, etc
	
		// create color from target
		var newColor:Color = new Color(target);
		// verify integrity of values
		(Number(newRed) < 16) ? newRed = '0' + newRed.toString(16) : newRed = newRed.toString(16);
		(Number(newGreen) < 16) ? newGreen = '0' + newGreen.toString(16) : newGreen = newGreen.toString(16);
		(Number(newBlue) < 16) ? newBlue = '0' + newBlue.toString(16) : newBlue = newBlue.toString(16);
		// set the new RGB values
		newColor.setRGB(parseInt('0x' + newRed + newGreen + newBlue));
		
		// return the newly applied color
		return "#" + newRed + newGreen + newBlue;
	}
}