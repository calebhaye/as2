import org.caleb.event.ObservableObject;
/**
* ObservableCountdown
* @description: An object that broadcasts the days, hours, minutes, and seconds every second.
* @usage var cd = new org.caleb.event.ObservableCountDown(new Date(2005, 5, 10));
* @events onCountdownUpdate - broadcast every second, updating with the difference between the supplied date and the current date
* @events onCountdownComplete - broadcast at the completion of the countdown
**/

class org.caleb.timer.ObservableCountdown extends ObservableObject {
	static private var DAY_MS:Number = 86400000;
	static private var HOUR_MS:Number = 3600000;
	static private var MINUTES_MS:Number = 60000;
	private var $timer_si:Number;
	private var $date:Date;
	
	public function Countdown(date) {
		this.$date = date;
		if (this.$date != undefined) {
			clearInterval(this.$timer_si);
			this.$timer_si = setInterval(this, '$timer', 1000);
		}
	}
	
	private function $timer(Void) {
		//get current date to find difference.
        var _current:Date = new Date();
		//find difference between supplied date and the current date.
        var _diff:Number =this.$date.getTime()-_current.getTime();
		//divide to find days.
		var _days:Number = Math.floor(_diff / DAY_MS);
		_diff -= (_days * DAY_MS);
		//divide to find hours.
		var _hours:Number = Math.floor(_diff / HOUR_MS);
		_diff -= (_hours * HOUR_MS);
		//divide to find minutes.
		var _minutes:Number = Math.floor(_diff / MINUTES_MS);
		_diff -= (_minutes * MINUTES_MS);
		//seconds.
		var _seconds:Number = Math.floor(_diff / 1000); 
        if(_days <= 0) {
			//timer complete.
			clearInterval(this.$timer_si); 
			var e = new org.caleb.event.Event('onCountdownComplete');
		} else {
			//broadcast update event.
			var e = new org.caleb.event.Event('onCountdownUpdate');
			e.addArgument('days', _days);
			e.addArgument('hours', _hours);
			e.addArgument('minutes', _minutes);
			e.addArgument('seconds', _seconds);
		}
		this.dispatchEvent(e);
	}
	
};