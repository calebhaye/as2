//import org.moock.LogWrapper.LogWrapper;
import org.caleb.flickr.Flickr;
import org.caleb.flickr.Person;
import org.caleb.flickr.Photo;
import org.caleb.flickr.Tag;
import org.caleb.event.Event;
import org.caleb.event.ObservableObject;
/**
* Class: org.caleb.flickr.FlickrResponseListener
* Class to define a listener for responses from the FlickrAPI.
* 
* Subclass this class or override the methods you are interested in and
* use Flickr.addListener... The methods as they exist in this class just
* output debugging information and exist kind of like an interface to 
* specify the callbacks from <Flickr.callMethod> and the variables available
* to them.
* 
* This code is licensed under a Creative Commons License.
* http://creativecommons.org/licenses/by-nc-sa/2.0/
* 
* See Also:
* <Flickr>
* 
* <Flickr.callMethod>
* 
* <http://www.flickr.com/services/api/>
* 
**/
class org.caleb.flickr.FlickrResponseListener extends ObservableObject
{
	
	/**
	* Variable: supressOutput
	* 
	* Used internally to control whether info messages are logged.
	* 
	* See Also:
	* <setSuppressOutput>
	**/
	private var supressOutput:Boolean;
	private var $e:Event;
	
	public function FlickrResponseListener()
	{
		this.setClassDescription('org.caleb.flickr.FlickrResponseListener')
;		//trace('constructor invoked');
		Flickr.getFlickr().addEventListener("onAPIResponse", this);
		supressOutput = false;
		this.$e = new Event;
	}
	public function observeAllEvents(obj:Object)
	{
		this.addEventObserver(obj, 'onAuthGetFrob');
		this.addEventObserver(obj, 'onAuthCheckToken');
		this.addEventObserver(obj, 'onContactsGetList');
		this.addEventObserver(obj, 'onContactsGetPublicList');
		this.addEventObserver(obj, 'onFavoritesAdd');
		this.addEventObserver(obj, 'onFavoritesGetList');
		this.addEventObserver(obj, 'onFavoritesGetPublicList');
		this.addEventObserver(obj, 'onFavoritesRemove');
		this.addEventObserver(obj, 'onPeopleFindByEmail');
		this.addEventObserver(obj, 'onPeopleFindByUsername');
		this.addEventObserver(obj, 'onPeopleGetInfo');
		this.addEventObserver(obj, 'onPeopleGetPublicGroups');
		this.addEventObserver(obj, 'onPeopleGetPublicPhotos');
		this.addEventObserver(obj, 'onPeopleGetUploadStatus');
		this.addEventObserver(obj, 'onPhotosAddTags');
		this.addEventObserver(obj, 'onPhotosGetContactsPhotos');
		this.addEventObserver(obj, 'onPhotosGetContactsPublicPhotos');
		this.addEventObserver(obj, 'onPhotosGetContext');
		this.addEventObserver(obj, 'onPhotosGetCounts');
		this.addEventObserver(obj, 'onPhotosGetExif');
		this.addEventObserver(obj, 'onPhotosGetInfo');
		this.addEventObserver(obj, 'onPhotosGetNotInSet');
		this.addEventObserver(obj, 'onPhotosGetPerms');
		this.addEventObserver(obj, 'onPhotosGetRecent');
		this.addEventObserver(obj, 'onPhotosGetSizes');
		this.addEventObserver(obj, 'onPhotosGetUntagged');
		this.addEventObserver(obj, 'onPhotosRemoveTag');
		this.addEventObserver(obj, 'onPhotosSearch');
		this.addEventObserver(obj, 'onPhotosSetDates');
		this.addEventObserver(obj, 'onPhotosSetMeta');
		this.addEventObserver(obj, 'onPhotosSetPerms');
		this.addEventObserver(obj, 'onPhotosSetTags');
		this.addEventObserver(obj, 'onTagsGetListPhoto');
		this.addEventObserver(obj, 'onTagsGetListUser');
		this.addEventObserver(obj, 'onTagsGetListUserPopular');
		this.addEventObserver(obj, 'onTagsGetRelated');
		this.addEventObserver(obj, 'onTestEcho');
		this.addEventObserver(obj, 'onTestLogin');
		this.addEventObserver(obj, 'onError');
		this.addEventObserver(obj, 'onAPIResponse');
	}
	
	/**
	* Function: setSuppressOutput
	* 
	* Use if you don't want this instance to log it's messages.
	* 
	* You may want to do this if you have multipule FlickrResponseListeners
	* in one movie (e.g. one for auth stuff and one for other calls) or in
	* a production environment.
	* 
	* See Also:
	* <supressOutput>
	**/
	function setSuppressOutput(supressOutput:Boolean):Void
	{
		this.supressOutput = supressOutput;
	}
	
// flickr.auth methods

	/**
	* Function: onAuthGetFrob
	* 
	* Called when there is a successful  response from a call to flickr.auth.getFrob
	* 
	* Note that you only need to use this and <Flickr.authGetFrob> if you have opted
	* not to use <Flickr.authLogin> for some reason.
	* 
	* Parameters:
	* frob				-	a frob to be used during authentication.
	* 
	* See Also:
	* <Flickr.authLogin>
	* 
	* <Flickr.authGetFrob>
	* 
	* <http://flickr.com/services/api/flickr.auth.getFrob.html>
	**/
	public function onAuthGetFrob(frob)
	{
		this.$e.setType('onAuthGetFrob');
		this.$e.addArgument('frob', frob);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) 
		{
			//trace("FlickrResponseListener.onAuthGetFrob: flickr.auth.getFrob");
			//trace("frob = " + frob);
		}
	}

	/**
	* Function: onAuthCheckToken
	* 
	* Called when there is a successful response from a call to flickr.auth.getToken
	* or flickr.auth.checkToken.
	* 
	* The token is returned so that you can save it so that you can authenticate against
	* flickr at a later date without prompting the user again.
	* 
	* Parameters:
	* token				-	the auth token.
	* 
	* See Also:
	* <Flickr.authLogin>
	* 
	* <Flickr.authCheckToken>
	* 
	* <http://www.flickr.com/services/api/flickr.auth.getToken.html>
	* 
	* <http://www.flickr.com/services/api/flickr.auth.checkToken.html>
	**/
	public function onAuthCheckToken(token)
	{
		this.$e.setType('onAuthCheckToken');
		this.$e.addArgument('token', token);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onAuthCheckToken: flickr.auth.checkToken");
			//trace("token = " + token);
		}
	}

// /flickr.auth methods


// flickr.contacts methods
	
	/**
	* Function: onContactsGetList
	* 
	* Called when there is a response from a call to flickr.contacts.getList.
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* contacts 			- 	The <Person> whose contacts you collected.
	* 						Use <Person.getPublicContacts> to see their contacts.
	* 
	* See Also:
	* <Flickr.contactsGetList>
	* 
	* <http://flickr.com/services/api/flickr.contacts.getList.html>
	**/
	function onContactsGetList(user:Person)
	{
		this.$e.setType('onContactsGetList');
		this.$e.addArgument('user', user);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onContactsGetList: flickr.contacts.getList");
			//trace(user);
		}
	}
	/**
	* Function: onContactsGetPublicList
	* 
	* Called when there is a response from a call to flickr.contacts.getPublicList.
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* user 				- 	The <Person> object whose contacts you got. 
	* 						Use <Person.getPublicContacts>
	* 						to retrieve the list of contacts.
	* 
	* See Also:
	* <Flickr.contactsGetPublicList>
	* 
	* <Person.getPublicContacts>
	* 
	* <http://flickr.com/services/api/flickr.contacts.getPublicList.html>
	**/
	function onContactsGetPublicList(user:Person)
	{
		this.$e.setType('onContactsGetPublicList');
		this.$e.addArgument('user', user);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onContactsGetPublicList: flickr.contacts.getPublicList for user "+user.nsid);
			//trace(user);
		}
	}
// /flickr.contacts methods
	
	
// flickr.favorites methods

	/**
	* Function: onFavoritesAdd
	* 
	* Called when there is a response from a call to flickr.favorites.add.
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photo 	- 	The photo which has just been successfully added to the auth'duser's 
	* 				favorites.
	* 
	* See Also:
	* <Flickr.favoritesAdd>
	* 
	* <http://www.flickr.com/services/api/flickr.favorites.add.html>
	**/
	function onFavoritesAdd(photo:Photo)
	{
		this.$e.setType('onFavoritesAdd');
		this.$e.addArgument('photo', photo);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onFavoritesAdd: flickr.favorites.add photo "+photo.id+" added");
		}
	}
	/**
	* Function: onFavoritesGetList
	* 
	* Called when there is a response from a call to flickr.favorites.getList.
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* user		- 	The <Person> whose favourites we got. You see get their favorites using
	* 				<Person.getFavorites>.
	* 
	* See Also:
	* <Flickr.favoritesGetList>
	* 
	* <Person.getFavorites>
	* 
	* <http://www.flickr.com/services/api/flickr.favorites.getList.html>
	**/
	function onFavoritesGetList(user:Person)
	{
		this.$e.setType('onFavoritesGetList');
		this.$e.addArgument('user', user);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onFavoritesGetList: flickr.favorites.getList for user "+ user.nsid);
			//trace(user);
		}
	}
	/**
	* Function: onFavoritesGetPublicList
	* 
	* Called when there is a response from a call to flickr.favorites.getPublicList.
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* user			- 	The <Person> whose favourites we got. You can get their favorites using
	* 					<Person.getFavorites>.
	* 
	* See Also:
	* <Flickr.favoritesGetPublicList>
	* 
	* <Person.getFavorites>
	* 
	* <http://www.flickr.com/services/api/flickr.favorites.getPublicList.html>
	**/
	function onFavoritesGetPublicList(user:Person)
	{
		this.$e.setType('onFavoritesGetPublicList');
		this.$e.addArgument('user', user);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			var message:String = "FlickrResponseListener.onFavoritesGetPublicList: flickr.favorites.getPublicList for user "+ user.nsid;
			//trace(message);
			//trace(user);
		}
	}
	/**
	* Function: onFavoritesRemove
	* 
	* Called when there is a response from a call to flickr.favorites.remove.
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photo 		- 	The photo which has just been successfully removed 
	* 			 	 	from the auth'd user's favorites.
	* 
	* See Also:
	* <Flickr.favoritesRemove>
	* 
	* <http://www.flickr.com/services/api/flickr.favorites.remove.html>
	**/
	function onFavoritesRemove(photo:Photo)
	{
		this.$e.setType('onFavoritesRemove');
		this.$e.addArgument('photo', photo);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			var message:String = "FlickrResponseListener.onFavoritesRemove: flickr.favorites.remove photo "+photo.id+" removed";
			//trace(message);
		}
	}
	
// /flickr.favorites methods

// flickr.people methods
	/**
	* Function: onPeopleFindByEmail
	* 
	* Called when there is a response from a call to flickr.people.findByEmail.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* person 		- 	A <Person> object containing information about the person 
	* 					you found.
	* 
	* See Also:
	* <Flickr.peopleFindByEmail>
	* 
	* <http://flickr.com/services/api/flickr.people.findByEmail.html>
	**/
	function onPeopleFindByEmail(person:Person)
	{
		this.$e.setType('onPeopleFindByEmail');
		this.$e.addArgument('person', person);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPeopleFindByEmail: flickr.people.findByEmail");
			//trace(person);
		}
	}
	/**
	* Function: onPeopleFindByUsername
	* 
	* Called when there is a response from a call to flickr.people.findByUsername.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* person 		- 	A <Person> object containing information about the person you found 
	* 
	* See Also:
	* <Flickr.peopleFindByUsername>
	* 
	* <http://flickr.com/services/api/flickr.people.findByUsername.html>
	**/
	function onPeopleFindByUsername(person:Person)
	{
		this.$e.setType('onPeopleFindByUsername');
		this.$e.addArgument('person', person);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPeopleFindByUsername: flickr.people.findByUsername");
			//trace(person);
		}
	}
	/**
	* Function: onPeopleGetInfo
	* 
	* Called when there is a response from a call to flickr.people.getInfo.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* person 		- 	A <Person> object containing information about the person you found 
	* 				  	(nsid, isAdmin, isPro, username, realname, location, photosFirstDateTaken, 
	* 				  	photosFirstDate and numPhotos).
	* 
	* See Also:
	* <Flickr.peopleGetInfo>
	* 
	* <http://flickr.com/services/api/flickr.people.getInfo.html>
	**/
	function onPeopleGetInfo(person:Person)
	{
		this.$e.setType('onPeopleGetInfo');
		this.$e.addArgument('person', person);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPeopleGetInfo: flickr.people.getInfo response");
			//trace(person);
		}
	}
	/**
	* Function: onPeopleGetPublicGroups
	* 
	* Called when there is a response from a call to flickr.people.getPublicGroups.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* person 		- 	A <Person> object representing the person whose groups you wanted info on
	* 
	* See Also:
	* <Flickr.peopleGetPublicGroups>
	* 
	* <Person.getGroups>
	* 
	* <http://flickr.com/services/api/flickr.people.getPublicGroups.html>
	**/
	function onPeopleGetPublicGroups(person:Person)
	{
		this.$e.setType('onPeopleGetPublicGroups');
		this.$e.addArgument('person', person);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPeopleGetPublicGroups: flickr.people.getPublicGroups response");
			//trace(person);
		}
	}
	/**
	* Function: onPeopleGetPublicPhotos
	* 
	* Called when there is a response from a call to flickr.people.getPublicPhotos.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* person		- 	The <Person> whose public photos you have got.
	* 
	* See Also:
	* <Flickr.peopleGetPublicPhotos>
	* 
	* <Person._photos>
	* 
	* <http://flickr.com/services/api/flickr.people.getPublicPhotos.html>
	**/
	function onPeopleGetPublicPhotos(person:Person)
	{
		this.$e.setType('onPeopleGetPublicPhotos');
		this.$e.addArgument('person', person);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPeopleGetPublicPhotos: flickr.people.getPublicPhotos response");
			//trace(person);
		}
	}
	/**
	* Function: onPeopleGetUploadStatus
	* 
	* Called when there is a response from a call to flickr.people.getUploadStatus.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* person		- 	The <Person> whose upload status you have got (e.g. the currently
	* 					auth'd user).
	* 
	* See Also:
	* <Flickr.peopleGetUploadStatus>
	* 
	* <Person.bandwidthMax>
	* 
	* <Person.bandwidthUsed>
	* 
	* <Person.filesizeMax>
	* 
	* <http://flickr.com/services/api/flickr.people.getUploadStatus.html>
	**/
	function onPeopleGetUploadStatus(person:Person)
	{
		this.$e.setType('onPeopleGetUploadStatus');
		this.$e.addArgument('person', person);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPeopleGetUploadStatus: flickr.people.getUploadStatus response");
			//trace(person);
		}
	}
// /flickr.people methods
	
	
// flickr.photos methods
	/**
	* Function: onPhotosAddTags
	* 
	* Called when there is a response from a call to flickr.photos.addTags.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photo			-	The <Photo> that the tags were added to.
	* tags 			-	The tags that were added. 
	* 
	* See Also:
	* <Flickr.photosAddTags>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.addTags.html>
	**/
	function onPhotosAddTags(photo:Photo, tags:String) 
	{
		this.$e.setType('onPhotosAddTags');
		this.$e.addArgument('photo', photo);
		this.$e.addArgument('tags', tags);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			var message:String = "FlickrResponseListener.onPhotosAddTags: flickr.photos.addTags response: tags:\"" + tags + "\" added to photo: "+photo.id;
			//trace(message);
			//trace(photo);
		}
	}
	/**
	* Function: onPhotosGetContactsPhotos
	* 
	* Called when there is a response from a call to flickr.people.getContactsPhotos.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Note that Flickr.getFlickr().authUser will point to the auth'd user and any contacts
	* that photos were found for whill have been added to that <Person>s contact list.
	* 
	* Parameters:
	* photos 		-	An array of <Photo> objects - one for each photo by a contact of 
	* 					the calling user
	* 
	* See Also:
	* <Flickr.photosGetContactsPhotos>
	* 
	* <http://flickr.com/services/api/flickr.photos.getContactsPhotos.html>
	**/
	function onPhotosGetContactsPhotos(photos:Array)
	{
		this.$e.setType('onPhotosGetContactsPhotos');
		this.$e.addArgument('photos', photos);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			var message:String = "FlickrResponseListener.getContactsPhotos: flickr.photos.getContactsPhotos response";
			//trace(message);
			//trace(photos);
			//trace(Flickr.getFlickr().authUser);
		}
	}
	/**
	* Function: onPhotosGetContactsPublicPhotos
	* 
	* Called when there is a response from a call to flickr.people.getContactsPhotos.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* person		-	The <Person> whose contacts public photos you requested
	* photos 		-	An array of <Photo> objects - one for each photo by a contact of the calling user
	* 
	* See Also:
	* <Flickr.photosGetContactsPublicPhotos>
	* 
	* <http://flickr.com/services/api/flickr.photos.getContactsPublicPhotos.html>
	**/
	function onPhotosGetContactsPublicPhotos(person:Person, photos:Array)
	{
		this.$e.setType('onPhotosGetContactsPublicPhotos');
		this.$e.addArgument('person', person);
		this.$e.addArgument('photos', photos);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			var message:String = "FlickrResponseListener.getContactsPublicPhotos: flickr.photos.getContactsPhotos response for user: "+person.nsid;
			//trace(message);
			//trace(person);
			//trace(photos);
		}
	}
	/**
	* Function: onPhotosGetContext
	* 
	* Called when there is a response from a call to flickr.people.getContext.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photo			-	The <Photo> we were getting the context for. The values of context* will
	* 				  	be set in it and will point to the relevant other <Photo> objects
	* 
	* See Also:
	* <Flickr.photosGetContext>
	* 
	* <http://flickr.com/services/api/flickr.photos.getContext.html>
	**/
	function onPhotosGetContext(photo:Photo)
	{
		this.$e.setType('onPhotosGetContext');
		this.$e.addArgument('photo', photo);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			var message:String = "FlickrResponseListener.onPhotosGetContext: flickr.photos.getContext response (count="+photo.contextCount+")";
			//trace(message);
			//trace(photo);
		}
	}
	/**
	* Function: onPhotosGetCounts
	* 
	* Called when there is a response from a call to flickr.people.getCounts.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* counts		-	An array containing objects for each date range getCounts was called on
	* 					Each object contains the following attributes: count, fromdate and todate
	* 
	* See Also:
	* <Flickr.photosGetCounts>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.getCounts.html>
	**/
	function onPhotosGetCounts(counts:Array)
	{
		this.$e.setType('onPhotosGetCounts');
		this.$e.addArgument('counts', counts);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			var message:String = "FlickrResponseListener.onPhotosGetCounts: flickr.photos.getCounts response:";
			//trace(message);
			//trace(counts);
		}
	}
	/**
	* Function: onPhotosGetExif
	* 
	* Called when there is a response from a call to flickr.people.getExif.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photo			-	A <Photo> containing all the information loaded from flickr.com
	* 
	* See Also:
	* <Flickr.photosGetExif>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.getExif.html>
	**/
	function onPhotosGetExif(photo:Photo)
	{
		this.$e.setType('onPhotosGetExif');
		this.$e.addArgument('photo', photo);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			var message:String = "FlickrResponseListener.onPhotosGetExif: flickr.photos.getExif response:";
			//trace(message);
			//trace(photo);
		}
	}
	/**
	* Function: onPhotosGetInfo
	* 
	* Called when there is a response from a call to flickr.people.getInfo.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photo			- 	A <Photo> containing all the information loaded from flickr.com
	* 
	* See Also:
	* <Flickr.photosGetInfo>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.getInfo.html>
	**/
	function onPhotosGetInfo(photo:Photo)
	{
		this.$e.setType('onPhotosGetInfo');
		this.$e.addArgument('photo', photo);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			var message:String = "FlickrResponseListener.onPhotosGetInfo: flickr.photos.getInfo response:";
			//trace(message);
			//trace(photo);
		}
	}
	/**
	* Function: onPhotosGetNotInSet
	* 
	* Called when there is a response from a call to flickr.people.getPhotosNotInSet.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photos		- 	An Array of <Photo>'s.
	* 
	* See Also:
	* <Flickr.photosGetNotInSet>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.getNotInSet.html>
	**/
	function onPhotosGetNotInSet(photos:Array)
	{
		this.$e.setType('onPhotosGetNotInSet');
		this.$e.addArgument('photos', photos);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPhotosGetNotInSet: flickr.photos.getNotInSet response:");
			//trace(photos);
		}
	}
	/**
	* Function: onPhotosGetPerms
	* 
	* Called when there is a response from a call to flickr.people.getPerms.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photo			- 	The <Photo> that you just got permissions for.
	* 
	* TODO:
	* Need to actually do something with the permissions that were returned. At the moment
	* they are ignored as I need to figure out how to store permissions which are a combination
	* of <Person> and <Photo> - 
	* and so can't just be stored on a <Photo>.
	* 
	* See Also:
	* <Flickr.photosGetPerms>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.getPerms.html>
	**/
	function onPhotosGetPerms(photo:Array)
	{
		this.$e.setType('onPhotosGetPerms');
		this.$e.addArgument('photo', photo);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPhotosGetPerms: flickr.photos.getPerms response:");
			//trace(photo);
		}
	}
	/**
	* Function: onPhotosGetRecent
	* 
	* Called when there is a response from a call to flickr.people.getRecent.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photos		- 	An Array of <Photo>'s.
	* 
	* See Also:
	* <Flickr.photosGetNotInSet>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.getRecent.html>
	**/
	function onPhotosGetRecent(photos:Array)
	{
		this.$e.setType('onPhotosGetRecent');
		this.$e.addArgument('photos', photos);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPhotosGetRecent: flickr.photos.getRecent response:");
			//trace(photos);
		}
	}
	/**
	* Function: onPhotosGetSizes
	* 
	* Called when there is a response from a call to flickr.people.getSizes.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photo			- 	The <Photo> whose sizes you got.
	* 
	* See Also:
	* <Flickr.photosGetSizes>
	* 
	* <Photo._sizes>
	* 
	* <PhotoSize>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.getSizes.html>
	**/
	function onPhotosGetSizes(photo:Photo)
	{
		this.$e.setType('onPhotosGetSizes');
		this.$e.addArgument('photo', photo);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPhotosGetSizes: flickr.photos.getSizes response:");
			//trace(photo);
		}
	}
	/**
	* Function: onPhotosGetUntagged
	* 
	* Called when there is a response from a call to flickr.people.getUntagged.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photos		- 	An Array of <Photo>'s.
	* 
	* See Also:
	* <Flickr.photosGetUntagged>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.getUntagged.html>
	**/
	function onPhotosGetUntagged(photos:Array)
	{
		this.$e.setType('onPhotosGetUntagged');
		this.$e.addArgument('photos', photos);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPhotosGetUntagged: flickr.photos.getUntagged response:");
			//trace(photos);
		}
	}
	/**
	* Function: onPhotosRemoveTag
	* 
	* Called when there is a response from a call to flickr.people.removeTag.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Note that Flickr.getFlickr().authUser will point to the auth'd user who is 
	* obviously the person who removed the Tag if you are interested in that.
	* 
	* Parameters:
	* tagId			-	The ID of the <Tag> that was removed. This identifies a <Tag> and a
	* 					<Photo> it was associated with...
	* 
	* See Also:
	* <Flickr.photosRemoveTag>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.removeTag.html>
	**/
	function onPhotosRemoveTag(tagId:Number)
	{
		this.$e.setType('onPhotosRemoveTag');
		this.$e.addArgument('tagId', tagId);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPhotosRemoveTag: flickr.photos.removeTag response: tag "+tagId);
		}
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
	function onPhotosSearch(photos:Array, pages:Number)
	{
		this.$e.setType('onPhotosSearch');
		this.$e.addArgument('pages', pages);
		this.$e.addArgument('photos', photos);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPhotosSearch: flickr.photos.search response:");
			//trace(photos);
			//trace('pages: ' + pages)
		}
	}
	/**
	* Function: onPhotosSetDates
	* 
	* Called when there is a response from a call to flickr.people.setDates.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photo			- 	The <Photo> whose dates have just been updated,
	* 
	* See Also:
	* <Flickr.photosSetDates>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.setDates.html>
	**/
	function onPhotosSetDates(photo:Photo)
	{
		this.$e.setType('onPhotosSetDates');
		this.$e.addArgument('photo', photo);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPhotosSetDates: flickr.photos.setDates response:");
			//trace(photo);
		}
	}
	/**
	* Function: onPhotosSetMeta
	* 
	* Called when there is a response from a call to flickr.people.setMeta.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photo			- 	The <Photo> whose meta info has just been updated,
	* 
	* See Also:
	* <Flickr.photosSetMeta>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.setMeta.html>
	**/
	function onPhotosSetMeta(photo:Photo)
	{
		this.$e.setType('onPhotosSetMeta');
		this.$e.addArgument('photo', photo);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPhotosSetMeta: flickr.photos.setMeta response:");
			//trace(photo);
		}
	}
	/**
	* Function: onPhotosSetPerms
	* 
	* Called when there is a response from a call to flickr.people.setPerms.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photo			- 	The <Photo> whose permissions info has just been updated,
	* 
	* See Also:
	* <Flickr.photosSetMeta>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.setPerms.html>
	**/
	function onPhotosSetPerms(photo:Photo)
	{
		this.$e.setType('onPhotosSetPerms');
		this.$e.addArgument('photo', photo);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPhotosSetPerms: flickr.photos.setPerms response:");
			//trace(photo);
		}
	}
	/**
	* Function: onPhotosSetTags
	* 
	* Called when there is a response from a call to flickr.people.setTags.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photo			- 	The <Photo> whose tags have just been updated,
	* 
	* See Also:
	* <Flickr.photosSetTags>
	* 
	* <http://www.flickr.com/services/api/flickr.photos.setTags.html>
	**/
	function onPhotosSetTags(photo:Photo)
	{
		this.$e.setType('onPhotosSetTags');
		this.$e.addArgument('photo', photo);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onPhotosSetTags: flickr.photos.setTags response:");
			//trace(photo);
		}
	}
	
// /flickr.photos methods

// flickr.tags methods
	
	/**
	* Function: onTagsGetListPhoto
	* 
	* Called when there is a response from a call to flickr.tags.tagsGetListPhoto.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* photo 		-	The <Photo> whose tags are being returned. Use <Photo.getTags> to
	* 					get at the tags themselves...
	* 
	* See Also:
	* <Flickr.tagsGetListPhoto>
	* 
	* <Photo.getTags>
	* 
	* <http://www.flickr.com/services/api/flickr.tags.getListPhoto.html>
	**/
	function onTagsGetListPhoto(photo:Photo)
	{
		this.$e.setType('onTagsGetListPhoto');
		this.$e.addArgument('photo', photo);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			var message:String = "FlickrResponseListener.onTagsGetListPhoto: flickr.tags.getListPhoto response: photoId: "+photo.id;
			//trace(message);
			//trace(photo);
		}
	}
	/**
	* Function: onTagsGetListUser
	* 
	* Called when there is a response from a call to flickr.tags.getListUser.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* person		- 	The <Person> whose tags are being returned.
	* 
	* See Also:
	* <Flickr.tagsGetListUser>
	* 
	* <http://www.flickr.com/services/api/flickr.tags.getListUser.html>
	**/
	function onTagsGetListUser(person:Person)
	{
		this.$e.setType('onTagsGetListUser');
		this.$e.addArgument('person', person);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			var message:String = "FlickrResponseListener.onTagsGetListUser: flickr.tags.getListUser response for "+person.nsid;
			//trace(message);
			//trace(person);
		}
	}
	/**
	* Function: onTagsGetListUserPopular
	* 
	* Called when there is a response from a call to flickr.tags.getListUserPopular.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* person		- 	The <Person> whose tags are being returned.
	* 
	* See Also:
	* <Flickr.tagsGetListUserPopular>
	* 
	* <http://www.flickr.com/services/api/flickr.tags.getListUserPopular.html>
	**/
	function onTagsGetListUserPopular(person:Person)
	{
		this.$e.setType('onTagsGetListUserPopular');
		this.$e.addArgument('person', person);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onTagsGetListUser: flickr.tags.getListUser response for "+person.nsid);
			//trace(person);
		}
	}
	/**
	* Function: onTagsGetRelated
	* 
	* Called when there is a response from a call to flickr.tags.tagsGetRelated.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* sourceTag		-	The tag you were getting related tags for - look in it's 
	* 					relatedTags Object.
	* 
	* See Also:
	* <Flickr.tagsGetRelated>
	* 
	* <Tag.relatedTags>
	* 
	* <http://www.flickr.com/services/api/flickr.tags.getRelated.html>
	**/
	function onTagsGetRelated(sourceTag:Tag)
	{
		this.$e.setType('onTagsGetRelated');
		this.$e.addArgument('sourceTag', sourceTag);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onTagsGetRelated: flickr.tags.getRelated response");
			//trace(sourceTag);
		}
	}
	
// /flickr.tags methods


// flickr.test methods
	
	/**
	* Function: onTestEcho
	* 
	* Called when there is a response from a call to flickr.test.echo.
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* params 		-	An object with containing all the echo'd variables.
	* 
	* See Also:
	* <Flickr.testEcho>
	* 
	* <http://www.flickr.com/services/api/flickr.test.echo.html>
	**/
	function onTestEcho(params:Object)
	{
		this.$e.setType('onTestEcho');
		this.$e.addArgument('params', params);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace("FlickrResponseListener.onTestEcho: flickr.test.echo response:");
			//trace(params);
		}
	}
	
	/**
	* Function: onTestLogin
	* 
	* Called when there is a response from a call to flickr.test.login
	* 
	* Override this method in your application if you want to do something with the
	* response to this call.
	* 
	* Parameters:
	* user			-	A reference to the logged in user
	* 
	* See Also:
	* <Flickr.testLogin>
	* 
	* <http://www.flickr.com/services/api/flickr.test.login.html>
	**/
	function onTestLogin(user:Person)
	{
		this.$e.setType('onTestLogin');
		this.$e.addArgument('user', user);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) 
		{
			//trace("FlickrResponseListener.onTestLogin: flickr.test.login response:");
			//trace(user);
		}
	}
	
// /flickr.test methods
	
	/**
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
	function onError(errorCode:Number, errorDescription:String, method:String)
	{
		this.$e.setType('onError');
		this.$e.addArgument('errorCode', errorCode);
		this.$e.addArgument('errorDescription', errorDescription);
		this.$e.addArgument('method', method);
		this.dispatchEvent(this.$e);
		
		if (!supressOutput) {
			//trace(errorCode+": "+errorDescription+" when calling '"+method+"'");
		}
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
	function onAPIResponse(eventObject:Object)
	{
		this.$e.setType('onAPIResponse');
		this.$e.addArgument('eventObject', eventObject);
		this.dispatchEvent(this.$e);
		
		if (eventObject.status == Flickr.STATUS_OK) {
			switch (eventObject.method) {
				case "flickr.auth.getFrob":
					this.onAuthGetFrob(eventObject.frob);
					break;
				case "flickr.auth.getToken":
				case "flickr.auth.checkToken":
					this.onAuthCheckToken(eventObject.token);
					break;
				case "flickr.contacts.getList":
					this.onContactsGetList(eventObject.user);
					break;
				case "flickr.contacts.getPublicList":
					this.onContactsGetPublicList(eventObject.user);
					break;
				case "flickr.favorites.add":
					this.onFavoritesAdd(Photo.getPhoto(eventObject.photoId));
					break;
				case "flickr.favorites.getList":
					this.onFavoritesGetList(eventObject.user);
					break;
				case "flickr.favorites.getPublicList":
					this.onFavoritesGetPublicList(eventObject.user);
					break;
				case "flickr.favorites.remove":
					this.onFavoritesRemove(Photo.getPhoto(eventObject.photoId));
					break;
				case "flickr.people.findByEmail":
					this.onPeopleFindByEmail(eventObject.person);
					break;
				case "flickr.people.findByUsername":
					this.onPeopleFindByUsername(eventObject.person);
					break;
				case "flickr.people.getInfo":
					this.onPeopleGetInfo(eventObject.person);
					break;
				case "flickr.people.getPublicGroups":
					this.onPeopleGetPublicGroups(eventObject.person);
					break;
				case "flickr.people.getPublicPhotos":
					this.onPeopleGetPublicPhotos(eventObject.person);
					break;
				case "flickr.people.getUploadStatus":
					this.onPeopleGetUploadStatus(eventObject.user);
					break;
				case "flickr.photos.addTags":
					this.onPhotosAddTags(eventObject.photo, eventObject.tags);
					break;
				case "flickr.photos.getContactsPhotos":
					this.onPhotosGetContactsPhotos(eventObject.contactsPhotos);
					break;
				case "flickr.photos.getContactsPublicPhotos":
					this.onPhotosGetContactsPublicPhotos(eventObject.user, eventObject.contactsPhotos);
					break;
				case "flickr.photos.getContext":
					this.onPhotosGetContext(eventObject.thisPhoto);
					break;
				case "flickr.photos.getCounts":
					this.onPhotosGetCounts(eventObject.photoCounts);
					break;
				case "flickr.photos.getExif":
					this.onPhotosGetExif(eventObject.photo);
					break;
				case "flickr.photos.getInfo":
					this.onPhotosGetInfo(eventObject.photo);
					break;
				case "flickr.photos.getNotInSet":
					this.onPhotosGetNotInSet(eventObject.photos);
					break;
				case "flickr.photos.getPerms":
					this.onPhotosGetPerms(eventObject.photo);
					break;
				case "flickr.photos.getRecent":
					this.onPhotosGetRecent(eventObject.photos);
					break;
				case "flickr.photos.getSizes":
					this.onPhotosGetSizes(eventObject.photo);
					break;
				case "flickr.photos.getUntagged":
					this.onPhotosGetUntagged(eventObject.photos);
					break;
				case "flickr.photos.removeTag":
					this.onPhotosRemoveTag(eventObject.tagId);
					break;
				case "flickr.photos.search":
				//trace('eventObject.pages '+eventObject.pages)
					this.onPhotosSearch(eventObject.photos, eventObject.pages);
					break;
				case "flickr.photos.setDates":
					this.onPhotosSetDates(eventObject.photo);
					break;
				case "flickr.photos.setMeta":
					this.onPhotosSetMeta(eventObject.photo);
					break;
				case "flickr.photos.setPerms":
					this.onPhotosSetPerms(eventObject.photo);
					break;
				case "flickr.photos.setTags":
					this.onPhotosSetTags(eventObject.photo);
					break;
				case "flickr.tags.getListPhoto":
					this.onTagsGetListPhoto(eventObject.photo);
					break;
				case "flickr.tags.getListUser":
					this.onTagsGetListUser(eventObject.person);
					break;
				case "flickr.tags.getListUserPopular":
					this.onTagsGetListUserPopular(eventObject.person);
					break;
				case "flickr.tags.getRelated":
					this.onTagsGetRelated(eventObject.sourceTag);
					break;
				case "flickr.test.echo":
					this.onTestEcho(eventObject.params);
					break;
				case "flickr.test.login":
					this.onTestLogin(eventObject.user);
					break;
				default:
					//trace("Got response for call to method "+eventObject.method+":\n"+eventObject.restXML);
			}
		} else {
			this.onError(eventObject.status, eventObject.errorMessage, eventObject.method);
		}
	}	
}
