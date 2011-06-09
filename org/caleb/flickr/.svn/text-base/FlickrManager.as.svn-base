import org.caleb.event.Event;
import org.caleb.event.ObservableObject;
import com.kelvinluck.flashr.core.*;
import mx.utils.Delegate;

/**
 *
 * @author
 * @version
 **/
class org.caleb.flickr.FlickrManager extends ObservableObject
{
	private var $flashr:Flashr;
	private var $flashrResponse:FlashrResponse;
	private static var currentAuthToken:String;
	private static var candidateAuthToken:String;
	public static var AUTH_READ:String = "read";
	var loginInterval:Number;
	
	public function FlickrManager(responder, apiKey:String, secret:String, authToken:String)
	{
		this.$flashr = Flashr.getFlashr();
		this.$flashrResponse = new FlashrResponse();
		this.$flashr.apiKey = apiKey;
		if(secret != undefined)
		{
			this.$flashr.authSetSecret(secret);
			//$flashr.authLogin("read");
			//loginInterval = setInterval(Delegate.create(this, authGotoStage2), 1000);
		}
		
		this.$flashr.cacheQueries = true;
		this.$flashr.saveHistory = true;
		
		this.$flashrResponse.onPhotosSearch = Delegate.create(this, onPhotosSearch);
		this.$flashrResponse.onPhotosetsGetPhotos = Delegate.create(this, onPhotosetsGetPhotos);
		this.$flashrResponse.onAuthCheckToken = Delegate.create(this, onAuthCheckToken);
		this.$flashrResponse.onAuthGetFrob = Delegate.create(this, onAuthGetFrob);
		this.observeAllEvents(responder);
		
		if(authToken != undefined && authToken != currentAuthToken && authToken != FlickrManager.candidateAuthToken)
		{
			trace('authenticating w/ token: ' + authToken);
			FlickrManager.candidateAuthToken = authToken;
			this.$flashr.authCheckToken(FlickrManager.candidateAuthToken);
		}
	}
	public function login(level:String)
	{
		trace('********** logging in w/ ' + level + ' permissions, api key: ' + this.$flashr.apiKey);
		$flashr.authLogin(level);
		loginInterval = setInterval(Delegate.create(this, authGotoStage2), 1000);
	}
	function onAuthCheckToken()
	{
		trace('************ auth token');
		FlickrManager.currentAuthToken = FlickrManager.candidateAuthToken;
		this.dispatchEvent(new Event('onFlickrAuthCheckToken'));
		FlickrManager.candidateAuthToken = undefined;
	}
	public function getPhotoSet(arg:String):Void
	{
		if(arg != undefined)
		{
			$flashr.photosetsGetPhotos(arg);
		}	
	}
	function authGotoStage2()
	{
		if (Flashr.getFlashr()["_authFrob"]) 
		{
			trace('*************** Flashr.getFlashr()["_authFrob"]: ' + Flashr.getFlashr()["_authFrob"])
			clearInterval(loginInterval);
			Flashr.getFlashr().authGetToken();
			FlickrManager.candidateAuthToken = Flashr.getFlashr()["_authFrob"];
			Flashr.getFlashr().authCheckToken(FlickrManager.candidateAuthToken);
		}
	}
	public function observeAllEvents(obj:Object)
	{
		this.addEventObserver(obj, 'onFlickrPhotosSearch');
		this.addEventObserver(obj, 'onFlickrAuthCheckToken');
		this.addEventObserver(obj, 'onFlickrPhotosetsGetPhotos');
		this.addEventObserver(obj, 'onFlickrAuthGetFrob');
		this.addEventObserver(obj, 'onFlickrError');
		this.addEventObserver(obj, 'onFlickrAPIResponse');	
	}
	public function photosSearch(arg:Object):FlashrRequest
	{
		return this.$flashr.photosSearch(arg);
	}
	/**
	* Function: onPhotosetsGetPhotos
	* 
	* Called when there is a response from a call to flickr.photosets.getPhotos
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photoset				-	The <Photoset> whose <Photo>s you have just retrieved.
	* 
	* See Also:
	* <Flashr.photosetsGetPhotos>
	* 
	* <Photoset.getPhotos>
	* 
	* <http://www.flickr.com/services/api/flickr.photosets.getPhotos.html>
	**/
	function onPhotosetsGetPhotos(photoset:Photoset)
	{
		var e:Event = new Event('onFlickrPhotosetsGetPhotos');
		e.addArgument('photoset', photoset);
		e.addArgument('photos', photoset.getPhotos());
		this.dispatchEvent(e);
	}
	/**
	* Function: onPhotosSearch
	* 
	* Called when there is a response from a call to flickr.people.search.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photos		- 	An Array of <Photo>'s.
	* 
	* See Also:
	* <Flickr.photosSearch>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.search.html>
	**/
	private function onPhotosSearch(rs:ResultsSet)
	{
		var e:Event = new Event('onFlickrPhotosSearch');
		e.addArgument('results', rs);
		e.addArgument('photos', rs.photos);
		this.dispatchEvent(e);
	}
	/**
	* Function: onAuthGetFrob
	* 
	* Called when there is a successful  response from a call to flickr.auth.getFrob
	* 
	* Note that you only need to use this and <Flashr.authGetFrob> if you have opted
	* not to use <Flashr.authLogin> for some reason.
	* 
	* Parameters:
	* frob				-	a frob to be used during authentication.
	* 
	* See Also:
	* <Flashr.authLogin>
	* 
	* <Flashr.authGetFrob>
	* 
	* <http://flickr.com/services/api/flickr.auth.getFrob.html>
	**/
	public function onAuthGetFrob(frob)
	{
		trace("******************* frob = " + frob);
		var e:Event = new Event('onFlickrAuthGetFrob');
		e.addArgument('frob', frob);
		this.dispatchEvent(e);
	}	/**
	* Function: onError
	* 
	* Called when the Flickr API returns an error code..
	* 
	* Override this method in your application so that it deals with the error.
	* 
	* Parameters:
	* errorCode - The code of this error.
	* errorDescription - A description of this error.
	* method - The Flickr API method that was called when this error occured.
	*/
	private function onError(errorCode:Number, errorDescription:String, method:String)
	{
		var e:Event = new Event('onFlickrError');
		e.addArgument('errorCode', errorCode);
		e.addArgument('errorDescription', errorDescription);
		e.addArgument('method', method);
		this.dispatchEvent(e);
		// todo - this.dispatchEvent
	}
	
	/**
	* Function: onAPIResponse
	* 
	* Internal function which deals with a response from a Flickr API call and 
	* forwards any relevant arguments to the relevant function.
	* 
	* You shouldn't need to override this function.
	* 
	* Parameters:
	* eventObject - An object containing all the relevant information about the API call
	**/
	private function onAPIResponse(responseEvent:FlashrResponseEvent)
	{
		var e:Event = new Event('onFlickrError');
		e.addArgument('responseEvent', responseEvent);
		this.dispatchEvent(e);
	}
}