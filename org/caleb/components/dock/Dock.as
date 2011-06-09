import org.caleb.movieclip.CoreMovieClip;

/**
 * 
 * @author  calebh
 * @version 1.0
 * @see     CoreMovieClip	
 * @since   
 */
class org.caleb.components.dock.Dock extends CoreMovieClip 
{
	var icon_min		: Number;
	var icon_max		: Number;
	var icon_size		: Number;
	var icon_spacing	: Number;
	var width			: Number;
	var span			: Number;
	var amplitude		: Number;
	var ratio			: Number;
	var scale			: Number = Number.NEGATIVE_INFINITY;
	var trend			: Number = 0;
	var xmouse			: Number;
	var ymouse			: Number;
	var layout			: String;
	var callback		: Function;
	var items			: Array;

	/**
	 * Sole Constructor
	 */
	public function Dock() 
	{
		this.setClassDescription('org.caleb.components.dock.Dock');
	}
	/**
	 * Initialize the dock
	 * @return  
	 */
	public function init()
	{
		setParameters();
		setLayout();
		createIcons();
		createTray();
		onEnterFrame = monitorDock;
	}
	private function setParameters():Void {
		this.layout = this.layout ? this.layout : 'bottom';
		this.icon_min = this.icon_min ? this.icon_min : 32;
		this.icon_max = this.icon_max ? this.icon_max : 96;
		this.icon_spacing = this.icon_spacing ? this.icon_spacing : 2;
		this.span = this.span ? this.span : getSpan();
		this.amplitude = this.amplitude ? this.amplitude : getAmplitude();
		this.ratio =  Math.PI / 2 / this.span;
	}

	private function getSpan():Number {
		return (this.icon_min - 16) * (240 - 60) / (96 - 16) + 60;
	}

	private function getAmplitude():Number {
		return 2 * (this.icon_max - this.icon_min + this.icon_spacing);
	}

	private function createIcons():Void {
		var i:Number;
		var id:String;
		this.scale = 0;
		this.width = (this.items.length - 1) * this.icon_spacing + this.items.length * this.icon_min;
		var left:Number = (this.icon_min - this.width) / 2;
		for(i = 0; i < this.items.length; i++) 
		{
			var icon = this.createEmptyMovieClip(String(i), i + 10).attachMovie(this.items[i].id, '_mc', 1);
			this[i]._mc._y = -this.icon_size / 2;
			this[i]._mc._rotation = -this._rotation;
			this[i]._x = this[i].x = left + i * (this.icon_min + this.icon_spacing) + this.icon_spacing / 2;
			this[i]._y = -this.icon_spacing;
			this[i].onRelease = launchIcon;
			//this[i].useHandCursor = false;
		}
	}

	private function launchIcon():Void {
		trace('yo'+this._parent.items[this._name].label)
		this._parent.callback(this._parent.items[this._name].label);
	}

	private function createTray():Void {
		var height:Number = this.icon_min + 2 * this.icon_spacing;
		var width:Number = this.width + 2 * this.icon_spacing;
		var mc:MovieClip = this.createEmptyMovieClip('tray_mc', 1);
		mc.lineStyle(0, 0xcccccc, 80);
		mc.beginFill(0xe8e8e8, 50);
		mc.lineTo(0, -height);
		mc.lineTo(width, -height);
		mc.lineTo(width, 0);
		mc.lineTo(0, 0);
		mc.endFill();
	}

	private function setLayout():Void {
		switch(this.layout) {
			case 'left':
				this._rotation = 90;
				break;
			case 'top':
				this._rotation = 180;
				break;
			case 'right':
				this._rotation = 270;
				break;
			default:
				this._rotation = Number(this.layout);
		}
	}

	private function checkBoundary():Boolean {
		var buffer:Number = 4 * this.scale;
		return (this.ymouse < 0)
			&& (this.ymouse > -2 * this.icon_spacing - this.icon_min + (this.icon_min - this.icon_max) * this.scale)
			&& (this.xmouse > this[0]._x - this[0]._width / 2 - this.icon_spacing - buffer)
			&& (this.xmouse < this[this.items.length - 1]._x + this[this.items.length - 1]._width / 2 + this.icon_spacing + buffer);
	}

	private function updateTray():Void {
		var x:Number;
		var w:Number;
		x = this[0]._x - this[0]._width / 2 - this.icon_spacing;
		w = this[this.items.length - 1]._x + this[this.items.length - 1]._width / 2 + this.icon_spacing;
		this['tray_mc']._x = x;
		this['tray_mc']._width = w - x;
	}

	private function monitorDock():Boolean {
		var i:Number;
		var x:Number;
		var dx:Number;
		var dim:Number;

		// Mouse did not move and Dock is not between states. Skip rest of the block.
		if((this.xmouse == this._xmouse) && (this.ymouse == this._ymouse) && ((this.scale <= 0.01) || (this.scale >= 0.99))) { return false; }

		// Mouse moved or Dock is between states. Update Dock.
		this.xmouse = this._xmouse;
		this.ymouse = this._ymouse;

		// Ensure that inflation does not change direction.
		this.trend = (this.trend == 0 ) ? (checkBoundary() ? 0.25 : -0.25) : (this.trend);
		this.scale += this.trend;
		if( (this.scale < 0.02) || (this.scale > 0.98) ) { this.trend = 0; }

		// Actual scale is in the range of 0..1
		this.scale = Math.min(1, Math.max(0, this.scale));

		// Hard stuff. Calculating position and scale of individual icons.
		for(i = 0; i < this.items.length; i++) {
			dx = this[i].x - this.xmouse;
			dx = Math.min(Math.max(dx, -this.span), this.span);
			dim = this.icon_min + (this.icon_max - this.icon_min) * Math.cos(dx * this.ratio) * (Math.abs(dx) > this.span ? 0 : 1) * this.scale;
			this[i]._x = this[i].x + this.scale * this.amplitude * Math.sin(dx * this.ratio);
			this[i]._xscale = this[i]._yscale =  100 * dim / this.icon_size;
		}

		// Resize tray to contain icons.
		updateTray();
		return true;
	}

}
