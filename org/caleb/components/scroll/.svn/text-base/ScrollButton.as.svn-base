import org.caleb.components.scroll.Scroll;
import org.caleb.movieclip.CoreMovieClip;

class org.caleb.components.scroll.ScrollButton extends CoreMovieClip
{
	public static var MODE_TWEEN:Number 	 = 0x000001
	public static var MODE_CLICK:Number 	 = 0x000011
	public static var DIRECTION_UP:Number 	 = 0x000111
	public static var DIRECTION_DOWN:Number	 = 0x001111
	public static var DIRECTION_LEFT:Number  = 0x011111
	public static var DIRECTION_RIGHT:Number = 0x111111
	private var $mode:Number;
	private var $scrollDirection:Number;
	private var $scroll:Scroll;
	
	function ScrollButton()
	{
		this.setClassDescription('org.caleb.components.scroll.ScrollButton');
		// default mode
		this.$mode = ScrollButton.MODE_TWEEN;
	}
	public function onRelease()
	{
		this.$scroll.stop();
	}
	// read/write
	public function set scroll(s:Scroll):Void
	{
		this.$scroll = s;
	}
	public function get scroll():Scroll
	{
		return this.$scroll;
	}
	public function get mode():Number
	{
		return this.$mode;
	}
	public function set mode(m:Number):Void
	{
		this.$mode = m;
	}
	public function get scrollDirection():Number
	{
		return this.$scrollDirection;
	}
	public function set scrollDirection(d:Number):Void
	{
		this.$scrollDirection = d;
		switch(this.$scrollDirection)
		{
			case ScrollButton.DIRECTION_UP:
			{
				switch(this.$mode)
				{
					case ScrollButton.MODE_TWEEN:
					{
						this.onPress = function()
						{
							this.$scroll.holdUp();
						}
					}
					break;
					case ScrollButton.MODE_CLICK:
					{
						this.onPress = function()
						{
							this.$scroll.clickUp();
						}
					}
					break;
				}
			}
			break;
			case ScrollButton.DIRECTION_DOWN:
			{
				switch(this.$mode)
				{
					case ScrollButton.MODE_TWEEN:
					{
						this.onPress = function()
						{
							this.$scroll.holdDown();
						}
					}
					break;
					case ScrollButton.MODE_CLICK:
					{
						this.onPress = function()
						{
							this.$scroll.clickDown();
						}
					}
					break;
				}
			}
			break;
			case ScrollButton.DIRECTION_LEFT:
			{
				switch(this.$mode)
				{
					case ScrollButton.MODE_TWEEN:
					{
						this.onPress = function()
						{
							this.$scroll.holdLeft();
						}
					}
					break;
					case ScrollButton.MODE_CLICK:
					{
						this.onPress = function()
						{
							this.$scroll.clickLeft();
						}
					}
					break;
				}
			}
			break;
			case ScrollButton.DIRECTION_RIGHT:
			{
				switch(this.$mode)
				{
					case ScrollButton.MODE_TWEEN:
					{
						this.onPress = function()
						{
							this.$scroll.holdRight();
						}
					}
					break;
					case ScrollButton.MODE_CLICK:
					{
						this.onPress = function()
						{
							this.$scroll.clickRight();
						}
					}
					break;
				}
			}
			break;
		}
	}
}