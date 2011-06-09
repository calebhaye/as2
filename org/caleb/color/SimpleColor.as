import org.caleb.event.Event;
import org.caleb.event.EventDispatcher;
import org.caleb.event.Observable;

/**
 * 
 * @see     Color	
 * @see     Observable	
 */
class org.caleb.color.SimpleColor extends Color implements Observable{
    var clip:MovieClip;
    //
	/**
	 * 
	 * @param   mc 
	 */
	public function SimpleColor(mc:MovieClip)
	{
		//	instantiate the superclass if we have an arg.
		if(arguments.length > 0){
			this.setClip(mc);
			super(this.clip);
		}
		this.$eventDispatcher = new EventDispatcher();
	}
	//	private mutator for the clip
	/**
	 * 
	 * @param   mc 
	 */
	private function setClip(mc:MovieClip):Void{
		this.clip = mc;
	}
	//	accessor for the clip
	public function getClip():MovieClip{
		return this.clip;
	}
	//	Build a polymorphic mutator delegate
	public function setColor(){
		var a = arguments;
		//	switch through the possible argument types. this will make this
		//	method slower than using the direct mutator for the proper type.
		//	test for length
		var len = a.length;
		//	let's see how many args we were passed.
		switch (len){
			case 1: //	we have a single hex arg or CoreRGB object
				var value = a[0];
				var type = typeof value;
				if(type == "object"){
					//	we have an CoreRGB object.
					this.setRGB(value.getHEX());
				}else if(type =="number"){
					//	we have a number.
					this.setRGB(value);
				}else{
					this.setRGB(parseInt(new String('0x' + value), 16));
				}
				break;
			case 3:	//	we have an RGB trio. 
				var r = parseFloat(a[0]);
				var g = parseFloat(a[1]);
				var b = parseFloat(a[2]);
				var rgb = new org.caleb.color.CoreRGB(r,g,b);
				this.setRGB(rgb.getHex());
				break;
		}
	}
	/**
	 * 
	 * @param   hex 
	 */
	public function getRGBValues(hex:Boolean){
		var color = this.getRGB();
		var _r = (color >> 16);
		var _g = (color >> 8 ^ _r << 8);
		var _b = (color ^ (_r << 16 | _g << 8));
		if (hex) {
			// ** returns RGB as hexidecimal
			_r = _r.toString(16);
			_g = _g.toString(16);
			_b = _b.toString(16);
			if(_r.length < 2){
				_r = '0' + _r;
			}
			if(_g.length < 2){
				_g = '0' + _g;
			}
			if(_b.length < 2){
				_b = '0' + _b;
			}
			return {r:_r, g:_g, b:_b};
		} else {
			// ** returns RGB as decimal
			return {r:_r, g:_g, b:_b};
		}
	}
	/**
	 * conform to the Observable interface	 and delegate calls to org.caleb.event.EventDispatcher
	 * 
	 * @param   observerObject 
	 * @param   messageName    
	 */
	public function addEventObserver(observerObject, messageName:String):Void{
		this.$eventDispatcher.addEventObserver(observerObject, messageName);
	}

	/**
	 * conform to the Observable interface	 and delegate calls to org.caleb.event.EventDispatcher
	 * 
	 * @param   observerObject 
	 * @param   messageName    
	 */
	public function removeEventObserver(observerObject, messageName:String):Void{
		this.$eventDispatcher.removeEventObserver(observerObject, messageName);
	}
	
	/**
	 * conform to the Observable interface	 and delegate calls to org.caleb.event.EventDispatcher
	 * 
	 */
	public function removeAllEventObservers():Void{
		this.$eventDispatcher.removeAllEventObservers();
	}

	/**
	 *	public dispatch method. delegates to org.caleb.event.EventDispatcher
	 * 
	 * @param   e 
	 */
	public function dispatchEvent(e:org.caleb.event.Event):Void{
		this.$eventDispatcher.dispatchEvent(e, this);
	}
}



