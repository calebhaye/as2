import org.caleb.maps.api.IMap;
import org.caleb.maps.markers.CustomImageMarker;
import org.caleb.maps.markers.CustomSWFMarker;
import org.caleb.maps.overlays.CustomSWFOverlay;
import org.caleb.maps.widgets.NavigatorWidget;
import org.caleb.maps.tools.PanTool;
import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.collection.SimpleMap;
import org.caleb.event.Event;

class org.caleb.maps.MapManager extends ObservableMovieClip
{
	public static var MONITOR_MARKER_INTERVAL:Number = 1000;
	private var $btn:MovieClip;
	private var $markers:SimpleMap;
	private var $initializedMarkers:SimpleMap;
	private var $monitorMarkerInterval:Number;
	// the following Yahoo! map component is assumed to be present in the .fla
	private var yahooMap:IMap;
	
	public function MapManager()
	{
		this.setClassDescription('org.caleb.maps.MapManager');
		trace('constructor invoked');
		this.addEventObserver(this, 'onMarkerReady');
		this.addEventObserver(this, 'onMarkerWaitInterval');
	}
	public function init():Void
	{
		trace('init invoked');
		// setup data maps (hashtable)
		this.$markers = new SimpleMap;
		this.$initializedMarkers = new SimpleMap;
		// listen to events
		this.yahooMap.addEventListener('initialize', this);
		this.yahooMap.addEventListener('mapGeocodeError', this);
		this.yahooMap.addEventListener('markerGeocodeError', this);
		this.yahooMap.addEventListener('markerGeocodeSuccess', this);
		this.yahooMap.addEventListener('move', this);
		this.yahooMap.addEventListener('panStart', this);
		this.yahooMap.addEventListener('panStop', this);
		this.yahooMap.addEventListener('resize ', this);
		this.yahooMap.addEventListener('toolAdded', this);
		this.yahooMap.addEventListener('toolChange', this);
		this.yahooMap.addEventListener('toolRemoved', this);
		this.yahooMap.addEventListener('zoom', this);
		this.yahooMap.addEventListener('zoomStart', this);
		this.yahooMap.addEventListener('zoomStop', this);		
	}
	// attachment methods
	private function addTools():Void
	{
		this.yahooMap.addTool(new PanTool, true);
	}
	private function addWidgets():Void
	{
		this.yahooMap.addWidget(new NavigatorWidget);
	}
	// marker methods
	public function traceAll()
	{
		trace('traceAll invoked');
		for(var m in this.$markers.values().toArray())
		{
			var foo = this.$markers.values().toArray()[m].mcContainer;
			// for(var i in foo) trace('key: ' + i + ', value: ' + foo[i]);
			trace(this.$markers.values().toArray() + '    ----------------- ')
		}
	}
	private function updateMarkerCollection(marker:Object):Void
	{
		trace('adding marker '+marker.__id+' to private map');
		// set initialized property
		marker.initialized = (marker.mcContainer != undefined);
		// save the map in our private markers array;
		this.$markers.putEntry(marker.__id, marker);
		// initialize the marker
		this.initializeMarker(marker);
	}
	private function initializeMarker():Void
	{
		trace('intializeMarker invoked');
		// unset the interval if all markers are initialized
		if(this.$markers.size() == this.$initializedMarkers.size())
		{
			trace('all markers are initialized, clearing interval');
			clearInterval(this.$monitorMarkerInterval);
			this.$monitorMarkerInterval = undefined;
		}
		else
		{
			// there are uninitialized markers
			trace('there are uninitialized markers');
			
			// if the interval is not running
			if(this.$monitorMarkerInterval == undefined)
			{
				trace('initializing monitor marker interval');
				this.$monitorMarkerInterval = setInterval(this.monitorMarkers, MapManager.MONITOR_MARKER_INTERVAL, this);
			}
		}
	}
	public function onMarkerWaitInterval(e:Event):Void
	{
		trace('onMarkerWaitInterval invoked');
	}
	public function onMarkerReady(e:Event):Void
	{
		trace('onMarkerReady invoked');
		trace("\tlatlon: " + e.getArgument('latlon'));
		trace("\tmap: " + e.getArgument('map'));
		trace("\tindex: " + e.getArgument('index'));
		trace("\tid: " + e.getArgument('id'));
	}
	private function monitorMarkers(mapManager:MapManager):Void
	{
		trace('monitorMarkers invoked: allMarkers.size() ' + mapManager.markers.size() 
		                          + ', initializedMarkers.size(): ' + mapManager.initializedMarkers.size());

		var e = new Event('onMarkerWaitInterval', new Array );
		mapManager.dispatchEvent(e);

		var keys = mapManager.markers.keySet();
		var keysIterator = keys.iterator();
		var value, key;
		while(keysIterator.hasNext())
		{
			key = keysIterator.next();
			value = mapManager.markers.getEntry(key);
			value.initialized = (value.mcContainer != undefined);
			if(value.initialized)
			{
				// make the marker visible
				value._visible = true;
				// set the marker key value
				value.mcContainer.markerKey = key;
				// if the marker has not already been initialized (had init() invoked)
				if(mapManager.initializedMarkers.containsValue(value) == false || mapManager.initializedMarkers.isEmpty())
				{
					// call a method ( init() ) on the external swf
					value.mcContainer.init(value.__id);
					// dispatch event
					var eventArgs = new Array();
					eventArgs['index'] = Number(org.caleb.util.StringUtil.replace(value.__id, 'marker_', ''));
					eventArgs['map'] = value.__owner;
					eventArgs['latlon'] = value.__latlon;
					eventArgs['id'] = value.__id;
					// for(var i in value) trace('key: ' + i + ', value: ' + value[i]);
					var e = new Event('onMarkerReady',eventArgs);
					mapManager.dispatchEvent(e);
				}
				// store
				mapManager.initializedMarkers.putEntry(key, value);
			}
		}
		mapManager.checkMarkerInterval();
	}
	public function checkMarkerInterval():Void
	{
		if(this.$markers.size() == this.$initializedMarkers.size())
		{
			trace('all markers are initialized, clearing interval');
			clearInterval(this.$monitorMarkerInterval);
			this.$monitorMarkerInterval = undefined;
		}
		traceAll();
	}
	// default map event handler methods
	public function initialize(Void):Void
	{
		trace('initialize invoked');
		trace('This event is thrown after the map engine has loaded and is ready for interaction. ');
		this.addTools();
		this.addWidgets();
	}
	public function mapGeocodeError(Void):Void
	{
		trace('mapGeocodeError invoked');
		trace('This event is thrown when there has been a geo-coding error when calling setCenterByAddress. ');
	}
	public function markerGeocodeError(Void):Void
	{
		trace('markerGeocodeError invoked');
		trace('This event is thrown when there has been a geo-coding error when calling addMarkerByAddress. ');
	}
	public function markerGeocodeSuccess(Void):Void
	{
		trace('markerGeocodeSuccess invoked');
		trace('The marker has been successfully placed using addMarkerByAddress. ');
		// save the marker
		if(arguments[0].target = this.yahooMap)
		{
			arguments[0].marker._visible = false;
			this.updateMarkerCollection(arguments[0].marker);
		}
		else
		{
			trace('what is going on?');
		}
	}
	public function move(Void):Void
	{
		trace('move invoked');
		trace('This event is thrown whenever the center of the map changes its lat lon position. ');
	}
	public function panStart(o:Object):Void
	{
		trace('panStart invoked');
		trace('This event is thrown whenever the map starts to pan.');
		trace(this.checkMarkerInterval)
	}
	public function panStop(Void):Void
	{
		trace('panStop invoked');
		trace('Event thrown when panning has stopped.');
	}
	public function resize(Void):Void
	{
		trace('resize invoked');
		trace('resize invoked');
	}
	public function toolAdded(Void):Void
	{
		trace('toolAdded invoked');
		trace('A new tool has been to the map.');
	}
	public function toolChange(Void):Void
	{
		trace('toolChange invoked');
		trace('The currently active tool has changed.');
	}
	public function toolRemoved(Void):Void
	{
		trace('toolRemoved invoked');
		trace('A tool has been removed from the map.');
	}
	public function zoom(Void):Void
	{
		trace('zoom invoked');
		trace('Event thrown during zooming. ');
	}
	public function zoomStart(Void):Void
	{
		trace('zoomStart invoked');
		trace('Event thrown when zooming starts.');
	}
	public function zoomStop(Void):Void
	{
		trace('zoomStop invoked');
		trace('The map has zoomed to the target zoom level');
	}
	// read only properties
	public function get map():IMap
	{
		return this.yahooMap;
	}
	public function get monitorMarkerInterval():Number
	{
		return this.$monitorMarkerInterval;
	}
	public function get markers():SimpleMap
	{
		return this.$markers;
	}
	public function getMarkerAtIndex(index:Number):MovieClip
	{
		var marker:MovieClip = MovieClip(CustomSWFMarker(this.$markers.getEntry('marker_' + index.toString())).mcContainer);
		return marker;
	}
	public function get initializedMarkers():SimpleMap
	{
		return this.$initializedMarkers;
	}
}