
import org.caleb.flickr.Photo;

/**
* Class: org.caleb.flickr.PhotoSize
* Class to describe the size of a <Photo> from Flickr.
* 
* Currently very bare bones -
* this class will be expanded as I program the
* interaction with the flickr.photos.* Flikr API calls
* 
* See Also:
* <Photo>
**/
class org.caleb.flickr.PhotoSize extends org.caleb.core.CoreObject
{
	/**
	* Function: PhotoSize
	* Constructor function - creates a new PhotoSize object.
	**/
	function PhotoSize(photo:Photo, label:String)
	{
		this.setClassDescription('org.caleb.flickr.PhotoSize');
		trace('constructor invoked');
		this.photo = photo;
		this.label = label;
	}
	/**
	* Variable: photo
	* The photo that this PhotoSize is associated with
	**/
	public var photo:Photo;
	/**
	* Variable: label
	* This photo size's label.
	**/
	public var label:String;
	/**
	* Variable: width
	* This <Photo>'s width.
	**/
	public var width:Number;
	/**
	* Variable: height
	* This <Photo>'s height.
	**/
	public var height:Number;
	/**
	* Variable: source
	* This photo size's source.
	**/
	public var source:String;
	/**
	* Variable: url
	* This photo size's url.
	**/
	public var url:String;
	
	function toString():String
	{
		return "[Object org.caleb.flickr.PhotoSize - "+url+"]";
	}
}