import org.caleb.core.CoreObject;
/**
 * 
 * RGB Set
 *
 * Prime unit for an RGB value. Stores a Red, Green and Blue value, all integers, all base 10.
 * The constructor accepts three args (r, g, b) or zero. 
 * Accessors and mutators exist for handling the private members.
 * The toHex method converts the object to a hexidecimal number.
 *
 * Pass these around as arguments, store them. They're basically just a wrapper
 * for a secondary data type (primary within the scope of a Color management system).
 * @see     CoreObject	
 */
class org.caleb.color.CoreRGB extends CoreObject
{
	private var $red:Number;
	private var $green:Number;
	private var $blue:Number;

	public function CoreRGB(){
		super();
		this.setClassDescription('org.caleb.color.CoreRGB');
		var a = arguments;
		var a0 = a[0];
		var len = a.length;
		if(len==3){
			this.setRed(parseFloat(a0));
			this.setGreen(parseFloat(a[1]));
			this.setBlue(parseFloat(a[2]));
		}else if (len == 1) {
		    var c:Object;
			var _r, _g, _b;
			switch (typeof a0) {
				case 'object':
					//if passing RGB object
					c = new CoreRGB(a0.getRGB());
					break;
				case 'number':
					//creates new RGB
					//if passing a hex or decimal number
					c = getRGBValues(a0);
					break;
				case 'string':
					//creates new RGB
					//if passing a hex string w/o 0x
					c = getRGBValues(parseInt(a0, 16));
					break;
			}

			this.setRed(c.getRed());
			this.setGreen(c.getGreen());
			this.setBlue(c.getBlue());
		}
	}

	/**
	 * 
	 * @param   r integer, base 10
	 */
	public function setRed(r:Number):Void{
		this.$red=r;
	}

	public function getRed(Void):Number{
		return this.$red;
	}

	/**
	 * 
	 * @param   g integer, base 10
	 */
	public function setGreen(g:Number):Void{
		this.$green=g;
	}

	public function getGreen(Void):Number{
		return this.$green;
	}

	/**
	 * 
	 * @param   b integer, base 10
	 */
	public function setBlue(b:Number):Void{
		this.$blue=b;
	}

	public function getBlue(Void):Number{
		return this.$blue;
	}

	public function getHEX(Void):Number{
		var s = new String('0x');
		var r = this.$red.toString(16);
		s += (r.length<2)?('0'+r):r;
		var g = this.$green.toString(16);
		s += (g.length<2)?('0'+g):g;
		var b = this.$blue.toString(16);
		s += (b.length<2)?('0'+b):b;
		return s;
	}

	public function getRGB(Void):Number{
		return parseInt(String(this.getHEX()));
	}

	//Returns separated colors as new object
	private function getRGBValues(color:Number):CoreRGB
	{
		var _r = (color >> 16);
		var _g = (color >> 8 ^ _r << 8);
		var _b = (color ^ (_r << 16 | _g << 8));
		return new CoreRGB(_r, _g, _b);
	}
}


