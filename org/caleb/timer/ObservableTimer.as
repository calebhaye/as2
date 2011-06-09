import org.caleb.event.ObservableObject

/**
 *
 * @author
 * @version
 **/
class org.caleb.timer.ObservableTimer extends ObservableObject  
{
	private var $startTime;
	private var $pauseTime;
	
	public function ObservableTimer(start)
	{
		this.setClassDescription('org.caleb.timer.ObservableTimer');
		this.reset(false);
	}

	public function start():Void
	{
		if (this.$pauseTime)
		{
			this.$startTime += getTimer() - this.$pauseTime;
			this.$pauseTime = 0;
		}
		else
		{
			this.reset(true);
		}
	}
	public function stop():Void
	{
		if (!this.$pauseTime) this.$pauseTime = getTimer();
	}
	public function reset(restart:Boolean):Void
	{
		this.$startTime = getTimer();
		if (!this.$startTime) this.$startTime = 1;
		if (restart) this.$pauseTime = 0;
		else this.$pauseTime = this.$startTime;
	}
	public function get time():Number
	{
		if (this.$pauseTime) return this.$pauseTime - this.$startTime;
		var gotTime = getTimer();
		if (!gotTime) gotTime = 1;
		return gotTime - this.$startTime;
	}
	public function set time(t:Number):Void
	{
		this.$startTime = getTimer() - t;
	}

	public function get paused():Boolean
	{
		return (this.$pauseTime) ? true : false;
	}
	public function set paused(p:Boolean):Void
	{
		if (p == Boolean(this.$pauseTime)) return;
		if (p) this.stop();
		else this.start();
	}
}