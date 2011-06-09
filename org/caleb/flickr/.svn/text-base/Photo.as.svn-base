//import org.moock.LogWrapper.LogWrapper;
import org.caleb.flickr.Flickr;
import org.caleb.flickr.Person;
import org.caleb.flickr.Note;
import org.caleb.flickr.Tag;
import org.caleb.flickr.PhotoSize;
import org.caleb.util.DateUtil;

/**
* Class: org.caleb.flickr.Photo
* Class to describe a photo from Flickr.
* 
* Instances of this class are created to hold photos who have been
* returned in data from calls to the Flickr API.
* 
* Currently very bare bones -
* this class will be expanded as I program the
* interaction with the flickr.photos.* Flikr API calls
**/
class org.caleb.flickr.Photo extends org.caleb.core.CoreObject
{
	private static var BASE_URL:String = 'http://static.flickr.com/';
	public static var SIZE_SMALL_SQUARE:String = 's'; // s small square 75x75 
	public static var SIZE_THUMBNAIL:String = 't'; // t thumbnail, 100 on longest side 
	public static var SIZE_SMALL:String = 'm'; // m small, 240 on longest side 
	public static var SIZE_MEDIUM:String = undefined; // - medium, 500 on longest side 
	public static var SIZE_LARGE:String = 'b'; // b large, 1024 on longest side (only exists for very large original images) 
	public static var SIZE_ORIGINAL:String = 'o'; // o original image, either a jpg, gif or png, depending on source format 
	public static var FORMAT_JPG:String = 'jpg';
	public static var FORMAT_PNG:String = 'png';
	public static var FORMAT_GIF:String = 'gif';
	/**
	* Function: Photo
	* Constructor function - creates a new Photo object.
	* 
	* Should be called via <PhotoManager.getPhoto>
	**/
	private function Photo(id:Number)
	{
		this.setClassDescription('org.caleb.flickr.Photo');
		//trace('constructor invoked w/ id: ' + id);
		this.id = id;
		this._notes = {};
		this._tags = {};
		this._sizes = [];
	}
	public function getPhotoURL(size:String):String
	{
		if(size == undefined)
		{
			return BASE_URL + this.server + '/' + this.id + '_' + this.secret + '.jpg'; 
		}
		else
		{
			return BASE_URL + this.server + '/' + this.id + '_' + this.secret + '_' + size + '.jpg'; 
		}
	}
	
	/**
	* Variable: id
	* This photo's id.
	**/
	public var id:Number;
	/**
	* Variable: owner
	* A reference to the <Person> who owns this photo.
	**/
	public var owner:Person;
	/**
	* Variable: secret
	* This photo's secret.
	**/
	public var secret:String;
	/**
	* Variable: server
	* This photo's server.
	**/
	public var server:Number;
	/**
	* Variable: title
	* This photo's title.
	**/
	public var title:String;
	/**
	* Variable: description
	* This photo's description.
	**/
	public var description:String;
	/**
	* Variable: numComments
	* The number of comments this photo has.
	**/
	public var numComments:Number;
	/**
	* Variable: notes
	* The <Note>s that have been left on this photo. Private so access through the
	* functions below.
	* 
	* See Also:
	* <getNotes>
	* 
	* <addNote>
	**/
	private var _notes:Object;
	/**
	* Variable: _tags
	* The <Tag>s that are associated with this photo. Private so access through the
	* functions below.
	* 
	* See Also:
	* <getTags>
	* 
	* <addTag>
	**/
	var _tags:Object;
	/**
	* Variable: _sizes
	* The <PhotoSize>s that are associated with this photo. 
	* 
	* See Also:
	* <addSize>
	**/
	private var _sizes:Array;
	/**
	* Variable: isPublic
	* Whether or not this photo is public.
	**/
	public var isPublic:Boolean;
	
	// TODO - the following stuff isn't really relevant to a photo as such....
	// it should be stored as the relationship between the calling user and the
	// photo
	
	/**
	* Variable: isFriend
	* Whether or not this photo is by a friend.
	**/
	public var isFriend:Boolean;
	/**
	* Variable: isFamily
	* Whether or not this photo is by a family member.
	**/
	public var isFamily:Boolean;
	
	// /TODO comment about being about the relationship between the photo
	// and calling user rather than just the photo...
	
	/**
	* Variable: dateUploaded
	* The date this photo was uploaded
	* 
	* You set this as a String which the setter method automagically transforms from a
	* UNIX Timestamp (as provided by flickr.com) to a Date object.
	**/
	private var _dateUploaded:Date;
	public function set dateUploaded(date_str:Date) 
	{
		_dateUploaded = new Date(Number(date_str)*1000);
	}
	public function get dateUploaded():Date
	{
		return _dateUploaded;
	}
	/**
	* Variable: dateTaken
	* The date this photo was taken.
	* 
	* You set this as a string which the setter method automagically transforms from a
	* MySQL Timestamp (as provided by flickr.com) to a Date object.
	**/
	private var _dateTaken:Date;
	public function set dateTaken(date_str:Date) {
		_dateTaken = DateUtil.isoToDate(String(date_str));
	}
	public function get dateTaken():Date
	{
		return _dateTaken;
	}
	/**
	* Variable: dateUpdated
	* The date this photo was uploaded
	* 
	* You set this as a String which the setter method automagically transforms from a
	* UNIX Timestamp (as provided by flickr.com) to a Date object.
	**/
	private var _dateUpdated:Date;
	public function set dateUpdated(date_str:Date) 
	{
		_dateUpdated = new Date(Number(date_str)*1000);
	}
	public function get dateUpdated():Date
	{
		return _dateUpdated;
	}
	/**
	* Variable: licence
	**/
	public var licence:Number;
	/**
	* Variable: rotation
	**/
	public var rotation:Number;
	/**
	* Variable: photoPageUrl
	* The "nicest" link to a photo's page on flickr (including the user's pretty url name
	* if they have one). As returned by flickr.photo.getInfo.
	**/
	public var photoPageUrl:String;
	
	// TODO - this is contextual again and so should not be stored with the Photo
	// but somewhere else refering to the photo object?
	
	/**
	* Variable: contextUrl
	* The URL for this photo within some sort of context e.g. as returned from
	* a call to flickr.photo.getContext
	**/
	public var contextUrl:String;
	/**
	* Variable: contextThumbUrl
	* The URL for this photo's thumbnail image within some sort of context e.g. as returned from
	* a call to flickr.photo.getContext
	**/
	public var contextThumbUrl:String;
	/**
	* Variable: contextPhotoPrevious
	* The previous photo in this context (as returned by <Flickr.photosGetContext>)
	**/
	public var contextPhotoPrevious:Photo;
	/**
	* Variable: contextPhotoNext
	* The next photo in this context (as returned by <Flickr.photosGetContext>)
	**/
	public var contextPhotoNext:Photo;
	/**
	* Variable: contextCount
	* Not documented on flickr.com but maybe the number of photos in this context?
	* (as returned by <Flickr.photoGetContext>)
	**/
	public var contextCount:Number;
	
	
	// /TODO contextual comment above
	
	/**
	* Variable: exifData
	* The EXIF/TIFF/GPS tags associated with this photo.
	* It is an Array of <ExifData> objects.
	**/
	public var exifData:Array;
	/**
	* Variable: _photos
	* A private static Object containing Photo objects. Used by <getPhoto> to insure that only 
	* one Photo is created for each photo ID returned from flickr.com
	**/
	private static var _photos:Object = {};
	/**
	* Function: getNotes
	* 
	* Returns an object containing all the note's that have been left on this
	* Photo
	* 
	* Returns:
	* All the <Note>'s that have been left on this Photo
	* 
	* See Also:
	* <_notes>
	* 
	* <Flickr.photosGetInfo>
	**/
	function getNotes():Object
	{
		return _notes;
	}
	
	/**
	* Function: addNote
	* Adds a <Note> object to this Photo.
	* 
	* Parameters:
	* note			-	The <Note> you want to add to this photo
	**/
	function addNote(note:Note):Void
	{
		if (_notes[note.id] == undefined) {
			_notes[note.id] = note;
		}
	}
	/**
	* Function: getTags
	* 
	* Returns an object containing all the tags's that are associated with this
	* Photo.
	* 
	* Returns:
	* All the <Tag>'s that are associated with this Photo. Each Tag is associated with
	* a <Person> as well - the <Person> who left this <Tag> on this <Photo>. Each <Tag> is
	* also associated with an id - this is the number you would use to call <Flickr.photosRemoveTag>
	* if you wanted to remove that <Tag> from this <Photo>.
	* 
	* See Also:
	* <_tags>
	* 
	* <Flickr.photosGetInfo>
	**/
	function getTags():Object
	{
		return _tags;
	}
	
	/**
	* Function: addTag
	* Adds a <Tag> object to this Photo and associates it with a <Person> who is the <Person> who
	* associated that <Tag> with this <Photo>.
	* 
	* Parameters:
	* id			-	The id which describes the link between this <Photo> and <Tag>.
	* tag			-	The <Tag> you want to add to this photo.
	* author		-	The <Person> who attached that <Tag> to this <Photo>.
	* 
	* See Also:
	* <_tags>
	* 
	* <getTags>
	**/
	function addTag(id:Number, tag:Tag, author:Person):Void
	{
		if (_tags[id] == undefined) {
			_tags[id] = {tag:tag, author:author, id:id};
		}
	}
	
	/**
	* Function: setTags
	* Set's this Photo's <_tags>...
	* 
	* Parameters:
	* tags			-	The tags to add to this photo...
	* author		-	The <Person> who added these tags (leave blank if you don't know)
	* 
	* TODO:
	* Doesn't deal properly with tags with spaces in the name now :(
	* 
	* Also need to get the <Person> object for the logged in user so we can correctly
	* associate the author with the tag...
	* 
	* We don't know the id's that will associate the <Tag>'s with the <Photo>s at this
	* point so are using garbage ones. This means that you won't be able to remove the
	* tags using those ids...
	**/
	function setTags(tags:String, author:Person)
	{
		_tags = {};
		var tagsSplit:Array = tags.split(" ");
		for (var i:Number=0; i<tagsSplit.length; i++) {
			var thisTag:Tag = Tag.getTag(tagsSplit[i]);
			// It would be good to call Tag.addPhoto at this stage but we don't know 
			// the id associating the Person with the Tag
			addTag(i, thisTag, author);
			Flickr.getFlickr().authUser.addTag(thisTag);
		}
	}
	
	/**
	* Function: addSize
	* Adds a <PhotoSize> object to this Photo.
	* 
	* Parameters:
	* size			-	The <PhotoSize> you want to add to this photo.
	**/
	function addSize(size:PhotoSize):Void
	{
		_sizes.push(size);
	}
	
	/**
	* Function: getPhoto
	* Get's a Photo object for the given photo ID.
	* 
	* Consults <_photos> to make sure that only one Photo instance is created for each
	* photo ID from flickr.com
	* 
	* Parameters:
	* photoId		-	The id of the Photo you want to get
	**/
	public static function getPhoto(photoId:Number):Photo
	{
		if (_photos[photoId] == undefined) {
			_photos[photoId] = new Photo(photoId);
		}
		return _photos[photoId];
	}
	public function get url():String
	{
		return this.getPhotoURL(org.caleb.flickr.Photo.SIZE_ORIGINAL);
	}
	public function get thumbnailURL():String
	{
		return this.getPhotoURL(org.caleb.flickr.Photo.SIZE_THUMBNAIL);
	}
	public function get largeURL():String
	{
		return this.getPhotoURL(org.caleb.flickr.Photo.SIZE_LARGE);
	}
	public function get mediumURL():String
	{
		return this.getPhotoURL(org.caleb.flickr.Photo.SIZE_MEDIUM);
	}
	public function get smallURL():String
	{
		return this.getPhotoURL(org.caleb.flickr.Photo.SIZE_SMALL);
	}
	public function get smallSquareURL():String
	{
		return this.getPhotoURL(org.caleb.flickr.Photo.SIZE_SMALL_SQUARE);
	}
	/*
	<photo id="2636" owner="47058503995@N01" 
		secret="a123456" server="2" title="test_04"
		ispublic="1" isfriend="0" isfamily="0" />
	*/
	public function get xml():XML
	{
		var x:XML = new XML;
		var node:XMLNode = x.createElement('photo');
		node.attributes.id = this.id;
		node.attributes.owner = this.owner.nsid;
		node.attributes.secret = this.secret;
		node.attributes.server = this.server;
		node.attributes.title = this.title;
		node.attributes.ispublic = (this.isPublic == true).toString();
		node.attributes.isfriend = (this.isFriend == true).toString();
		node.attributes.isfamily = (this.isFamily == true).toString();
		
		x.appendChild(node);

		return x;
	}
	public function toString():String
	{
		return "[Object org.caleb.flickr.Photo - "+id+"]";
		//return this.getPhotoURL(org.caleb.flickr.Photo.SIZE_THUMBNAIL);
	}
}