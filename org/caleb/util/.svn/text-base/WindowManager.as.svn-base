import org.caleb.util.DrawingUtil;

class org.caleb.util.WindowManager
{
	private static var depth:Number = 0;
	private static var bg:MovieClip;
	private static var windowContainer:MovieClip;
	private static var LINKAGE_ID_CONTAINER:String = 'windowContainer';
	
	public function WindowManager()
	{}
	 
	public static function show(scope:MovieClip, linkageId:String, classType:Function):MovieClip
	{
		trace('showing - scope: ' + scope + ', linkageId: ' + linkageId);
		// draw bg
		bg = DrawingUtil.drawRectangle(scope, scope._width, scope._height, 0, 0, .25, 0x000, 0x000, scope.getNextHighestDepth());
		bg._alpha = 10;
		bg.onRelease = function() { trace('locked by WindowManager'); };
		// create container
		windowContainer = scope.createEmptyMovieClip(LINKAGE_ID_CONTAINER, scope.getNextHighestDepth());
		
		var window:MovieClip = windowContainer.createEmptyMovieClip('window', depth++);
		// attach content
		var content = classType(windowContainer.attachMovie(linkageId, linkageId, depth++));
		// position window
		org.caleb.util.MovieClipUtil.centerInsideStage(window);
		// position content
		org.caleb.util.MovieClipUtil.centerInsideStage(windowContainer);
		
		// todo: enable closing
		
		// todo: make handle draggable?
				
		// intro window
		var yDestination:Number = (useWindow) ? 0 : windowContainer._y;
		windowContainer._y = Stage.height;
		var animationManager:org.caleb.animation.AnimationManager = new org.caleb.animation.AnimationManager(windowContainer);
		animationManager.tween('_y', yDestination, 3,'easeoutelastic',.25);
		
		return windowContainer;
	}
	public static function close():Void
	{
		var animationManager:org.caleb.animation.AnimationManager = new org.caleb.animation.AnimationManager(windowContainer);
		animationManager.tween(['_y', '_alpha'], [Stage.height, 0], .5,'easeinquad');
	}
}