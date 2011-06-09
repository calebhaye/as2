import org.caleb.color.CoreRGB;
//
class org.caleb.color.CoreHSB extends CoreRGB {
	private var $hue:Number;
	private var $saturation:Number;
	private var $brightness:Number;
	
	
	/**
	*	Creates basic HSB Value holder.
	*	@availability Flash Player 6.
	*	@edition Flash MX 2004
	*	@since Version 1.0
	*	@param h Number; Hue with value 0-360
	*	@param s Number; Saturation with value 0-1
	*	@param b Number; Brightness with value 0-1
	*/
	public function CoreHSB(h, s, b){
		super();
		this.setClassDescription('org.caleb.color.CoreHSB');
		this.setHue(h);
		this.setSaturation(s);
		this.setBrightness(b);
		this.setRGB();
	}
	
	/**
	*	Returns the hue of the HSB Object
	*	@availability Flash Player 6.
	*	@edition Flash MX 2004
	*	@since Version 1.0
	*	@return Number
	*/
	public function getHue():Number{
		return this.$hue;
	}
	
	/**
	*	Sets the hue of the HSB Object
	*	@availability Flash Player 6.
	*	@edition Flash MX 2004
	*	@since Version 1.0
	*	@param h Number
	*/
	public function setHue(h:Number):Void{
		this.$hue = h;
		this.setRGB();
	}
	
	/**
	*	Returns the saturation of the HSB Object
	*	@availability Flash Player 6.
	*	@edition Flash MX 2004
	*	@since Version 1.0
	*	@return Number
	*/
	public function getSaturation():Number{
		return this.$saturation;
	}

	/**
	*	Sets the saturation of the HSB Object
	*	@availability Flash Player 6.
	*	@edition Flash MX 2004
	*	@since Version 1.0
	*	@param s Number
	*/
	public function setSaturation(s:Number):Void{
		this.$saturation = s;
		this.setRGB();
	}
	
	/**
	*	Returns the value of the HSB Object
	*	@availability Flash Player 6.
	*	@edition Flash MX 2004
	*	@since Version 1.0
	*	@return Number
	*/
	public function getBrightness():Number{
		return this.$brightness;
	}
	
	/**
	*	Sets the value of the HSB Object
	*	@availability Flash Player 6.
	*	@edition Flash MX 2004
	*	@since Version 1.0
	*	@param b Number
	*/
	public function setBrightness(b:Number):Void{
		this.$brightness = b;
		this.setRGB();
	}
	
	/**
	*	Sets Red value of CoreRGB object
	*	@availability Flash Player 6.
	*	@edition Flash MX 2004
	*	@since Version 1.0
	*	@param r Number
	*/
	public function setRed(r:Number):Void{
		this.$red = r;
		this.setHSB();
	}
	
	/**
	*	Sets Green value of CoreRGB object
	*	@availability Flash Player 6.
	*	@edition Flash MX 2004
	*	@since Version 1.0
	*	@param g Number
	*/
	public function setGreen(g:Number):Void{
		this.$green = g;
		this.setHSB();
	}
	
	
	/**
	*	Sets Blue value of CoreRGB object
	*	@availability Flash Player 6.
	*	@edition Flash MX 2004
	*	@since Version 1.0
	*	@param b Number
	*/
	public function setBlue(b:Number):Void{
		this.$blue = b;
		this.setHSB();
	}
	
	/** @exclude private helper function */
	private function setRGB () {
		// converts HSV values to RGB
		var h = this.getHue();
		var s = this.getSaturation();
		var b = this.getBrightness();
		//
		b *= 255;
		if (s == 0)
		{
			// achromatic (gray)
			this.$red = b;
			this.$green = b;
			this.$blue = b;
		}
		else
		{
			h /= 60;
			var i = Math.floor(h);
			var f = h - i;
			var p = b * (1 - s);
			var q = b * (1 - s * f);
			var t = b * (1 - s * (1 - f));
			if (i == 0)
			{
				this.$red = b;
				this.$green = t;
				this.$blue = p;
				return;
			}
			else if (i == 1)
			{
				this.$red = q;
				this.$green = b;
				this.$blue = p;
				return;
			}
			else if (i == 2)
			{
				this.$red = p;
				this.$green = b;
				this.$blue = t;
				return;
			}
			else if (i == 3)
			{
				this.$red = p;
				this.$green = q;
				this.$blue = b;
				return;
			}
			else if (i == 4)
			{
				this.$red = t;
				this.$green = p;
				this.$blue = b;
				return;
			}
			else if (i == 5)
			{
				this.$red = b;
				this.$green = p;
				this.$blue = q;
				return;
			}
			else
			{
				// if (i > 5)
				// i = 5; // Prevent problem if hue is exactly 1
				this.$red = b;
				this.$green = p;
				this.$blue = q;
				return;
			}
		}
	}
	
	private function setHSB() {
		var r = this.getRed();
		var g = this.getGreen();
		var b = this.getBlue();
		var mx; // maximum RGB component color value
		var mn; // minimum " 
		var diff;
		
		mx = Math.max(r, Math.max(g, b));
		mn = Math.min(r, Math.min(g, b));
		diff = mx - mn;
		this.$brightness = mx / 255;
		if (mx > 0.0) {
			this.$saturation = diff / mx;
		} else {
			this.$saturation = 0.0;
		}
		if (this.$saturation > 0.0)
		{
			if (r == mx)
				this.$hue = (g - b) / diff;
			else if (g == mx)
				this.$hue = 2.0 + (b - r) / diff;
			else if (b == mx)
				this.$hue = 4.0 + (r - g) / diff;
			this.$hue *= 60;
			if (this.$hue < 0.0)
				this.$hue = this.$hue + 360.0;
		}
		else
		{
			this.$hue = 0.0;		/* doesn't matter, since black anyway */
		}
	}

}