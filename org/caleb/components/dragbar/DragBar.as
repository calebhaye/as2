/**
 * Untested
 */
class org.caleb.components.DragBar extends org.caleb.widgets.YahooButton 
{
	private var $scrollmax:Number;
	//
	function DragBar () {
		super();
		org.caleb.decorator.Observer.makeObservable(this);
	}
	function onRollOver () {
		super.onRollOver();
		this.useHandCursor = false;
	}
	function onPress () {
		super.onPress();
		this.startDrag(false, this._x, 0, this._x, this.getScrollmax());
		this.useHandCursor = false;
		this.onMouseMove = this.updateScrollPosition;
	}
	function onRelease () {
		super.onRelease();
		this.useHandCursor = false;
		stopDrag();
		this.onMouseMove = undefined;
	}
	public function getScrollmax():Number{
		return this.$scrollmax;
	}
	public function setScrollmax(arg:Number):Void{
		this.$scrollmax = arg;
	}
	private function updateScrollPosition () {
		var e:org.caleb.event.Event = new org.caleb.event.Event('onScrollChange');
		this.dispatchEvent(e);
	}
	private function onLock () {
		this._visible = false;
		this._parent.useHandCursor = false;
	}
	private function onUnlock () {
		this._visible = true;
		this.useHandCursor = true;
	}
	public function scrollDown () {
		this._y = Math.min(this._y+2, this.getScrollmax());
		this.updateScrollPosition();
	}
	public function scrollUp () {
		this._y = Math.max(this._y-2, 0);
		this.updateScrollPosition();
	}
	



}