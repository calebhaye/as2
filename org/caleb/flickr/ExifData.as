

/**
* Class: org.caleb.flickr.ExifData
* Class to describe some ExifData as returned by Flickr.
* 
* See Also:
* <Flickr.photosGetExif>
* 
* <FlickrResponseListener.onPhotosGetExif>
**/
class org.caleb.flickr.ExifData extends org.caleb.core.CoreObject
{
	/**
	* Function: ExifData
	* 
	* Constructor function
	**/
	function ExifData()
	{
		this.setClassDescription('org.caleb.flickr.ExifData');
	}
	
	/**
	* Variable: tagspace
	**/
	public var tagspace:String;
	/**
	* Variable: tagspaceid
	**/
	public var tagspaceid:Number;
	/**
	* Variable: tag
	**/
	public var tag:Number;
	/**
	* Variable: label
	**/
	public var label:String;
	/**
	* Variable: raw
	**/
	public var raw:String;
	/**
	* Variable: clean
	* A pretty-formatted version of the tag where availabale.
	**/
	public var clean:String;
	
	function toString():String
	{
		var tagContents:String = clean!=undefined ? clean : raw;
		if (tagContents.length > 20) tagContents = tagContents.substr(0, 20)+"...";
		return "[Object org.caleb.flickr.ExifData ( "+label+" - "+tagContents+")]";
	}
}