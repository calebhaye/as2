import mx.events.EventDispatcher;
import mx.utils.Delegate;
import org.caleb.flickr.Person;
import org.caleb.flickr.Photo;
import org.caleb.flickr.PhotoSize;
import org.caleb.flickr.Group;
import org.caleb.flickr.ExifData;
import org.caleb.flickr.Note;
import org.caleb.flickr.Tag;
import org.caleb.util.DateUtil;
import org.caleb.util.StringUtil;
//import com.meychi.ascrypt.MD5;

/**
* Class: org.caleb.flickr.Flickr
* 
* 
* Class to provide an interface to the Flickr API
* 
* 
* This class in combination with <FlickrResponseListener>
* provides a convienient way to interact with the Flickr API from
* AS 2. The implementation should abstract away any processing of XML
* and allow for type checking in the functions you override in 
* FlickrResponseListener. The idea is to make flash code which interacts
* with the Flickr API quicker and easier to write.
* 
* 
* This code is still beta so feedback is greatfully received :)
* 
* 
* This code is licensed under a Creative Commons License.
* <http://creativecommons.org/licenses/by-nc-sa/2.0/>
* 
* Usage:
* Very simple usage example -- in the real world you would either
* subclass FlickrResponseListener to add functionality you required
* or override the method you were interested in.
* 
* 
* (code)
* import org.caleb.flickr.Flickr;
* import org.caleb.flickr.FlickrResponseListener;
* 
* var _flickr:Flickr = Flickr.getFlickr();
* _flickrResponseListener = new FlickrResponseListener();
* _flickr.apiKey = "***";
* _flickr.testEcho("one", 2, "free");
* (end)
* 
* 
* This example shows how you would override the method you were 
* interested in:
* (code)
* import org.caleb.flickr.Flickr;
* import org.caleb.flickr.FlickrResponseListener;
* 
* var _flickr:Flickr = Flickr.getFlickr();
* _flickrResponseListener = new FlickrResponseListener();
* _flickrResponseListener.onTestEcho = function(params:Object) {
*		// do stuff
* }
* _flickr.apiKey = "***";
* _flickr.testEcho("one", 2, "free");
* (end)
* 
* See Also:
* <FlickrResponseListener>
* 
* <http://www.flickr.com/services/api/>
**/
class org.caleb.flickr.Flickr extends org.caleb.core.CoreObject
{
	/**
	* Function: Flickr
	* 
	* Constructor -
	* as this class implements the Singleton pattern do not call directly
	* but rather access through <Flickr.getFlickr>.
	**/
	private function Flickr()
	{
		this.setClassDescription('org.caleb.flickr.Flickr');
		//trace('constructor invoked');
		awaitingResponse = false;
		_REST_ENDPOINT = "http://api.flickr.com/services/rest/";
		EventDispatcher.initialize(this);
	}
	private static var _flickr:Flickr;
	/**
	* Variable: apiKey
	* 
	* Your Flickr API Key. None of the method calls will work without this.
	**/
	private var _apiKey:String;
	/**
	* Variable: _REST_ENDPOINT
	* 
	* The place for all API calls to connect to.
	* The default value of connecting directly to the flickr.com server will only
	* work if a relevant entry is added to their crossdomain.xml file
	* otherwise set the value to the location of a proxy script on your
	* server.
	**/
	private var _REST_ENDPOINT:String;
	
	/**
	* Variable: _AUTH_ENDPOINT
	* 
	* The base path you go to when you want to authenticate on flickr.com
	**/
	private var _AUTH_ENDPOINT:String = "http://flickr.com/services/auth/";
	
	// used internally to lock the object as only one request can be made at a time
	private var awaitingResponse:Boolean;
	public var _restXML:XML;
	private var _calledMethod:String;
	private var _additionalArgs:Object = {};
	
	private var _email:String;
	private var _password:String;
	
	/**
	* Variable: STATUS_BUSY
	* The API is already waiting for the response to a method call so cannot make another call
	**/
	public static var STATUS_BUSY:Number = 104;
	public static var STATUS_BUSY_DESCRIPTION:String = "the API is already waiting for the response to a method call so cannot make another call";
	/**
	* Variable: STATUS_ERROR_CONNECTING
	* Could not connect to the server (e.g. no internet connection, server down, security restrictions)
	**/
	public static var STATUS_ERROR_CONNECTING:Number = 102;
	public static var STATUS_ERROR_CONNECTING_DESCRIPTION:String = "could not connect to the server (e.g. no internet connection, server down, security restrictions)";
	/**
	* Variable: STATUS_INVALID_XML
	* The XML returned by the server wasn't in a &lt;rsp /&gt; tag.
	**/
	public static var STATUS_INVALID_XML:Number = 101;
	public static var STATUS_INVALID_XML_DESCRIPTION:String = "Unexpected XML Format returned by server";
	
	/**
	* Variable: STATUS_USER_NOT_LOGGED_IN
	* The user wasn't logged in and tried to access a method that requires authentication
	* (returned from flickr.com)
	**/
	public static var STATUS_USER_NOT_LOGGED_IN:Number = 99;
	/**
	* Variable: STATUS_INVALID_API_KEY
	* The API key sent to flickr was invalid
	* (returned from flickr.com)
	**/
	public static var STATUS_INVALID_API_KEY:Number = 100;
	
	/**
	* Variable: STATUS_OK
	* There was no errors and valid XML was returned.
	**/
	public static var STATUS_OK:Number = 1000;
	
	/**
	* Variable: PERM_NOBODY
	* 
	* A constant representing permissions for nobody.
	* 
	* See Also:
	* <photosSetPerms>
	**/
	public static var PERM_NOBODY:Number = 0;
	/**
	* Variable: PERM_FRIENDS
	* 
	* A constant representing permissions for friends and family.
	* 
	* See Also:
	* <photosSetPerms>
	**/
	public static var PERM_FRIENDS:Number = 1;
	/**
	* Variable: PERM_CONTACTS
	* 
	* A constant representing permissions for contacts.
	* 
	* See Also:
	* <photosSetPerms>
	**/
	public static var PERM_CONTACTS:Number = 2;
	/**
	* Variable: PERM_EVERYBODY
	* 
	* A constant representing permissions for everybody.
	* 
	* See Also:
	* <photosSetPerms>
	**/
	public static var PERM_EVERYBODY:Number = 3;
	
	/**
	* Variable: _secret
	* 
	* Private variable to store this app's shared secret for use with the
	* authentication API.
	* 
	* See Also:
	* <authLogin>
	* 
	* <http://www.flickr.com/services/api/auth.spec.html>
	* 
	* <http://www.flickr.com/services/api/registered_keys.gne>
	**/
	private var _secret:String;
	
	/**
	* Variable: _authToken
	* 
	* Private variable which stores the token generated by a successfull
	* authorisation.
	**/
	private var _authToken:String = "";
	
	/**
	* Variable: _authFrob
	* 
	* Private variable which is used to store the frob which is used for
	* the first part of the authentication process.
	**/
	private var _authFrob:String;
	
	private var _authIsLoggingIn:Boolean;
	
	/**
	* Variable: authPerms
	* 
	* A variable describing the permissions the currently auth'd user
	* has within this app. It will be "none" until the user has been
	* logged in and then will become "read", "write" or "delete". You can
	* check whether authPerms == "none" if you want to find out if the
	* user is currently logged in before checking who they are with <authUser>
	* 
	* See Also:
	* <authLogin>
	* 
	* <authUser>
	**/
	var authPerms:String = "none";
	
	/**
	* Variable: authUser
	* 
	* A <Person> object for the currently auth'd user (if there is one).
	* Empty if there is no currently auth'd user.
	* 
	* See Also:
	* <authLogin>
	* 
	* <authPerms>
	**/
	var authUser:Person;
	
// flickr.auth methods

/**
* Function: authSetSecret
* 
* Use to set the value of the shared secret before any calls to methods like
* <authLogin> or <authCheckToken>
* 
* Parameters:
* secret		- Your applications shared secret.
* 
* See Also:
* <authLogin>
* 
* <authCheckToken>
* 
* <http://www.flickr.com/services/api/auth.spec.html>
* 
* <http://www.flickr.com/services/api/auth.howto.desktop.html>
* 
* <http://www.flickr.com/services/api/registered_keys.gne>
**/
public function authSetSecret(secret:String)
{
	_secret = secret;
}

/**
* Function: authLogin
* 
* Pops open a login window so that the user can authenticate with the
* flickr.com website. The user authenticates using the "Non-web based 
* app" method as described in section 9.2 of the auth spec.
* 
* The end effect of calling this function is that a window is opened
* with the relevant login / authenticate stuff on flickr.com. It is the
* responsibility of the user of this library to pop up a dialog box saying
* words to the effect of:
* 
* "This program requires your authentication before it can read/write/delete
* your photos on flickr.com. Please complete the authorisation process in the
* window which has popped up and then press the CONTINUE button below"
* 
* The CONTINUE button needs to call authGetToken which does the final stage
* of logging the user in.
* 
* Parameters:
* perms			-	A desired level of permission for actions 
* 				 	which the application wants to perform on behalf 
* 				 	of the user. "read", "write" or "delete".
* 
* See Also:
* <authGetToken>
* 
* <http://www.flickr.com/services/api/auth.spec.html>
* 
* <http://www.flickr.com/services/api/auth.howto.desktop.html>
* 
* <http://www.flickr.com/services/api/registered_keys.gne>
**/
public function authLogin(perms:String)
{
	authPerms = perms;
	authGetFrob(true);
}

/**
* Function: authGetFrob
* 
* Calls flickr.auth.getFrob to get a frob to be used during authentication. In most cases
* you would not call this method directly and would instead use <authLogin>.
* 
* Parameters:
* authIsLoggingIn	-	Set to true internally so that authLogin doesn't need to bother
* 						a FlickrResponseListener. If you call the function then leave this
* 						empty or put in the default (false).
* 
* See Also:
* <authLogin>
* 
* <FlickrResponseListener.onAuthGetFrob>
* 
* <http://flickr.com/services/api/flickr.auth.getFrob.html>
**/
public function authGetFrob(authIsLoggingIn:Boolean)
{
	if (authIsLoggingIn) _authIsLoggingIn = true;
	callMethod("flickr.auth.getFrob", {}, true);
}

/**
* Function: authGetToken
* 
* Calls flickr.auth.getToken to get the auth token for the given frob, if one has 
* been attached.
* 
* Should be called after the user has pressed CONTINUE on the status window
* you opened when calling authLogin.
* 
* If a valid token is returned (e.g. if the frob was correct and valid) then the
* user is logged in for all further API calls from this session and
* <FlickrResponseListener.onAuthCheckToken> will be fired. If there is a problem
* then <FlickrResponseListener.onError> is fired.
* 
* See Also:
* <authLogin>
* 
* <FlickrResponseListener.onAuthCheckToken>
* 
* <http://www.flickr.com/services/api/flickr.auth.getToken.html>
* 
**/
public function authGetToken()
{
	callMethod("flickr.auth.getToken", {frob:_authFrob}, true);
}

/**
* Function: authCheckToken
* 
* Calls flickr.auth.checkToken to get the credentials attached to an 
* authentication token. You can use this to log in if you have auth'd
* an app in a previous session and saved the token e.g. in a SharedObject.
* If the token is still valid, the user will become logged in and 
* <FlickrResponseListener.onAuthCheckToken> will be fired. If the token is
* invalid then <FlickrResponseListener.onError> will be fired.
* 
* Parameters:
* authToken			- The authentication token to check.
* 
* See Also:
* <FlickrResponseListener.onAuthCheckToken>
* 
* <http://www.flickr.com/services/api/flickr.auth.checkToken.html>
**/
public function authCheckToken(authToken:String)
{
	callMethod("flickr.auth.checkToken", {auth_token:authToken}, true);
}

/**
* Function: authLogout
* 
* Simple function which forgets the information that was making this user be
* logged in. The app will remain authenticated against flickr.com until the
* user visits <http://www.flickr.com/services/auth/list.gne> but the app will
* have to reapply for frob and then a token to use this authentication...
**/
public function authLogout()
{
	_authToken = "";
	authPerms = "none";
	delete _authFrob;
	delete authUser;
	//getURL("http://www.flickr.com/services/auth/list.gne", "_blank");
}

/**
* Function: _authOpenLogin
* 
* Internal function which generates the relevant link and pops open the
* login window on flickr.com. Triggered when a frob (necessary to generate
* the link) is returned from flickr.auth.getFrob.
* 
* See Also:* <http://www.flickr.com/services/api/flickr.auth.getFrob.html>
* 
* <http://www.flickr.com/services/api/auth.spec.html>
* 
* <http://www.flickr.com/services/api/auth.howto.desktop.html>
* 
* <http://www.flickr.com/services/api/registered_keys.gne>
**/
private function _authOpenLogin()
{
	var args:Object = {api_key:_apiKey, perms:authPerms, frob:_authFrob};
	var loginUrl:String = _AUTH_ENDPOINT+"?";	
	for (var argumentName:String in args) {
		loginUrl += argumentName+"="+args[argumentName] + "&";
	}
	loginUrl += "api_sig="+_authSignCall(args);
	getURL(loginUrl, "_blank");
	/**
	* TODO - need to somehow display the "click once you have authorised" message here...
	* or is that just up to the application developer?
	* Maybe better to leave it up to the application developer as detailed in the
	* NaturalDocs to authLogin...
	**/
}


/**
* Function: _authSignCall
* 
* Internal, private function which is used to generate the api_sig used to
* sign a call.
* 
* Parameters:
* urlArguments	- An Object containing name/value pairs which describe all of the
* 				  arguments on the URL.
* 
* See Also:
* <http://www.flickr.com/services/api/auth.spec.html>
* 
* <http://www.flickr.com/services/api/auth.howto.desktop.html>
* 
* <http://www.flickr.com/services/api/registered_keys.gne>
**/
private function _authSignCall(urlArguments:Object):String
{
	var toSort:Array = [];
	for (var argument:String in urlArguments) {
		toSort.push({name:argument, value:urlArguments[argument]});
	}
	toSort.sortOn("name");
	var signature:String = _secret;
	for (var i:Number=0; i<toSort.length; i++) {
		signature += toSort[i].name + toSort[i].value;
	}
	//return MD5.calculate(signature);
	return StringUtil.md5(signature);
}

// /flickr.auth methods

// flickr.contacts methods

/**
* Function: contactsGetList
* 
* Calls flickr.contacts.getList to get a list of contacts for the calling user.
* 
* See Also:
* <FlickrResponseListener.onContactsGetList>
* 
* <http://flickr.com/services/api/flickr.contacts.getList.html>
**/
public function contactsGetList()
{
	var params:Object = {};
	callMethod("flickr.contacts.getList", params);
}
/**
* Function: contactsGetPublicList
* 
* Calls flickr.contacts.getPublicList to get a list of contacts a user.
* 
* Parameters:
* nsid 			- 	The nsid of the user whose contacts you want to get.
* 
* See Also:
* <FlickrResponseListener.onContactsGetPublicList>
* 
* <http://flickr.com/services/api/flickr.contacts.getPublicList.html>
**/
public function contactsGetPublicList(nsid:String)
{
	if (!awaitingResponse) {
		_additionalArgs.nsid = nsid; 
	}
	callMethod("flickr.contacts.getPublicList", {user_id:nsid});
}

// /flickr.contacts methods	

// flickr.favorites methods

/**
* Function: favoritesAdd
* 
* Calls flickr.favorites.add to add a photo to a user's favorites list.
* 
* Parameters:
* photoId 		- 	The id of the photo you want to add.
* 
* See Also:
* <FlickrResponseListener.onFavoritesAdd>
* 
* <http://www.flickr.com/services/api/flickr.favorites.add.html>
**/
public function favoritesAdd(photoId:Number)
{
	var params:Object = {photo_id:photoId};
	_additionalArgs.photoId = photoId;
	callMethod("flickr.favorites.add", params);
}
/**
* Function: favoritesGetList
* 
* Calls flickr.favorites.getList to get a list of the user's favorite photos.
* 
* Parameters:
* userId 		- 	The id of the user to get favourites for [Optional: default=logged in user]
* extras		-	A comma-delimited list of extra information to fetch for each returned record.
* 					Currently supported fields are:
* 					license, date_upload, date_taken, owner_name, icon_server.
* perPage 		- 	The number of results to get per page [Optional: default=100]
* page 			- 	The page of results to get [Optional: default=1]
* 
* See Also:
* <FlickrResponseListener.onFavoritesGetList>
* 
* <http://www.flickr.com/services/api/flickr.favorites.getList.html>
**/
public function favoritesGetList(userId:String, extras:String, perPage:Number, page:Number)
{
	var params:Object = {};
	if (userId) params.user_id = userId;
	if (extras) params.extras = extras;
	if (perPage) params.per_page = perPage;
	if (page) params.page = page;
	// if no user id is passed we are trying to get the faves for the logged in user..
	_additionalArgs.userId = userId ? userId : authUser.nsid;
	callMethod("flickr.favorites.getList", params);
}
/**
* Function: favoritesGetPublicList
* 
* Calls flickr.favorites.getPublicList to get a list of favorite public photos for the given user.
* 
* Parameters:
* userId 		- 	The id of the user to get favourites for
* extras		-	A comma-delimited list of extra information to fetch for each returned record.
* 					Currently supported fields are:
* 					license, date_upload, date_taken, owner_name, icon_server.
* perPage 		- 	The number of results to get per page [Optional: default=100]
* page 			- 	The page of results to get [Optional: default=1]
* 
* See Also:
* <FlickrResponseListener.onFavoritesGetPublicList>
* 
* <http://www.flickr.com/services/api/flickr.favorites.getPublicList.html>
**/
public function favoritesGetPublicList(userId:String, extras:String, perPage:Number, page:Number)
{
	var params:Object = {user_id:userId};
	if (extras) params.extras = extras;
	if (perPage) params.per_page = perPage;
	if (page) params.page = page;
	_additionalArgs.userId = userId;
	callMethod("flickr.favorites.getPublicList", params);
}
/**
* Function: favoritesRemove
* 
* Calls flickr.favorites.remove to remove a photo from a user's favorites list.
* 
* Parameters:
* photoId 		- 	The id of the photo you want to add.
* 
* See Also:
* <FlickrResponseListener.onFavoritesRemove>
* 
* <http://www.flickr.com/services/api/flickr.favorites.remove.html>
**/
public function favoritesRemove(photoId:Number)
{
	var params:Object = {photo_id:photoId};
	_additionalArgs.photoId = photoId;
	callMethod("flickr.favorites.remove", params);
}


// /flickr.favorites methods

// flickr.people methods

/**
* Function: peopleFindByEmail
* 
* Calls flickr.people.findByEmail to get a user's NSID, given their email address.
* 
* Parameters:
* email 		- 	The email address of the person whose nsid you want
* 
* See Also:
* <FlickrResponseListener.onPeopleFindByEmail>
* 
* <http://flickr.com/services/api/flickr.people.findByEmail.html>
**/
function peopleFindByEmail(email:String)
{
	if (!awaitingResponse) {
		_additionalArgs.email = email; 
	}
	callMethod("flickr.people.findByEmail", {find_email:email});
}
/**
* Function: peopleFindByUsername
* 
* Calls flickr.people.findByUsername to get a user's NSID, given their username.
* 
* Parameters:
* username 		- 	The username of the person whose nsid you want
* 
* See Also:
* <FlickrResponseListener.onPeopleFindByUsername>
* 
* <http://flickr.com/services/api/flickr.people.findByUsername.html>
**/
function peopleFindByUsername(username:String)
{
	if (!awaitingResponse) {
		_additionalArgs.username = username; 
	}
	callMethod("flickr.people.findByUsername", {username:username});
}
/**
* Function: peopleGetInfo
* 
* Calls flickr.people.getInfo to get information about a user.
* 
* Parameters:
* nsid 			- 	The nsid of the user you want information about.
* 
* See Also:
* <FlickrResponseListener.onPeopleGetInfo>
* 
* <http://flickr.com/services/api/flickr.people.getInfo.html>
**/
function peopleGetInfo(nsid:String)
{
	callMethod("flickr.people.getInfo", {user_id:nsid});
}
/**
* Function: peopleGetPublicGroups
* 
* Calls flickr.people.getPublicGroups to get the list of public groups a user is a member of.
* 
* Parameters:
* nsid 			- 	The nsid of the user whose groups you want to know about.
* 
* See Also:
* <FlickrResponseListener.onPeopleGetPublicGroups>
* 
* <http://www.flickr.com/services/api/flickr.people.getPublicGroups.html>
**/
function peopleGetPublicGroups(nsid:String)
{
	if (!awaitingResponse) {
		_additionalArgs.nsid = nsid; 
	}
	callMethod("flickr.people.getPublicGroups", {user_id:nsid});
}
/**
* Function: peopleGetPublicPhotos
* 
* Calls flickr.people.getPublicPhotos to get a list of public photos for the given user.
* 
* Parameters:
* nsid 			- 	The nsid of the user whose photos you want to know about.
* extras		-	A comma-delimited list of extra information to fetch for each returned record.
* 					Currently supported fields are:
* 					license, date_upload, date_taken, owner_name, icon_server
* perPage 		- 	The number of photos to return per page. [Optional: default=100]
* page 			- 	The page of results to return. [Optional: default=1]
* 
* See Also:
* <FlickrResponseListener.onPeopleGetPublicPhotos>
* 
* <http://flickr.com/services/api/flickr.people.getPublicPhotos.html>
**/
function peopleGetPublicPhotos(nsid:String, extras:String, perPage:Number, page:Number)
{
	if (!awaitingResponse) {
		_additionalArgs.nsid = nsid; 
	}
	var params:Object = {user_id:nsid};
	if (extras) params.extras = extras;
	if (perPage) params.per_page = perPage;
	if (page) params.page = page;
	callMethod("flickr.people.getPublicPhotos", params);
}
/**
* Function: peopleGetUploadStatus
* 
* Calls flickr.people.getUploadStatus to get information for the calling user related to photo uploads.
* 
* See Also:
* <FlickrResponseListener.onPeopleGetUploadStatus>
* 
* <http://flickr.com/services/api/flickr.people.getUploadStatus.html>
**/
function peopleGetUploadStatus()
{
	callMethod("flickr.people.getUploadStatus");
}

// /flickr.people methods

// flickr.photos methods

/**
* Function: photosAddTags
* 
* Calls flickr.photos.addTags to add tags to a given photo.
* 
* Parameters:
* photoId		-	The id of the photo to add tags to.
* tags			- 	The tags to add to the photo.
* 
* See Also:
* <FlickrResponseListener.onPhotosAddTags>
* 
* <http://flickr.com/services/api/flickr.photos.addTags.html>
**/
function photosAddTags (photoId:Number, tags:String)
{
	var params:Object = {photo_id:photoId, tags:tags};
	if (!awaitingResponse) {
		_additionalArgs.tags = tags;
		_additionalArgs.photoId = photoId;
	}
	callMethod("flickr.photos.addTags", params);
}
/**
* Function: photosGetContactsPhotos
* 
* Calls flickr.photos.getContactsPhotos to fetch a list of recent photos 
* from the calling users' contacts.
* 
* Parameters:
* count			- 	Number of photos to return. Defaults to 10, maximum 50. 
* 				  	This is only used if single_photo is not passed.
* justFriends	- 	set as 1 to only show photos from friends and family (excluding 
* 				  	regular contacts). [Optional: default=0].
* singlePhoto	- 	Only fetch one photo (the latest) per contact, instead of 
* 				  	all photos in chronological order [Optional: default=0].
* includeSelf	- 	Set to 1 to include photos from the calling user. 
* 				  	[Optional: default=0].
* 
* See Also:
* <FlickrResponseListener.onPhotosGetContactsPhotos>
* 
* <http://flickr.com/services/api/flickr.photos.getContactsPhotos.html>
**/
function photosGetContactsPhotos (count:Number, justFriends:Number, singlePhoto:Number, includeSelf:Number)
{
	var params:Object = {};
	if (count != undefined) params.count = count;
	params.just_friends = justFriends ? 1 : 0;
	params.single_photo = singlePhoto ? 1 : 0;
	params.include_self = includeSelf ? 1 : 0;
	callMethod("flickr.photos.getContactsPhotos", params);
}
/**
* Function: photosGetContactsPublicPhotos
* 
* Calls flickr.photos.getContactsPublicPhotos to fetch a list of recent public 
* photos from a users' contacts.
* 
* Parameters:
* nsid			- 	The NSID of the user to fetch photos for.
* count			- 	Number of photos to return. Defaults to 10, maximum 50. 
* 				  	This is only used if single_photo is not passed. [Optional: default=10].
* justFriends	- 	set as 1 to only show photos from friends and family (excluding 
* 				  	regular contacts). [Optional: default=0].
* singlePhoto	- 	Only fetch one photo (the latest) per contact, instead of 
* 				  	all photos in chronological order [Optional: default=0].
* includeSelf	- 	Set to 1 to include photos from the calling user. 
* 				  	[Optional: default=0].
* 
* See Also:
* <FlickrResponseListener.onPhotosGetContactsPublicPhotos>
* 
* <http://www.flickr.com/services/api/flickr.photos.getContactsPublicPhotos.html>
**/
function photosGetContactsPublicPhotos (nsid:String, count:Number, justFriends:Boolean, singlePhoto:Boolean, includeSelf:Boolean)
{
	if (!awaitingResponse) {
		_additionalArgs.nsid = nsid; 
	}
	var params:Object = {user_id:nsid};
	if (count != undefined) params.count = count;
	params.just_friends = justFriends ? 1 : 0;
	params.single_photo = singlePhoto ? 1 : 0;
	params.include_self = includeSelf ? 1 : 0;
	callMethod("flickr.photos.getContactsPublicPhotos", params);
}
/**
* Function: photosGetContext
* 
* Calls flickr.photos.getContext to return next and previous photos for a 
* photo in a photostream.
* 
* Parameters:
* photoId		- 	The id of the photo to fetch the context for.
* 
* See Also:
* <FlickrResponseListener.onPhotosGetContext>
* 
* <http://www.flickr.com/services/api/flickr.photos.getContext.html>
**/
function photosGetContext (photoId:Number)
{
	if (!awaitingResponse) {
		_additionalArgs.photoId = photoId; 
	}
	callMethod("flickr.photos.getContext", {photo_id:photoId});
}
/**
* Function: photosGetCounts
* 
* Calls flickr.photos.getCounts to get a list of photo counts for the 
* given date ranges for the calling user.
* 
* Parameters:
* dates			-	A comma delimited list of unix timestamps
* 					denoting the periods to return counts for. 
* 					They should be specified smallest first.
* 					[Optional: if not present then takenDates used instead.
* takenDates	-	A comma delimited list of mysql datetimes
* 					denoting the periods to return counts for. 
* 					They should be specified smallest first.
* 					[Optional: if not present then dates used instead.
* 
* Note:
* * The dates parameter is passed as UNIX Timestamps while the takenDates parameter
* is passed as MySQL Timestamps (e.g. 2005-03-21).
* * If you want to pass takenDates then pass "" (empty string) or undefined as the value
* of dates.
* 
* TODO:
* Should we change this method to accept Arrays of Date Objects rather than comma delimited
* Strings? Then we could sort it making order unimportant and could abstract away the fact
* that Flickr stores dates uploaded and dates taken in different formats.
* Maybe it would be better if the method's arguments were dates (an Array of Date 
* Objects) and type (Flickr.DATES_UPLOADED or Flickr.DATES_TAKEN)?
* 
* See Also:
* <FlickrResponseListener.onPhotosGetCounts>
* 
* <http://www.flickr.com/services/api/flickr.photos.getCounts.html>
**/
function photosGetCounts (dates:String, takenDates:String)
{
	var params:Object = {};
	if (dates != undefined && dates != "") {
		params.dates = dates;
		_additionalArgs.dateType = "uploaded";
	}
	if (takenDates != undefined) {
		params.taken_dates = takenDates;
		_additionalArgs.dateType = "taken";
	}
	callMethod("flickr.photos.getCounts", params);
}
/**
* Function: photosGetExif
* 
* Calls flickr.photos.getExif to return a list of EXIF/TIFF/GPS tags for a given photo.
* 
* Parameters:
* photoId		- 	The id of the photo to fetch the context for.
* secret		- 	The secret for the photo. If the correct secret is passed then permissions
* 					checking is skipped. This enables the 'sharing' of individual photos by 
* 					passing around the id and secret.
* 
* See Also:
* <FlickrResponseListener.onPhotosGetExif>
* 
* <ExifData>
* 
* <http://www.flickr.com/services/api/flickr.photos.getExif.html>
**/
function photosGetExif (photoId:Number, secret:String)
{
	var params:Object = {photo_id:photoId};
	if (secret) params.secret = secret;
	callMethod("flickr.photos.getExif", params);
}
/**
* Function: photosGetInfo
* 
* Calls flickr.photos.getInfo to get information about a photo..
* 
* Parameters:
* photoId		- 	The id of the photo to fetch the context for.
* secret		- 	The secret for the photo. If the correct secret is passed then permissions
* 					checking is skipped. This enables the 'sharing' of individual photos by 
* 					passing around the id and secret.
* 
* See Also:
* <FlickrResponseListener.onPhotosGetInfo>
* 
* <http://www.flickr.com/services/api/flickr.photos.getInfo.html>
**/
function photosGetInfo (photoId:Number, secret:Number)
{
	var params:Object = {photo_id:photoId};
	if (secret) params.secret = secret;
	callMethod("flickr.photos.getInfo", params);
}
/**
* Function: photosGetNotInSet
* 
* Calls flickr.photos.getNotInSet to get a list of your photos that are not part of any sets.
* 
* Parameters:
* extras		-	A comma-delimited list of extra information to fetch for each returned record.
* 					Currently supported fields are:
* 					license, date_upload, date_taken, owner_name, icon_server
* perPage 		- 	The number of photos to return per page. [Optional: default=100]
* page 			- 	The page of results to return. [Optional: default=1]
* 
* See Also:
* <FlickrResponseListener.onPhotosGetNotInSet>
* 
* <http://www.flickr.com/services/api/flickr.photos.getNotInSet.html>
**/
function photosGetNotInSet (extras:String, perPage:Number, page:Number)
{
	var params:Object = {};
	if (extras) params.extras = extras;
	if (perPage) params.per_page = perPage;
	if (page) params.page = page;
	callMethod("flickr.photos.getNotInSet", params);
}
/**
* Function: photosGetPerms
* 
* Calls flickr.photos.getPerms to get permissions for a photo.
* 
* Parameters:
* photoId 		- 	The id of the photo whose permissions you want
* 
* See Also:
* <FlickrResponseListener.onPhotosGetNotInSet>
* 
* <http://www.flickr.com/services/api/flickr.photos.getPerms.html>
**/
function photosGetPerms (photoId:Number)
{
	callMethod("flickr.photos.getPerms", {photo_id:photoId});
}
/**
* Function: photosGetRecent
* 
* Calls flickr.photos.getRecent to get a list of the latest public photos uploaded to flickr.
* 
* Parameters:
* extras		-	A comma-delimited list of extra information to fetch for each returned record.
* 					Currently supported fields are:
* 					license, date_upload, date_taken, owner_name, icon_server
* perPage 		- 	The number of photos to return per page. [Optional: default=100]
* page 			- 	The page of results to return. [Optional: default=1]
* 
* See Also:
* <FlickrResponseListener.onPhotosGetRecent>
* 
* <http://www.flickr.com/services/api/flickr.photos.getRecent.html>
**/
function photosGetRecent (extras:String, perPage:Number, page:Number)
{
	var params:Object = {};
	if (extras) params.extras = extras;
	if (perPage) params.per_page = perPage;
	if (page) params.page = page;
	callMethod("flickr.photos.getRecent", params);
}
/**
* Function: photosGetSizes
* 
* Calls flickr.photos.getRecent to get the available sizes for a photo.
* 
* Parameters:
* photoId	 		- 	The id of the photo to fetch size information for.
* 
* See Also:
* <FlickrResponseListener.onPhotosGetSizes>
* 
* <http://www.flickr.com/services/api/flickr.photos.getSizes.html>
**/
function photosGetSizes (photoId:Number)
{
	if (!awaitingResponse) {
		_additionalArgs.photoId = photoId; 
	}
	callMethod("flickr.photos.getSizes", {photo_id:photoId});
}
/**
* Function: photosGetUntagged
* 
* Calls flickr.photos.getUntagged to get a list of your photos with no tags.
* 
* Parameters:
* extras		-	A comma-delimited list of extra information to fetch for each returned record.
* 					Currently supported fields are:
* 					license, date_upload, date_taken, owner_name, icon_server
* perPage 		- 	The number of photos to return per page. [Optional: default=100]
* page 			- 	The page of results to return. [Optional: default=1]
* 
* See Also:
* <FlickrResponseListener.onPhotosGetUntagged>
* 
* <http://www.flickr.com/services/api/flickr.photos.getUntagged.html>
**/
function photosGetUntagged (extras:String, perPage:Number, page:Number)
{
	var params:Object = {};
	if (extras) params.extras = extras;
	if (perPage) params.per_page = perPage;
	if (page) params.page = page;
	callMethod("flickr.photos.getUntagged", params);
}
/**
* Function: photosRemoveTag
* 
* Calls flickr.photos.removeTag to remove a tag from a photo.
* 
* Parameters:
* tagId	 		- 	The tag to remove from the photo. 
* 					This parameter should contain a tag id, as returned by 
* 					<photosGetInfo>.
* 
* See Also:
* <FlickrResponseListener.onPhotosRemoveTag>
* 
* <http://www.flickr.com/services/api/flickr.photos.removeTag.html>
**/
function photosRemoveTag (tagId:Number)
{
	_additionalArgs.tagId = tagId;
	callMethod("flickr.photos.removeTag", {tag_id:tagId});
}
/**
* Function: photosSearch
* 
* Calls flickr.photos.search to get a list of photos matching some criteria.
* 
* You pass an object with one or many of the following attributes...
* 
* Attributes:
* user_id			-	The NSID of the user who's photo to search. If this parameter 
* 						isn't passed then everybody's public photos will be searched.
* tags				-	A comma-delimited list of tags. Photos with one or more of the 
* 						tags listed will be returned.
* tag_mode			-	Either 'any' for an OR combination of tags, or 'all' for an AND 
* 						combination. Defaults to 'any' if not specified.
* text				-	A free text search. Photos who's title, description or tags 
* 						contain the text will be returned.
* min_upload_date	-	Minimum upload date. Photos with an upload date greater than or 
* 						equal to this value will be returned. The date should be in the 
* 						form of a UNIX timestamp.
* max_upload_date	-	Maximum upload date. Photos with an upload date less than or 
* 						equal to this value will be returned. The date should be in the form 
* 						of a UNIX timestamp.
* min_taken_date	-	Minimum taken date. Photos with an taken date greater than or equal 
* 						to this value will be returned. The date should be in the form of a 
* 						MySQL datetime.
* max_taken_date	-	Maximum taken date. Photos with an taken date less than or equal to 
* 						this value will be returned. The date should be in the form of a MySQL 
* 						datetime.
* license			-	The license id for photos.
* extras			-	A comma-delimited list of extra information to fetch for each 
* 						returned record. Currently supported fields are:
* 						license, date_upload, date_taken, owner_name, icon_server
* per_page			-	Number of photos to return per page. If this argument is ommited, it 
* 						defaults to 100. The maximum allowed value is 500.
* page				-	The page of results to return. If this argument is ommited, it defaults to 1.
* sort				-	The order in which to sort returned photos. Deafults to date-posted-desc. 
* 						The possible values are: date-posted-asc, date-posted-desc, date-taken-asc, 
* 						date-taken-desc, interestingness-desc, interestingness-asc, and relevance
* 
* TODO:
* Should probably change it to accept dates as Date Objects... Then you wouldn't have to worry about
* what type of date flickr expects for the different arguments.
* 
* See Also:
* <FlickrResponseListener.onPhotosSearch>
* 
* <http://www.flickr.com/services/api/flickr.photos.search.html>
**/
function photosSearch (params)
{
	callMethod("flickr.photos.search", params);
}
/**
* Function: photosSetDates
* 
* Calls flickr.photos.setDates to set one or both of the dates for a photo..
* 
* All parameters are optional but you must provide either dateTaken or datePosted (or
* both if you like).
* 
* Dates are passed as Flash Date Objects so you don't need to worry about the fact that
* flickr uses two different formats to represent it's dates...
* 
* Parameters:
* photoId 		- 	The id of the photo to edit dates for.
* datePosted	- 	The Date the photo was uploaded to flickr.
* dateTaken		-	The Date the photo was taken.
* dateTakenGran	-	The granularity of the date the photo was taken.
* 
* See Also:
* <FlickrResponseListener.onPhotosSetDates>
* 
* <http://flickr.com/services/api/flickr.photos.setDates.html>
* 
* <http://flickr.com/services/api/misc.dates.html>
**/
function photosSetDates (photoId:Number, datePosted:Date, dateTaken:Date, dateTakenGran:Number)
{
	if (!awaitingResponse) {
		_additionalArgs.photoId = photoId; 
	}
	var params:Object = {photo_id:photoId};
	if (datePosted instanceof Date) {
		params.date_posted = datePosted.getTime()/1000;
		if (!awaitingResponse) _additionalArgs.datePosted = params.date_posted;
	}
	if (dateTaken instanceof Date) {
		params.date_taken = DateUtil.dateToIso(dateTaken);
		if (!awaitingResponse) _additionalArgs.dateTaken = params.date_taken;
	}
	if (dateTakenGran != undefined) params.date_taken_granularity = dateTakenGran;
	callMethod("flickr.photos.setDates", params);
}
/**
* Function: photosSetMeta
* 
* Calls flickr.photos.setMeta to set the meta information for a photo.
* 
* Parameters:
* photoId 		- 	The id of the photo to edit dates for.
* title			- 	The title for the photo.
* description	-	The description for the photo.
* 
* See Also:
* <FlickrResponseListener.onPhotosSetMeta>
* 
* <http://flickr.com/services/api/flickr.photos.setMeta.html>
**/
function photosSetMeta (photoId:Number, title:String, description:String)
{
	if (!awaitingResponse) {
		_additionalArgs.photoId = photoId; 
		_additionalArgs.title = title;
		_additionalArgs.description = description;
	}
	callMethod("flickr.photos.setMeta", {photo_id:photoId, title:title, description:description});
}
/**
* Function: photosSetPerms
* 
* Calls flickr.photos.setPerms to set permissions for a photo..
* 
* Parameters:
* photoId 		- 	The id of the photo to set permissions for.
* isPublic		- 	1 to set the photo to public, 0 to set it to private.
* isFriend		-	1 to make the photo visible to friends when private, 0 to not.
* isFamily		-	1 to make the photo visible to family when private, 0 to not.
* permComment	-	who can add comments to the photo and it's notes. See Flickr.PERM_* for options.
* permAddMeta	-	who can add notes and tags to the photo. See Flickr.PERM_* for options.
* 
* See Also:
* <Flickr.PERM_NOBODY>
* 
* <Flickr.PERM_FRIENDS>
* 
* <Flickr.PERM_CONTACTS>
* 
* <Flickr.PERM_EVERYBODY>
* 
* <FlickrResponseListener.onPhotosSetMeta>
* 
* <http://flickr.com/services/api/flickr.photos.setMeta.html>
**/
function photosSetPerms (photoId:Number, isPublic:Number, isFriend:Number, isFamily:Number, permComment:Number, permAddMeta:Number)
{
	if (!awaitingResponse) {
		_additionalArgs.photoId = photoId; 
	}
	callMethod("flickr.photos.setPerms", {photo_id:photoId, is_public:isPublic, is_friend:isFriend, is_family:isFamily, perm_comment:permComment, perm_addmeta:permAddMeta});
}
/**
* Function: photosSetTags
* 
* Calls flickr.photos.setTags to set the tags for a photo.
* 
* Parameters:
* photoId 		- 	The id of the photo to edit dates for.
* tags			- 	All tags for the photo (as a single space-delimited string).
* 
* See Also:
* <FlickrResponseListener.onPhotosSetTags>
* 
* <Photo.setTags> - 
* There are some problems listed here...
* 
* <http://flickr.com/services/api/flickr.photos.setTags.html>
**/
function photosSetTags (photoId:Number, tags:String)
{
	if (!awaitingResponse) {
		_additionalArgs.photoId = photoId;
		_additionalArgs.tags = tags;
	}
	var params:Object = {photo_id:photoId, tags:tags};
	callMethod("flickr.photos.setTags", {photo_id:photoId, tags:tags});
}

// /flickr.photos methods

// flickr.tags methods

/**
* Function: tagsGetListPhoto
* 
* Calls flickr.tags.getListPhoto to get the tag list for a given photo.
* 
* Parameters:
* photoId		-	The id of the photo to return tags for.
* 
* See Also:
* <FlickrResponseListener.onTagsListPhoto>
* 
* <FlickrResponseListener.onError>
* 
* <http://www.flickr.com/services/api/flickr.tags.getListPhoto.html>
**/
public function tagsGetListPhoto(photoId:Number)
{
	callMethod("flickr.tags.getListPhoto", {photo_id:photoId});
}
/**
* Function: tagsGetListUser
* 
* Calls flickr.tags.getListUser to 
* get the tag list for a given user (or the currently logged in user).
* 
* Parameters:
* userId		-	The NSID of the user to fetch the tag list for. 
* 					[Optional: default=the currently logged in user (if any)]
* 
* See Also:
* <FlickrResponseListener.onTagsGetListUser>
* 
* <FlickrResponseListener.onError>
* 
* <http://www.flickr.com/services/api/flickr.tags.getListUser.html>
**/
public function tagsGetListUser(userId:String)
{
	var params:Object = {};
	if (userId)  params.user_id = userId;
	callMethod("flickr.tags.getListUser", params);
}
/**
* Function: tagsGetListUserPopular
* 
* Calls flickr.tags.getListUserPopular to
* get the popular tags for a given user (or the currently logged in user).
* 
* Parameters:
* userID 		-	The NSID of the user to fetch the tag list for. 
* 					[Optional: default=the currently logged in user (if any)]
* count 		-	Number of popular tags to return. [Optional: default=10]
* 
* See Also:
* <FlickrResponseListener.onTagsGetListUserPopular>
* 
* <FlickrResponseListener.onError>
* 
* <http://www.flickr.com/services/api/flickr.tags.getListUserPopular.html>
**/
public function tagsGetListUserPopular(userId:String, count:Number)
{
	var params:Object = {};
	if (userId)  params.user_id = userId;
	if (count) params.count = count;
	callMethod("flickr.tags.getListUserPopular", params);
}
/**
* Function: tagsGetRelated
* 
* Calls flickr.tags.getRelated to get a list of tags 'related' to the given tag, 
* based on clustered usage analysis.
* 
* Parameters:
* tag - The tag to fetch related tags for.
* 
* See Also:
* <FlickrResponseListener.onTagsGetRelated>
* 
* <FlickrResponseListener.onError>
* 
* <http://www.flickr.com/services/api/flickr.tags.getRelated.html>
**/
public function tagsGetRelated(tag:String)
{
	callMethod("flickr.tags.getRelated", {tag:tag});
}

// /flickr.tags methods


	
// flickr.test methods

/**
* Function: testEcho
* 
* Calls flickr.test.echo -
* forwards any arguments on to the Flickr API
* 
* Parameters:
* 1...n - Any number of parameters to echo back from the server [Optional]
* 
* See Also:
* <FlickrResponseListener.onTestEcho>
* 
* <FlickrResponseListener.onError>
* 
* <http://www.flickr.com/services/api/flickr.test.echo.html>
**/
public function testEcho()
{
	var params:Object = {};
	for (var i=0; i<arguments.length; i++) {
		params["argument"+(i+1)] = arguments[i];
	}
	callMethod("flickr.test.echo", params);
}
/**
* Function: testLogin
* 
* Calls flickr.test.login -
* A testing method which checks if the caller is logged in then returns their username.
* 
* See Also:
* <FlickrResponseListener.onTestLogin>
* 
* <FlickrResponseListener.onError>
* 
* <http://www.flickr.com/services/api/flickr.test.login.html>
**/
public function testLogin()
{
	var params:Object = {};
	callMethod("flickr.test.login", {});
}

// /flickr.test methods
	
	/**
	* Function: callMethod
	* 
	* Used to call a method on the flickr API.
	* 
	* When the method returns an onAPIResponse event is broadcast to any registered 
	* listeners.
	* 
	* You should use the methods above unless you are calling a method on Flickr.com
	* which hasn't yet been implemented in this API as then you will get argument type
	* checking etc...
	* 
	* Parameters:
	* method 				- The name of the method you want to call
	* additionalArguments	- Any additional arguments required by the object [Optional]
	* requiresSigning	 	- Whether the called method requires signing. Used by methods such
	* 						  as flickr.auth.getFrob which need to be signed but are called
	* 						  before the user is auth'd. Once a user is auth'd then all methods
	* 						  are automatically signed.
	* 						  [optional: default=false]
	* 
	* See also:
	* 
	* <Flickr.onAPIResponse>
	**/
	public function callMethod(method:String, additionalArguments:Object, requiresSigning:Boolean):Void
	{
		if (awaitingResponse) {
			dispatchEvent({type:"onAPIResponse", target:this, status:STATUS_BUSY, errorMessage:STATUS_BUSY_DESCRIPTION});
		} else {
			awaitingResponse = true;
			_calledMethod = method;
			additionalArguments = additionalArguments == null ? {} : additionalArguments;
			additionalArguments["api_key"] = _apiKey;
			additionalArguments["method"] = method;
			var url:String = _REST_ENDPOINT+"?";
			if (requiresSigning) { // this is a method that requires signing
				additionalArguments["api_sig"] = _authSignCall(additionalArguments);
			} else if (authPerms != "none") { // the user is auth'd - token and sign the call
				additionalArguments["auth_token"] = _authToken;
				additionalArguments["api_sig"] = _authSignCall(additionalArguments);
			}
			
			var i:Number = 0;
			for (var argumentName:String in additionalArguments) 
			{
				i++;
			}
			additionalArguments.length = i;
			
			i = 0;
			for (var argumentName:String in additionalArguments) 
			{
				//trace('additionalArguments.length: ' + additionalArguments.length)
				url += argumentName+"="+additionalArguments[argumentName];
				if(additionalArguments.length >= (i+1))
				{
					url += "&";
				}
				i++;
			}
			//url += "nocache="+new Date().getTime();
			_restXML = new XML();
			_restXML.ignoreWhite = true;
			_restXML.onLoad = Delegate.create(this, onAPIResponse);
			//trace("Flickr.callMethod: "+url);
			_restXML.load(url);
		}
	}
	
	/**
	* Function: onAPIResponse
	* Called internally on recepit of a response from a request to the
	* <REST_ENDPOINT>.
	* Interperets the received XML and broadcasts an onAPIResponse event to 
	* any registered listeners.
	* If the XML was the result of a known method call then the broadcast
	* event will include sensible information, otherwise it will just be the
	* XML for parsing outside this class (e.g. if a new method has been added
	* to the Flickr.com API and not programmed into this class).
	* 
	* Parameters:
	* success - Whether the call to the API was successfull (e.g. the server
	* specfied in <REST_ENDPOINT> was connected to) or not.
	* 
	**/
	private function onAPIResponse(success:Boolean):Void
	{
		awaitingResponse = false;
		if (success) {
			//trace("Flickr.onAPIResponse received XML: "+_restXML);
			if (_restXML.firstChild.nodeName == "rsp") {
				if (_restXML.firstChild.attributes.stat == "ok") {
					/**
					* got a valid response - parse it based on the method which was called
					* if we don't know how to deal with this method then just return the
					* unparsed XML
					**/
					var eventObject:Object = {};
					eventObject.type = "onAPIResponse";
					eventObject.target = this;
					eventObject.xml = _restXML;
					eventObject.status = STATUS_OK;
					eventObject.method = _calledMethod;
					switch (_calledMethod) {
						case "flickr.auth.getFrob":
							_authFrob = _restXML.firstChild.firstChild.firstChild.nodeValue;
							if (_authIsLoggingIn) {
								_authOpenLogin();
								_authIsLoggingIn = false;
								// skip the rest of the function - the FlickrResponseListener 
								// doesn't need to get involved...
								return; 
							}
							eventObject.frob = _authFrob;
							break;
						case "flickr.auth.getToken":
						case "flickr.auth.checkToken":
							var t:Array = _restXML.firstChild.firstChild.childNodes;
							for (var i:Number=0; i<t.length; i++) {
								var thisNode:XMLNode = t[i];
								switch (thisNode.nodeName) {
									case "user":
										authUser = Person.getPerson(thisNode.attributes.nsid);
										authUser.username = thisNode.attributes.username;
										authUser.realname = thisNode.attributes.fullname;
										break;
									case "perms":
										authPerms = thisNode.firstChild.nodeValue;
										break;
									case "token":
										_authToken = thisNode.firstChild.nodeValue;
										break;
								}
							}
							eventObject.token = _authToken;
							break;
						case "flickr.contacts.getList":
							var t:Array = _restXML.firstChild.firstChild.childNodes;
							for (var i:Number=0; i<t.length; i++) {
								var attribs:Array = t[i].attributes;
								var p:Person = Person.getPerson(attribs.nsid);
								p.username = attribs.username;
								p.friend = attribs.friend;
								p.family = attribs.family;
								p.ignored = attribs.ignored;
								authUser.addPublicContact(p);
							}
							eventObject.user = authUser;
							break;
						case "flickr.contacts.getPublicList":
							var user:Person = Person.getPerson(_additionalArgs.nsid);
							var t:Array = _restXML.firstChild.firstChild.childNodes;
							
							for (var i:Number=0; i<t.length; i++) {
								var attribs:Array = t[i].attributes;
								var contact:Person = Person.getPerson(attribs.nsid);
								contact.username = attribs.username;
								contact.friend = attribs.friend;
								contact.family = attribs.family;
								contact.ignored = attribs.ignored;
								user.addPublicContact(contact);
							}
							eventObject.user = user;
							break;
						case "flickr.favorites.add":
							eventObject.photoId = _additionalArgs.photoId;
							authUser.addFavorite(Photo.getPhoto(_additionalArgs.photoId));
							break;
						case "flickr.favorites.getList":
						case "flickr.favorites.getPublicList":
							var person:Person = Person.getPerson(_additionalArgs.userId);
							var photosList:XMLNode = _restXML.firstChild.firstChild;
							var photos:Array = _parsePhotoXML(photosList);
							for(var i:Number=0; i<photos.length; i++) {
								person.addFavorite(photos[i]);
							}
							eventObject.user = person;
							break;
						case "flickr.favorites.remove":
							eventObject.photoId = _additionalArgs.photoId;
							authUser.removeFavorite(Photo.getPhoto(_additionalArgs.photoId));
							break;
						case "flickr.people.findByEmail":
						case "flickr.people.findByUsername":
							var p:Person = Person.getPerson(_restXML.firstChild.firstChild.attributes.nsid);
							p.username = _restXML.firstChild.firstChild.firstChild.firstChild.nodeValue;
							if (_calledMethod == "flickr.people.findByEmail") {
								p.email = _additionalArgs.email;
							}
							eventObject.person = p;
							break;
						case "flickr.people.getInfo":
							var px:XMLNode = _restXML.firstChild.firstChild;
							var p:Person = Person.getPerson(px.attributes.nsid);
							p.isAdmin = px.attributes.isadmin;
							p.isPro = px.attributes.ispro;
							p.iconServer = px.attributes.iconserver;
							for (var i:Number=0; i<px.childNodes.length; i++) {
								var thisNode:XMLNode = px.childNodes[i];
								switch (thisNode.nodeName) {
									case "username":
										p.username = thisNode.firstChild.nodeValue;
										break;
									case "realname":
										p.realname = thisNode.firstChild.nodeValue;
										break;
									case "location":
										p.location = thisNode.firstChild.nodeValue;
										break;
									case "mbox_sha1sum":
										p.mboxSha1sum = thisNode.firstChild.nodeValue;
										break;
									case "photos":
										for(var j:Number=0; j<thisNode.childNodes.length; j++) {
											switch (thisNode.childNodes[j].nodeName) {
												case "firstdatetaken":
													p.photosFirstDateTaken = DateUtil.isoToDate(thisNode.childNodes[j].firstChild.nodeValue);
													break;
												case "firstdate":
													// date constructor expects number of milliseconds since 1970 - Flickr API returns UNIX timestamp = number seconds since 1970
													var d:Date = DateUtil.secsToDate(thisNode.childNodes[j].firstChild.nodeValue);
													p.photosFirstDate = d;
													break;
												case "count":
													p.numPhotos = thisNode.childNodes[j].firstChild.nodeValue;
													break;
											}
										}
										break;
								}
							}
							eventObject.person = p;
							break;
						case "flickr.people.getPublicGroups":
							eventObject.person = Person.getPerson(_additionalArgs.nsid);
							var groups:Array = _restXML.firstChild.firstChild.childNodes;
							for (var i:Number=0; i<groups.length; i++) {
								var groupData:Object = groups[i].attributes;
								var g:Group = Group.getGroup(groupData.nsid);
								g.name = groupData.name;
								g.eighteenPlus = groupData.eighteenplus;
								eventObject.person.addPublicGroup(g, groupData.admin);
							}
							break;
						case "flickr.people.getPublicPhotos":
							/**
							* TODO:
							* Do we need to deal with the pagination info somehow here?
							* Or is it up to the application programmer to keep track of what s/he
							* asked for? But if more photos are added to the photos array simply with
							* addPhoto then how can the application programmer know which ones they
							* should be interested in?
							**/
							var thisPerson:Person = Person.getPerson(_additionalArgs.nsid);
							var px:XMLNode = _restXML.firstChild.firstChild;
							var photos:Array = _parsePhotoXML(px);
							for (var i:Number=0; i<photos.length; i++) {
								thisPerson.addPhoto(photos[i]);
							}
							eventObject.person = thisPerson;
							break;
						case "flickr.people.getUploadStatus":
							var t:Array = _restXML.firstChild.firstChild.childNodes;
							for (var i:Number=0; i<t.length; i++) {
								var thisNode:XMLNode = t[i];
								switch (thisNode.nodeName) {
									case "username":
										// we must already know the username as it is returned when we log in
										// and we must be logged in to be hear so lets just ignore it!
										break;
									case "bandwidth":
										authUser.bandwidthMax = thisNode.attributes.max;
										authUser.bandwidthUsed = thisNode.attributes.used;
										break;
									case "filesize":
										authUser.filesizeMax = thisNode.attributes.max;
										break;
								}
							}
							eventObject.user = authUser;
							break;
						case "flickr.photos.addTags":
							eventObject.photo = Photo.getPhoto(_additionalArgs.photoId);
							/**
							* TODO:
							* Should we add the tags to <Photo._tags> here? Probably can't as 
							* we don't have as much info as we need e.g. the ids of the tags
							* that have been added or the nsid of the calling user.
							* But you would kind of expect them to be added...
							**/
							eventObject.tags = _additionalArgs.tags;
							break;
						case "flickr.photos.getContactsPhotos":
							var px:XMLNode = _restXML.firstChild.firstChild;
							eventObject.contactsPhotos = _parsePhotoXML(px);
							// add any of the contacts found through this as public contacts to auth'd user
							for (var i:Number=0; i<eventObject.contactsPhotos.length; i++) {
								authUser.addPublicContact(eventObject.contactsPhotos[i].owner);
							}
							break;
						case "flickr.photos.getContactsPublicPhotos":
							var px:XMLNode = _restXML.firstChild.firstChild;
							eventObject.contactsPhotos = _parsePhotoXML(px);
							eventObject.user = Person.getPerson(_additionalArgs.nsid);
							// add any of the contacts found through this as public contacts to user...
							for (var i:Number=0; i<eventObject.contactsPhotos.length; i++) {
								eventObject.user.addPublicContact(eventObject.contactsPhotos[i].owner);
							}
							break;
						case "flickr.photos.getContext":
							var thisPhoto = Photo.getPhoto(_additionalArgs.photoId);
							var nodes:Array = _restXML.firstChild.childNodes;
							for(var i:Number=0; i<nodes.length; i++) {
								if (nodes[i].nodeName == "count") {
									thisPhoto.contextCount = nodes[i].firstChild.nodeValue;
								} else {
									var attribs:Object = nodes[i].attributes;
									if (attribs.id == 0) {
										// When either the previous of next photo is unvailable, 
										// the element is still returned, but contains id="0"
									} else {
										var ph:Photo = Photo.getPhoto(attribs.id);
										ph.secret = attribs.secret;
										ph.title = attribs.title;
										ph.contextUrl = attribs.url;
										ph.contextThumbUrl = attribs.thumb;
										switch (nodes[i].nodeName) {
											case "prevphoto":
												thisPhoto.contextPhotoPrevious = ph;
												break;
											case "nextphoto":
												thisPhoto.contextPhotoNext = ph;
												break;
										}
									}
								}
							}
							eventObject.thisPhoto = thisPhoto;
							break;
						case "flickr.photos.getCounts":
							var nodes:Array = _restXML.firstChild.firstChild.childNodes;
							eventObject.photoCounts = [];
							for(var i:Number=0; i<nodes.length; i++) {
								var countObj:Object = {};
								for(var attributeName:String in nodes[i].attributes) {
									switch (attributeName) {
										case "count":
											countObj[attributeName] = nodes[i].attributes[attributeName];
											break;
										case "fromdate":
										case "todate":
											switch (_additionalArgs.dateType) {
												case "uploaded":
													countObj[attributeName] = DateUtil.secsToDate(nodes[i].attributes[attributeName]);
													break;
												case "taken":
													countObj[attributeName] = DateUtil.isoToDate(nodes[i].attributes[attributeName]);
													break;
											}
									}
								}
								eventObject.photoCounts.push(countObj);
							}
							break;
						case "flickr.photos.getExif":
							var photoInfo:Object = _restXML.firstChild.firstChild.attributes;
							eventObject.photo = Photo.getPhoto(photoInfo.id);
							eventObject.photo.secret = photoInfo.secret;
							eventObject.photo.server = photoInfo.server;
							var exifNodes:Array = _restXML.firstChild.firstChild.childNodes;
							eventObject.photo.exifData = [];
							for (var i:Number=0; i<exifNodes.length; i++) {
								var attr:Object = exifNodes[i].attributes;
								var e:ExifData = new ExifData();
								e.tagspace = attr.tagspace;
								e.tagspaceid = attr.tagspaceid;
								e.tag = attr.tag;
								e.label = attr.label;
								
								var subNodes:Array = exifNodes[i].childNodes;
								for(var j:Number=0; j<subNodes.length; j++) {
									e[subNodes[j].nodeName] = subNodes[j].firstChild.nodeValue;
								}
								
								eventObject.photo.exifData.push (e)
							}
							break;
						case "flickr.photos.getInfo":
							var photoInfo:Object = _restXML.firstChild.firstChild.attributes;
							var ph:Photo = Photo.getPhoto(photoInfo.id);
							ph.secret = photoInfo.secret;
							ph.server = photoInfo.server;
							if (photoInfo.isfavorite && photoInfo.isfavorite>0) {
								authUser.addFavorite(ph);
							}
							ph.licence = photoInfo.license;
							ph.rotation = photoInfo.rotation;
							
							var additionalInfo:Array = _restXML.firstChild.firstChild.childNodes;
							
							for (var i:Number=0; i<additionalInfo.length; i++) {
								var thisNode:XMLNode = additionalInfo[i];
								switch (thisNode.nodeName) {
									case "owner":
										var person:Person = Person.getPerson(thisNode.attributes.nsid);
										person.username = thisNode.attributes.username;
										person.realname = thisNode.attributes.realname;
										person.location = thisNode.attributes.location;
										ph.owner = person;
										person.addPhoto(ph);
										break
									case "title":
										ph.title = thisNode.firstChild.nodeValue;
										break
									case "description":
										ph.description = thisNode.firstChild.nodeValue;
										break
									case "visibility":
										ph.isPublic = thisNode.attributes.ispublic;
										// TODO - again these are related to the calling user as well
										// as to the photo itself - where to store the info??
										ph.isFriend = thisNode.attributes.isfriend;
										ph.isFamily = thisNode.attributes.isfamily;
										break
									case "dates":
										ph.dateUploaded = thisNode.attributes.posted;
										ph.dateTaken = thisNode.attributes.taken;
										// TODO - what is thisNode.attributes.takengranularity ??
										ph.dateUpdated = thisNode.attributes.lastupdate;
										break
									case "permissions":
										// TODO - again these are related to the calling user as well
										// as to the photo itself - where to store the info??
										break
									case "editability":
										/**
										* TODO - somehow need to associate this information with
										* the calling user as opposed to the photo or the photo's
										* owner...
										* This is easier now as we have authUser BUT do we just store the
										* info on the photo or do we store it on the user keyed to the 
										* photo id?
										**/
										break
									case "comments":
										ph.numComments = Number(thisNode.firstChild.nodeValue);
										break
									case "notes":
										var noteNodes:Array = thisNode.childNodes;
										for (var j:Number=0; j<noteNodes.length; j++) {
											var n:Note = Note.getNote(noteNodes[j].attributes.id);
											n.x = noteNodes[j].attributes.x;
											n.y = noteNodes[j].attributes.y;
											n.width = noteNodes[j].attributes.w;
											n.height = noteNodes[j].attributes.h;
											n.text = noteNodes[j].firstChild.nodeValue;
											var noteAuthor:Person = Person.getPerson(noteNodes[j].attributes.author);
											noteAuthor.username = noteNodes[j].attributes.authorname;
											n.author = noteAuthor;
											ph.addNote(n);
										}
										break
									case "tags":
										var tagNodes:Array = thisNode.childNodes;
										for (var j:Number=0; j<tagNodes.length; j++) {
											var t:Tag = Tag.getTag(tagNodes[j].attributes.raw);
											var author:Person = Person.getPerson(tagNodes[j].attributes.author);
											t.value = tagNodes[j].firstChild.nodeValue;
											ph.addTag(tagNodes[j].attributes.id, Tag(t), author);
											t.addPhoto(tagNodes[j].attributes.id, ph, author);
										}
										break
									case "urls":
										var urlNodes:Array = thisNode.childNodes;
										for (var j:Number=0; j<urlNodes.length; j++) {
											switch (urlNodes[j].attributes.type) {
												case "photopage":
													ph.photoPageUrl = urlNodes[j].firstChild.nodeValue;
													break;
												default:
													//trace("flickr.photos.getInfo - what is a subnode of the urls tag called \""+urlNodes[j].attributes.type+"\"?")
											}
										}
										break
									default:
										//trace("flickr.photos.getInfo - what is a node called \""+thisNode.nodeName+"\"?")
								}
							}
							eventObject.photo = ph;
							break;
						case "flickr.photos.getNotInSet":
							var px:XMLNode = _restXML.firstChild.firstChild;
							eventObject.photos = _parsePhotoXML(px);
							break;
						case "flickr.photos.getPerms":
							var px:XMLNode = _restXML.firstChild.firstChild;
							var photo:Photo = Photo.getPhoto(px.attributes.id);
							photo.isPublic = px.attributes.ispublic;
							/**
							* TODO:
							* Need to associate the following attributes with the calling user?
							* Should this be done in the _parsePhotoXML function even though there is
							* only one photo?
							**/
							//photo.isFriend = px.attributes.isfriend;
							//photo.isFamily = px.attributes.isfamily;
							//photo.permComment = px.attributes.permcomment;
							//photo.permAddMeta = px.attributes.permaddmeta;
							eventObject.photo = photo;
							break;
						case "flickr.photos.getRecent":
							var px:XMLNode = _restXML.firstChild.firstChild;
							eventObject.photos = _parsePhotoXML(px);
							break;
						case "flickr.photos.getSizes":
							var thisPhoto:Photo = Photo.getPhoto(_additionalArgs.photoId);
							var sx:XMLNode = _restXML.firstChild.firstChild;
							for (var i:Number=0; i<sx.childNodes.length; i++) {
								var attribs:Object = sx.childNodes[i].attributes;
								var thisSize:PhotoSize = new PhotoSize(thisPhoto, attribs.label);
								thisSize.width = attribs.width;
								thisSize.height = attribs.height;
								thisSize.source = attribs.source;
								thisSize.url = attribs.url;
								thisPhoto.addSize(thisSize);
							}
							eventObject.photo = thisPhoto;
							break;
						case "flickr.photos.getUntagged":
							var px:XMLNode = _restXML.firstChild.firstChild;
							eventObject.photos = _parsePhotoXML(px);
							break;
						case "flickr.photos.removeTag":
							/**
							* nothing is returned... just forward on id of the tag that was removed
							*
							* if we could map the email address to a <Person> then we could 
							* remove the <Tag> from <Person._tags>. We can't remove the <Tag> from 
							* the relevant <Person> or <Photo> because we only know the id and not
							* the Raw which we would need to create a <Tag> instance...
							**/
							eventObject.tagId = _additionalArgs.tagId;
							break;
						case "flickr.photos.search":
							var px:XMLNode = _restXML.firstChild.firstChild;
							eventObject.pages = _restXML.firstChild.firstChild.attributes.pages;
							eventObject.photos = _parsePhotoXML(px);
							break;
						case "flickr.photos.setDates":
							eventObject.photo = Photo.getPhoto(_additionalArgs.photoId);
							if (_additionalArgs.dateTaken != undefined) eventObject.photo.dateTaken = _additionalArgs.dateTaken;
							if (_additionalArgs.datePosted != undefined) eventObject.photo.dateUploaded = _additionalArgs.datePosted;
							break;
						case "flickr.photos.setMeta":
							eventObject.photo = Photo.getPhoto(_additionalArgs.photoId);
							eventObject.photo.title = _additionalArgs.title;
							eventObject.photo.description = _additionalArgs.description;
							break;
						case "flickr.photos.setPerms":
							/**
							* TODO:
							* Should probably update the permissions info somewhere on the <Photo>
							* or in the relationship between that and the logged in user?
							**/
							eventObject.photo = Photo.getPhoto(_additionalArgs.photoId);
							break;
						case "flickr.photos.setTags":
							eventObject.photo = Photo.getPhoto(_additionalArgs.photoId);
							eventObject.photo.setTags(_additionalArgs.tags, authUser);
							break;
						case "flickr.tags.getListPhoto":
							eventObject.photo = Photo.getPhoto(_restXML.firstChild.firstChild.attributes["id"]);
							var t:Array = _restXML.firstChild.firstChild.firstChild.childNodes;
							var authors:Object = {};
							for (var i:Number=0; i<t.length; i++) {
								if (authors[t[i].attributes.author] == undefined) {
									authors[t[i].attributes.author] = Person.getPerson(t[i].attributes.author);
									authors[t[i].attributes.author].username = t[i].attributes.authorname;
									
								}
								var ta:Tag = Tag.getTag(t[i].attributes.raw);
								ta.value = t[i].firstChild.nodeValue == undefined ? t[i].attributes.raw : t[i].firstChild.nodeValue;
								ta.addPhoto(t[i].attributes.id, eventObject.photo, authors[t[i].attributes.author]);
								eventObject.photo.addTag(ta.raw, ta, authors[t[i].attributes.author]);
							}
							break;
						case "flickr.tags.getListUser":
							var tagUserId:String = _restXML.firstChild.firstChild.attributes["id"];
							eventObject.person = Person.getPerson(tagUserId);
							var t:Array = _restXML.firstChild.firstChild.firstChild.childNodes;
							for (var i:Number=0; i<t.length; i++) {
								var ta:Tag = Tag.getTag(t[i].firstChild.nodeValue);
								eventObject.person.addTag(ta);
							}
							break;
						case "flickr.tags.getListUserPopular":
							var tagUserId:String = _restXML.firstChild.firstChild.attributes["id"];
							eventObject.person = Person.getPerson(tagUserId);
							var t:Array = _restXML.firstChild.firstChild.firstChild.childNodes;
							for (var i:Number=0; i<t.length; i++) {
								var ta:Tag = Tag.getTag(t[i].firstChild.nodeValue);
								eventObject.person.addTag(ta, t[i].attributes.count);
							}
							break;
						case "flickr.tags.getRelated":
							var t:Array = _restXML.firstChild.firstChild.childNodes;
							var sourceTag:Tag = Tag.getTag(_restXML.firstChild.firstChild.attributes.source);
							for (var i:Number=0; i<t.length; i++) {
								sourceTag.addRelatedTag(Tag.getTag(t[i].firstChild.nodeValue));
							}
							eventObject.sourceTag = sourceTag;
							break;
						case "flickr.test.echo":
							eventObject.params = [];
							var echo:Array = _restXML.firstChild.childNodes;
							for (var i:Number=0; i<echo.length; i++) {
								eventObject.params.push({name:echo[i].nodeName, value:echo[i].firstChild.nodeValue});
							}
							break;
						case "flickr.test.login":
							eventObject.user = authUser;
							break;
						default:
							eventObject.restXML = _restXML;
							break;
					}
					dispatchEvent(eventObject);
				} else if (_restXML.firstChild.attributes.stat == "fail") {
					var errorCode:Number = Number(_restXML.firstChild.firstChild.attributes.code);
					var errorMessage:String = _restXML.firstChild.firstChild.attributes.msg;
					dispatchEvent({	type:"onAPIResponse", 
									target:this, 
									status:errorCode, 
									errorMessage:errorMessage,
									method:_calledMethod
									});
				}
			} else {
				//trace("Invalid XML returned - outermost node: "+_restXML.firstChild.nodeName);
				dispatchEvent({	type:"onAPIResponse", 
								target:this, 
								status:STATUS_INVALID_XML, 
								errorMessage:STATUS_INVALID_XML_DESCRIPTION,
								method:_calledMethod
								});
			}
		} else {
			//trace("Error connecting to server");
			dispatchEvent({	type:"onAPIResponse", 
							target:this, 
							status:STATUS_ERROR_CONNECTING, 
							errorMessage:STATUS_ERROR_CONNECTING_DESCRIPTION,
							method:_calledMethod
							});
		}
	}
	
	public function set REST_ENDPOINT(REST_ENDPOINT:String):Void
	{
		//trace("REST_ENDPOINT: "+REST_ENDPOINT);
		_REST_ENDPOINT = REST_ENDPOINT;
	}
	public function get REST_ENDPOINT():String
	{
		return _REST_ENDPOINT;
	}
	
	public function set apiKey(apiKey:String):Void
	{
		//trace("API Key set to: "+apiKey);
		// we won't output our whole key for the world to see...
		//trace("API Key set to: " + apiKey.substr(0, -5) + "*****");
		_apiKey = apiKey;
	}
	
	/**
	* Function: _parsePhotoXML
	* 
	* Private internal function used to avoid duplicate code to 
	* parse "the standard photo list xml"
	* 
	* Params:
	* px			-	The "standard photo list xml" from flickr.
	* 
	* Returns:
	* An Array of <Photo> objects.
	**/
	private function _parsePhotoXML(px:XMLNode):Array
	{
		/**
		* TODO:
		* should we ignore the values of page, pages, perpage and total?
		* I guess not but how do we store them - especially don't want to
		* be remembering what photos were where in a list while people 
		* are uploading... Hmmm.
		* Could be good though for when we store the list of photos within
		* a <Person> object? So you know what calls you have to make to get
		* a <Person>'s missing <Photo>s
		**/
		//var page:Number = Number(photosList.attributes.page);
		//var pages:Number = Number(photosList.attributes.pages);
		//var perpage:Number = Number(photosList.attributes.perpage);
		//var total:Number = Number(photosList.attributes.total);
		var photos:Array = [];
		var foundPeople:Object = {}; // so we only create each contact once...
		for (var i:Number=0; i<px.childNodes.length; i++) {
			var attribs:Object = px.childNodes[i].attributes;
			if (foundPeople[attribs.owner] == undefined) {
				foundPeople[attribs.owner] = Person.getPerson(attribs.owner);
				if (attribs.ownername != undefined) {
					foundPeople[attribs.owner].username = attribs.ownername;
				}
				if (attribs.username != undefined) {
					foundPeople[attribs.owner].username = attribs.username;
				}
				if (attribs.iconserver != undefined) {
					foundPeople[attribs.owner].iconServer = attribs.iconserver;
				}
			} 
			var ph:Photo = Photo.getPhoto(attribs.id);
			ph.owner = foundPeople[attribs.owner];
			ph.secret = attribs.secret;
			ph.server = attribs.server;
			ph.title = attribs.title;
			ph.isPublic = attribs.ispublic;
			if (attribs.license !== undefined) {
				ph.licence = attribs.license;
			}
			if (attribs.dateupload != undefined) {
				ph.dateUploaded = attribs.dateupload;
			}
			if (attribs.datetaken != undefined) {
				ph.dateTaken = attribs.datetaken;
				// TODO ignoring attribs.datetakengranularity
			}
			/**
			* TODO:
			* What about
			* attribs.isfriend
			* attribs.isfamily
			* ?? 
			**/
			foundPeople[attribs.owner].addPhoto(ph);
			photos.push(ph);
		}
		return photos;
	}
	
	/**
	* Function: getFlickr
	* 
	* Returns a reference to the Flickr instance -
	* if none exists yet then creates one and returns a reference to that.
	* 
	* Returns:
	* 
	* A <Flickr> instance
	**/
	public static function getFlickr():Flickr
	{
		if (_flickr == null) {
			_flickr = new Flickr();
		}
		return _flickr;
	}
	
	public function toString():String
	{
		return "[Object org.caleb.flickr.Flickr]";
	}
	// function created by EventDispatcher
	function dispatchEvent() {};
	// function created by EventDispatcher
 	function addEventListener() {};
	// function created by EventDispatcher
 	function removeEventListener() {};
}