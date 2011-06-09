import flash.net.FileReference;

/**
 *
 * @author
 * @version
 **/
class org.caleb.util.FileUtil
{
	public static var UPLOAD_IMAGES:Object = [{description: "Image Files", extension: "*.jpg;*.gif;*.png"}];
	public static var UPLOAD_PHP_URL:String = 'http://mig.media.yahoo.com/~calebh/upload/upload.php'
	private static var TYPE_UPLOAD:String = 'upload';
	private static var TYPE_DOWNLOAD:String = 'download';
	
	private function FileUtil()
	{
	}
	
	public static function upload(target:Object):FileReference
	{
		//Allow this domain
		System.security.allowDomain("http://mig.media.yahoo.com/");
		return setupFileReference(target, TYPE_UPLOAD, arguments[1]);
	}
	public static function download(target:Object):FileReference
	{
		//Allow this domain
		System.security.allowDomain("http://mig.media.yahoo.com/");
		return setupFileReference(target, TYPE_DOWNLOAD);
	}
	private static function setupFileReference(target:Object, type:String):FileReference
	{
		trace('setupFileReference invoked');
		for(var i in arguments) trace('key: ' + i + ', value: ' + arguments[i]);
		// The listener object listens for FileReference events.
		var listener:Object = new Object;
		listener.savePath = arguments[2];
		listener.dispatcher = new org.caleb.event.ObservableObject;
		// When the user selects a file, the onSelect() method is called, and
		// passed a reference to the FileReference object.
		listener.onSelect = function(file:FileReference):Void 
		{
			file.upload(FileUtil.UPLOAD_PHP_URL);
			var e:org.caleb.event.Event = new org.caleb.event.Event('onUploadSelect');
			e.addArgument('file', file);
			this.dispatcher.dispatchEvent(e);
		}
		// the file is starting to upload.
		listener.onOpen = function(file:FileReference):Void 
		{
			var e:org.caleb.event.Event = new org.caleb.event.Event('onUploadInit');
			e.addArgument('file', file);
			this.dispatcher.dispatchEvent(e);
		}
		//Possible file upload errors
		listener.onHTTPError = function(file:FileReference, httpError:Number):Void 
		{
			var e:org.caleb.event.Event = new org.caleb.event.Event('onUploadError');
			e.addArgument('type', 'HTTP');
			e.addArgument('message', httpError);
			e.addArgument('file', file);
			this.dispatcher.dispatchEvent(e);
		}
		listener.onIOError = function(file:FileReference):Void 
		{
			var e:org.caleb.event.Event = new org.caleb.event.Event('onUploadError');
			e.addArgument('type', 'IO');
			e.addArgument('file', file);
			this.dispatcher.dispatchEvent(e);
		}
		listener.onSecurityError = function(file:FileReference, errorString:String):Void 
		{
			var e:org.caleb.event.Event = new org.caleb.event.Event('onUploadError');
			e.addArgument('type', 'Security');
			e.addArgument('message', errorString);
			e.addArgument('file', file);
			this.dispatcher.dispatchEvent(e);
		}
		// the file has uploaded
		listener.onComplete = function(file:FileReference):Void 
		{
			var e:org.caleb.event.Event = new org.caleb.event.Event('onUploadComplete');
			e.addArgument('file', file);
			this.dispatcher.dispatchEvent(e);
		}
		listener.onCancel = function(file:FileReference):Void {
			var e:org.caleb.event.Event = new org.caleb.event.Event('onUploadCancel');
			e.addArgument('file', file);
			this.dispatcher.dispatchEvent(e);
		}

		listener.onProgress = function(file:FileReference, bytesLoaded:Number, bytesTotal:Number):Void {
			var e:org.caleb.event.Event = new org.caleb.event.Event('onUploadProgress');
			e.addArgument('file', file);
			e.addArgument('bytesLoaded', bytesLoaded);
			e.addArgument('bytesTotal', bytesTotal);
			this.dispatcher.dispatchEvent(e);
		}

		switch(type)
		{
			case TYPE_UPLOAD:
			{
				listener.dispatcher.addEventObserver(target, 'onUploadSelect');
				listener.dispatcher.addEventObserver(target, 'onUploadInit');
				listener.dispatcher.addEventObserver(target, 'onUploadError');
				listener.dispatcher.addEventObserver(target, 'onUploadComplete');
				listener.dispatcher.addEventObserver(target, 'onUploadCancel');
				listener.dispatcher.addEventObserver(target, 'onUploadProgress');
			}
			break;
			case TYPE_DOWNLOAD:
			{
				listener.dispatcher.addEventObserver(target, 'onDownloadSelect');
				listener.dispatcher.addEventObserver(target, 'onDownloadInit');
				listener.dispatcher.addEventObserver(target, 'onDownloadError');
				listener.dispatcher.addEventObserver(target, 'onDownloadComplete');
				listener.dispatcher.addEventObserver(target, 'onDownloadCancel');
				listener.dispatcher.addEventObserver(target, 'onDownloadProgress');
			}
			break;
		}
		var file:FileReference = new FileReference;
		file.addListener(listener);
		file.browse();
		
		return file;
	}
}