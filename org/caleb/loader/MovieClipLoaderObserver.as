import org.caleb.event.ObservableObject
import org.caleb.event.Event;

class org.caleb.loader.MovieClipLoaderObserver extends ObservableObject  
{
	private var $name:String;
	private var $loader:MovieClipLoader;
	private var $e:Event;

	public function MovieClipLoaderObserver(name:String, loader:MovieClipLoader)
	{
		this.setClassDescription('org.caleb.loader.MovieClipLoaderObserver');
		////trace('constructor invoked w/ name: ' + name);
		//trace('loader: ' + loader)
		this.$name = name;
		if(loader == undefined)
		{
			this.$loader = new MovieClipLoader;
		}
		else
		{
			this.$loader = loader;
		}
		this.$loader.addListener(this);
	}
	public function loadClip(url:String, target:Object):Void
	{
		var newTarget:MovieClip = target.createEmptyMovieClip('shape', target.getNextHighestDepth());
		
		this.$loader.loadClip(url, newTarget);
	}
	public function observeAllEvents(arg:Object):Void
	{
		this.addEventObserver(arg, 'onLoadComplete');
		this.addEventObserver(arg, 'onLoadError');
		this.addEventObserver(arg, 'onLoadInit');
		this.addEventObserver(arg, 'onLoadProgress');
		this.addEventObserver(arg, 'onLoadStart');
	}
	/**
	* Invoked when a file that was loaded with MovieClipLoader.loadClip() is completely downloaded.
	*/
	public function onLoadComplete(target_mc:MovieClip, httpStatus:Number):Void 
	{
		//trace('onLoadComplete invoked');
		this.$e.setType('onLoadComplete');
		this.$e.addArgument('name', this.$name);
		this.$e.addArgument('target_mc', target_mc._parent);
		this.$e.addArgument('httpStatus', httpStatus);
		this.dispatchEvent(this.$e);
	}
	/**
	* Invoked when a file loaded with MovieClipLoader.loadClip() has failed to load.
	*/
	public function onLoadError(target_mc:MovieClip, errorCode:String, httpStatus:Number):Void 
	{
		trace('onLoadError invoked');
		this.$e = new Event('onLoadError');
		this.$e.addArgument('name', this.$name);
		this.$e.addArgument('target_mc', target_mc._parent);
		this.$e.addArgument('errorCode', errorCode);
		this.$e.addArgument('httpStatus', httpStatus);
		this.dispatchEvent(this.$e);
	}
	/**
	* Invoked when the actions on the first frame of the loaded clip have been executed.
	*/
	public function onLoadInit(target_mc:MovieClip):Void
	{
		//trace('onLoadInit invoked');
		//trace('target_mcinstanceof MovieClip: ');
		//trace(target_mc instanceof MovieClip)
		//trace('target_mc._width: ' + target_mc._width);
		//for(var i in arguments) trace('key: ' + i + ', value: ' + arguments[i]);
		this.$e = new Event('onLoadInit');
		this.$e.addArgument('name', this.$name);
		this.$e.addArgument('target_mc', target_mc._parent);
		this.dispatchEvent(this.$e);
	}
	/**
	* Invoked every time the loading content is written to the hard disk during the loading process (that is, between MovieClipLoader.onLoadStart and MovieClipLoader.onLoadComplete).
	*/
	public function onLoadProgress(target_mc:MovieClip, loadedBytes:Number, totalBytes:Number):Void 
	{
		this.$e = new Event('onLoadProgress');
		this.$e.addArgument('name', this.$name);
		this.$e.addArgument('target_mc', target_mc._parent);
		this.$e.addArgument('loadedBytes', loadedBytes);
		this.$e.addArgument('totalBytes', totalBytes);
		this.dispatchEvent(this.$e);
	}
	/*
	* Invoked when a call to MovieClipLoader.loadClip() has begun to download a file.
	*/
	public function onLoadStart(target_mc:MovieClip):Void
	{
		this.$e = new Event('onLoadStart');
		this.$e.addArgument('name', this.$name);
		this.$e.addArgument('target_mc', target_mc._parent);
		this.dispatchEvent(this.$e);
	}
}