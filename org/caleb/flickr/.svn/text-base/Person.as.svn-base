//import org.moock.LogWrapper.LogWrapper;

import org.caleb.flickr.Group;
import org.caleb.flickr.Photo;
import org.caleb.flickr.Tag;

/**
* Class: org.caleb.flickr.Person
* Class to describe a person from Flickr.
* 
* Instances of this class are created to hold people who have been
* returned in data from calls to the Flickr API.
**/
class org.caleb.flickr.Person extends org.caleb.core.CoreObject
{
	/**
	* Function: Person
	* 
	* Constructor function - creates a new Person object.
	* 
	* Should be called via <PersonManager.getPerson>
	**/
	function Person(nsid:String)
	{
		this.setClassDescription('org.caleb.flickr.Person');
		//trace('constructor invoked w/ nsid:  ' + nsid);
		this.nsid = nsid;
		_groups = [];
		_photos = [];
		_publicContacts = {};
		_favorites = {};
		_tags = {};
	}
	
	/**
	* Variable: nsid
	* This person's nsid.
	**/
	public var nsid:String;
	/**
	* Variable: username
	* This person's username.
	**/
	public var username:String;
	/**
	* Variable: email
	* This person's email address.
	**/
	public var email:String;
	/**
	* Variable: iconServer
	* Used to build the url to the users' buddyicon
	**/
	public var iconServer:Number;
	/**
	* Variable: friend
	* If this person is a friend.
	**/
	public var friend:Boolean;
	/**
	* Variable: family
	* If this person is family.
	**/
	public var family:Boolean;
	/**
	* Variable: ignored
	* If this person is ignored.
	**/
	public var ignored:Boolean;
	/**
	* Variable: isAdmin
	* If this person is an admin.
	**/
	public var isPro:Boolean;
	/**
	* Variable: isPro
	* If this person has a Pro account.
	**/
	public var isAdmin:Boolean;
	/**
	* Variable: online
	* 
	* DEPRECATED
	* 
	* If this person is online.
	* This relates to their status in the Flickr Live system (<http://flickr.com/_chat/chat.gne>)
	* 
	* Possible Values:
	* 0 - Offline.
	* 1 - Away
	* 2 - Online
	**/
	public var online:Number;
	/**
	* Variable: awayMessage
	* 
	* DEPRECATED
	* 
	* This person's away message (if they are away).
	* This relates to the Flickr Live system (<http://flickr.com/_chat/chat.gne>)
	**/
	public var awayMessage:String;
	/**
	* Variable: realname
	* This person's real name.
	**/
	public var realname:String;
	/**
	* Variable: location
	* This person's location.
	**/
	public var location:String;
	/**
	* Variable: mboxSha1sum
	* This person's mboxSha1sum.
	**/
	public var mboxSha1sum:String;
	/**
	* Variable: numPhotos
	* The number of photos this user has taken.
	**/
	public var numPhotos:String;
	/**
	* Variable: photosFirstDate
	* The date this persons first photograph was uploaded.
	**/
	public var photosFirstDate:Date;
	/**
	* Variable: photosFirstDateTaken
	* The date this persons first photograph was taken.
	**/
	public var photosFirstDateTaken:Date;
	/**
	* Variable: bandwidthMax
	* The bandwidth this user has available, in bytes per month.
	**/
	public var bandwidthMax:Number;
	/**
	* Variable: bandwidthUsed
	* The bandwidth this user has used this month, in bytes.
	**/
	public var bandwidthUsed:Number;
	/**
	* Variable: filesizeMax
	* The maximum size per file that this user can upload, in bytes.
	**/
	public var filesizeMax:Number;
	
	
	/**
	* Variable: _photos
	* An Array containing references to all of this Person's photos. Can be filled up
	* bit by bit as a result of calls to e.g. <Flickr.photosGetInfo>
	* 
	* TODO:
	* Is this a good idea? Do we need to link people back to their photos like this within
	* the library?
	**/
	private var _photos:Array;
	/**
	* Variable: _tags
	* An Object containing references to all of this Person's <Tag>'s
	**/
	private var _tags:Object;
	
	private var _groups:Array;
	
	/**
	* Variable: _publicContacts
	* An Array containing references to all of this Person's contacts.
	* 
	* See Also:
	* <getPublicContacts>
	* 
	* <addPublicContact>
	* 
	**/
	private var _publicContacts:Object;
	/**
	* Variable: _favorites
	* An Array containing references to all of this Person's favourites as <Photo> objects 
	* indexed by the id of each of the favourites.
	* 
	* See Also:
	* <getFavourites>
	* 
	* <addFavourite>
	* 
	**/
	private var _favorites:Object;
	
	/**
	* Variable: _people
	* A private static Object containing Person objects. Used by <getPerson> to insure that only 
	* one Person is created for each nsid returned from flickr.com
	**/
	private static var _people:Object = {};
	/**
	* Function: addPublicGroup
	* 
	* Add's a public group to this user and notes whether this user is an admin of
	* that group.
	* 
	* Parameters:
	* group		-	The <Group> you are adding.
	* isAdmin	- 	Whether this Person is an admin of this group
	* 
	* See Also:
	* <Flickr.peopleGetPublicGroups>
	**/
	function addPublicGroup(group:Group, isAdmin:Boolean):Void
	{
		_groups.push({group:group, isAdmin:(isAdmin == undefined ? false : isAdmin)})
	}
	
	/**
	* Function: getPublicGroups
	* 
	* Gets a list of the public groups that a user is a member of (if 
	* <Flickr.peopleGetPublicGroups> has been called for that user.
	* 
	* TODO:
	* Should this call <Flickr.peopleGetPublicGroups> automatically if it hasn't been called?
	* Probably not because then it would become asyncronous and couldn't return the result
	* immediately
	* 
	* Returns:
	* An Array of Objects containing two items group (a <Group>) and isAdmin (a Boolean) which 
	* marks whether this Person is an administrator of that <Group>
	* 
	* See Also:
	* <Flickr.peopleGetPublicGroups>
	**/
	function getPublicGroups():Array
	{
		return _groups;
	}
	
	/**
	* Function: addPublicContact
	* 
	* Add's a public contact to this user
	* 
	* Parameters:
	* contact	-	The <Person> you are adding.
	* 
	* See Also:
	* <Flickr.contactsGetPublicList>
	* 
	* <getPublicContacts>
	**/
	function addPublicContact(contact:Person):Void
	{
		if (_publicContacts[contact.nsid] == undefined) {
			_publicContacts[contact.nsid] = contact;
		}
	}
	/**
	* Function: getPublicContacts
	* 
	* Gets a list of the public contacts that this user has (if 
	* <addPublicContact> has been called for this user.
	* 
	* Returns:
	* An Object containing <Person> objects indexed by their nsids.
	* 
	* See Also:
	* <Flickr.contactsGetPublicList>
	* 
	* <addPublicContact>
	**/
	function getPublicContacts():Object
	{
		return _publicContacts;
	}
	
	/**
	* Function: addFavorite
	* 
	* Adds a favourite <Photo> to this user.
	* 
	* NOTE, this just updates the internal representation of the user,
	* It doesn't add the favorite on the flickr website. See
	* <Flickr.favoritesAdd> if this is what you want to do.
	* 
	* Parameters:
	* photo			-	The <Photo> you are adding.
	* 
	* See Also:
	* <Flickr.favoritesGetPublicList>
	* 
	* <getFavorites>
	**/
	function addFavorite(photo:Photo):Void
	{
		if (_favorites[photo.id] == undefined) {
			_favorites[photo.id] = photo;
		}
	}
	/**
	* Function: removeFavorite
	* 
	* Removes a favourite <Photo> from this user.
	* 
	* NOTE, this just updates the internal representation of the user,
	* It doesn't remove the favorite on the flickr website. See
	* <Flickr.favoritesRemove> if this is what you want to do.
	* 
	* Parameters:
	* photo			-	The <Photo> you are adding.
	* 
	* See Also:
	* <Flickr.favoritesGetPublicList>
	* 
	* <getFavorites>
	**/
	function removeFavorite(photo:Photo):Void
	{
		if (_favorites[photo.id] != undefined) {
			delete _favorites[photo.id];
		}
	}
	/**
	* Function: getFavorites
	* 
	* Gets a list of the favorite <Photo>'s that this user has.
	* 
	* Returns:
	* An Object containing <Photo> objects indexed by their ids.
	* 
	* See Also:
	* <Flickr.favoritesGetPublicList>
	* 
	* <addFavourite>
	**/
	function getFavorites():Object
	{
		return _favorites;
	}
	
	/**
	* Function: addPhoto
	* 
	* Adds this <Photo> into this Person's <_photos> Array if it isn't already there
	* 
	* Parameters:
	* photo			-	The <Photo> you are adding.
	**/
	function addPhoto(photo:Photo):Void
	{
		for (var i:Number=0; i<_photos.length; i++) {
			if (_photos[i].id == photo.id) return;
		}
		_photos.push(photo);
	}
	/**
	* Function: addTag
	* 
	* Adds a <Tag> into this Person's <_tags> Array if it isn't already there
	* 
	* Parameters:
	* tag			-	The <Tag> you are adding.
	* count			-	The number of times this person uses this tag.
	**/
	function addTag(tag:Tag, count:Number):Void
	{
		var tagData:Object = {tag:tag};
		if (count != undefined) tagData.count = count;
		_tags[tag.raw] = tagData;
		
		//for (var i:Number=0; i<_tags.length; i++) {
		//	if (_tags[i].raw == _tags.raw) return;
		//}
		//_tags[raw] = tag;
	}
	
	/**
	* Function: getTags
	* 
	* Get's this persons <_tags>.
	* 
	**/
	public function getTags():Object
	{
		return _tags;
	}
	
	/**
	* Function: getPerson
	* Get's a Person object for the given nsid.
	* 
	* Consults <_people> to make sure that only one Person instance is created for each
	* nsid from flickr.com
	* 
	* Parameters:
	* nsid			-	The id of the Person you want to get
	**/
	public static function getPerson(nsid:String):Person
	{
		if (_people[nsid] == undefined) {
			_people[nsid] = new Person(nsid);
		}
		return _people[nsid];
	}
	
	function toString():String
	{
		var userString = username == undefined ? "" : "("+username+")";
		return "[Object org.caleb.flickr.Person - "+nsid+" "+userString+"]";
	}
}
