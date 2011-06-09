import org.caleb.event.ObservableObject;
/*
 * EventQueue.as
 *
 * Creates a order-dependant chain of events.
 * @see ObservableObject
 */

class org.caleb.event.EventQueue extends ObservableObject
{
	private var $scope:Object;
	private var $steps:Array;
	private var $step:Number;
	
	/**
	 * EventQueue Sole Constructor
	 * @usage	org.caleb.event.EventQueue()
	 **/
	
	public function EventQueue()
	{
		this.$step = -1;
	}
	
	/**
	 * Sets persistant scope for events to be called on.
	 * @usage	org.caleb.event.EventQueue.scope = objectReference;
	 * @param	objectReference (Object) object to have events called on it.
	 **/
	public function set scope(objectReference):Void {
		this.$scope = objectReference;
	}
	
	/**
	 * Returns persistant scope.
	 * @usage	org.caleb.event.EventQueue.scope
	 * @return	Object
	 **/
	public function get scope():Object 
	{
		return this.$scope;
	}
	
	/**
	 * Sets the events in the order that they are to be called
	 * @usage org.caleb.event.EventQueue.steps = ['methodname1', 'methodname2', 'methodname3'];
	 * @param	arg	(Array)	An array of method names, as strings, to be called in the order listed.
	 **/
	public function set steps(arg:Array):Void {
		this.$steps = arg;
	}	
	
	/**
	 * Returns events to be called
	 * @usage	org.caleb.event.EventQueue.steps;
	 * @return	Array
	 **/
	public function get steps():Array {
		return this.$steps;
	}
	
	
	
	
	/**
	 * Advances the cursor throught the event array. Should be used to begin the eventqueue process, as well as continue it following the completion of an event call.
	 * Will call onIteratorHasCompleted upon completion.
	 * @usage	org.caleb.event.EventQueue.next();
	  **/
	
	public function next() {
		if (this.$steps.length == 0) {
			trace('*********************************');
			trace('Iterator error: Steps not defined.');
			trace('*********************************');
			var e = new org.caleb.event.Event('onIteratorHasFailed');
			e.addArgument('error', 'Iterator error: Steps not defined.');
			this.dispatchEvent(e);
			return;
		}
		if (++this.$step < this.$steps.length) {
			if (this.$scope[this.$steps[this.$step]] != undefined) {
				this.$scope[this.$steps[this.$step]].apply(this.$scope);
			} else {
				//function does not exist.
				var e = new org.caleb.event.Event('onIteratorHasFailed');
				e.addArgument('error', 'Iterator error: Function does not exist.');
				this.dispatchEvent(e);
				trace('*********************************');
				trace('Iterator error: Function does not exist.');
				trace('Function:' + this.$steps[this.$step] + ' at scope ' + this.$scope);
				trace('*********************************');
			}
		} else {
			var e = new org.caleb.event.Event('onIteratorHasCompleted');
			this.dispatchEvent(e);
		}
	}
}