import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.util.MovieClipUtil;
import org.caleb.event.Event;

class org.caleb.loader.ExternalSWFManager extends ObservableMovieClip
{
	public static var SymbolName:String = '__Packages.org.caleb.controller.ExternalSWFManager';
	public static var SymbolLinked = Object.registerClass(SymbolName, ExternalSWFManager);
	
	private static var instance:ExternalSWFManager
	
	private var $view:MovieClip;
	private var $currentURL:String;
	
	public function ExternalSWFManager()
	{
	}
	public function get currentURL():String
	{
		return this.$currentURL;
	}
	public function get view():MovieClip
	{
		return this.$view;
	}
	public function loadScene(sceneURL:String):Void
	{
		trace('loading scene: ' + sceneURL);
		this.$currentURL = sceneURL;
		if(this.$view == undefined)
		{
			// view is undefined, so create one
			this.resetView();
			// initial call, no need to fade out. 
			// intro
			this.initIntro();
		}
		else
		{
			 this.initOutro();
		} 
		
	}
	private function initIntro():Void
	{
		MovieClipUtil.loadContent(this.$view, this.$currentURL, 0, 0, this, this.onIntroComplete);
		
		var e:Event = new Event('onIntroInit');
		this.dispatchEvent(e);
	}
	private function initOutro():Void
	{
		MovieClipUtil.fadeOut(this.$view, 1, this, 'onOutroComplete')
		
		var e:Event = new Event('onOutroInit');
		this.dispatchEvent(e);
	}
	private function resetView():Void
	{
		this.$view = this.createEmptyMovieClip('$view', 1);
	}
	private function onIntroComplete(context:MovieClip):Void
	{
		var e:Event = new Event('onIntroComplete');
		e.addArgument('context', context);
		this.dispatchEvent(e);
	}
	private function onOutroComplete(context:MovieClip):Void
	{
		this.resetView();
		this.initIntro();
		
		var e:Event = new Event('onOutroComplete');
		e.addArgument('context', context);
		this.dispatchEvent(e);
	}
}