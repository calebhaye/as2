import org.caleb.event.ObservableObject;

class org.caleb.components.charting.PieChart extends ObservableObject
{
	public static var instances:Number = 0;
	private var _mc:MovieClip;
	private var radius:Number;
	private var startAngle:Number;
	private var divisions:Array;

	public function PieChart(x, y, radius, timeline, depth, /*optional:*/ startAngle)
	{
		this.setClassDescription('org.caleb.components.charting.PieChart');
		PieChart.instances++;
		this._mc = timeline.createEmptyMovieClip("PieChartInstance"+PieChart.instances, depth);
		this._mc._x = x; this._mc._y = y;
		this.radius = radius;
		this.divisions = new Array();
		this.startAngle = (startAngle == undefined) ? 0 : startAngle;
	}

	public function setStartAngle(angleR)
	{
		this.startAngle = angleR;
	}
	public function setRadius(radius)
	{
		this.radius = radius;
	}
	public function setPosition(x,y)
	{
		this._mc._x = x; 
		this._mc._y = y;
	}
	public function insertSlice(position, percent, fillColor)
	{
		this.divisions.splice(position, 0, {p:percent, c:fillColor});
		return position;
	}
	public function appendSlice(percent, fillColor)
	{
		return this.insertSlice(this.divisions.length, percent, fillColor);
	}
	public function removeSlice(position)
	{
		this.divisions.splice(position, 1);
	}
	public function clearSlices()
	{
		this.divisions = new Array();
	}
	public function setSlicePercent(position, percent)
	{
		//this.trace('setSlicePercent invoked w/ percent: ' + percent);
		this.divisions[position].p = percent;
	}
	public function getSlicePercent(position):Number
	{
		return this.divisions[position].p;
	}
	public function getTotalPercent():Number
	{
		var tot = 0;
		for (var i=0; i<this.divisions.length; i++) tot += this.divisions[i].p;
		return tot;
	}
	public function render()
	{
		this._mc.clear();
		//this._mc.lineStyle(0,0,100);
		var a1:Number = this.startAngle;
		var a2:Number;
		for (var i=0; i<this.divisions.length; i++)
		{
			a2 = a1 + this.divisions[i].p*Math.PI*2;
			if (this.divisions[i].p)
			{
				this._mc.beginFill(this.divisions[i].c, 100);
				var eventArguments:Array = org.caleb.util.DrawingUtil.drawCircleSegment(_mc, 0, 0, a1, a2, this.radius, "CW");
				eventArguments['percent'] = this.getTotalPercent();
				eventArguments['sliceIndex'] = i;
				var e:org.caleb.event.Event = new org.caleb.event.Event('onSegmentRendered');
				e.setArguments(eventArguments);
				this.dispatchEvent(e);
				this._mc.lineTo(0,0);
				this._mc.endFill();
			}
			a1 = a2;
		}
	}
	public function get view():MovieClip
	{
		return this._mc;
	}
}