
import org.caleb.flickr.Person;
import org.caleb.flickr.Photo;

/**
* Class: org.caleb.flickr.Tag
* Class to describe a tag on a photo on Flickr.
* 
* Instances of this class are created to hold tags that are attached to Photos
* returned from flickr.com
* 
* Currently very bare bones -
* this class will be expanded
**/
class org.caleb.flickr.Tag extends org.caleb.core.CoreObject
{
	/**
	* Function: Tag
	* Constructor function - creates a new Tag object.
	* 
	* Don't call directly, use <getTag> to make sure that there is only one Tag instance
	* for each id as returned by flickr.com
	**/
	private function Tag(raw:String)
	{
		this.setClassDescription('org.caleb.flickr.Tag');
		trace('constructor invoked w/ raw: ' + raw);
		this.raw = raw;
		this._photos = {};
		this.relatedTags = {};
	}
	/**
	* Variable: raw
	* The raw text of this tag
	**/
	public var raw:String;
	/**
	* Variable: value
	* The text of this tag
	**/
	public var value:String;
	/**
	* Variable: _photos
	* An object detailing the relationships between this tag and different photos.
	**/
	public var _photos:Object;
	/**
	* Variable: relatedTags
	* An object containing a list of tags that are related to this one, based on clustered usage analysis.
	* 
	* See Also:
	* <Flickr.tagsGetRelated>
	**/
	public var relatedTags:Object;
	
	/**
	* Variable: _tags
	* A private static Object containing Tag objects. Used by <getTag> to insure that only one Tag
	* is created for each tag returned from flickr.com
	**/
	private static var _tags:Object = {};
	/**
	* Function: addPhoto
	* Add's a reference to a <Photo> to this <Tag>.
	* 
	* Parameters:
	* id			-	The id which describes the link between this <Photo> and <Tag>.
	* photo			-	The <Photo> you want to add to this tag.
	* author		-	The <Person> who attached that <Tag> to this <Photo>.
	* 
	* See Also:
	* <_photos>
	* 
	* <getPhotos>
	**/
	
	//function addPhoto(id:Number, photo:Photo, author:Person):Void
	function addPhoto(id:String, photo:Photo, author:Person):Void
	{
		if (_photos[id] == undefined) {
			_photos[id] = {photo:photo, author:author, id:id};
		}
	}
	/**
	* Function: getPhotos
	* Get's this tags <_photos> Object.
	* 
	* See Also:
	* <_photos>
	* 
	* <setPhotos>
	**/
	function getPhotos():Object
	{
		return _photos;
	}
	
	/**
	* Function: addRelatedTag
	* Add's a reference to a related <Tag> to this Tag.
	* 
	* See Also:
	* <Flickr.tagsGetRelated>
	**/
	function addRelatedTag(tag:Tag)
	{
		// stored indexed by their raw element to ensure each Tag is only added once...
		relatedTags[tag.raw] = tag;
	}
	
	/**
	* Function: getTag
	* Get's a Tag object for the given id.
	* 
	* Consults <_tags> to make sure that only one Tag instance is created for each
	* tag id from flickr.com
	* 
	* Parameters:
	* raw			-	The raw of the Tag you want to get
	**/
	public static function getTag(raw:String):Tag
	{
		if (_tags[raw] == undefined) {
			_tags[raw] = new Tag(raw);
		}
		return _tags[raw];
	}
	
	function toString():String
	{
		return "[Object org.caleb.flickr.Tag - "+raw+"]";
	}
}