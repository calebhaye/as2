
import org.caleb.flickr.Person;

/**
* Class: org.caleb.flickr.Note
* Class to describe a note on a photo on Flickr.
* 
* Instances of this class are created to hold notes that are attached to Photos
* returned from flickr.com
* 
* Currently very bare bones -
**/
class org.caleb.flickr.Note extends org.caleb.core.CoreObject
{
	/**
	* Function: Note
	* Constructor function - creates a new Note object.
	* 
	* Don't call directly, use <getNote> to make sure that there is only one Note instance
	* for each id as returned by flickr.com
	**/
	private function Note(id:Number)
	{
		this.setClassDescription('org.caleb.flickr.Note');
		trace('constructor invoked w/ id: ' + id);
		this.id = id;
	}
	/**
	* Variable: id
	* This note's if
	**/
	public var id:Number;
	/**
	* Variable: author
	* The person who wrote this note
	**/
	public var author:Person;
	/**
	* Variable: text
	* The contents of this note
	**/
	public var text:String;
	/**
	* Variable: x
	* The x coordinate of this note
	**/
	public var x:Number;
	/**
	* Variable: y
	* The y coordinate of this note
	**/
	public var y:Number;
	/**
	* Variable: width
	* The width of this note
	**/
	public var width:Number;
	/**
	* Variable: height
	* The height of this note
	**/
	public var height:Number;
	
	/**
	* Variable: _notes
	* A private static Object containing Note objects. Used by <getNote> to insure that only one Note
	* is created for each note id from flickr.com
	**/
	private static var _notes:Object = {};
	/**
	* Function: getNote
	* Get's a Note object for the given id.
	* 
	* Consults <_notes> to make sure that only one Note instance is created for each
	* note id from flickr.com
	* 
	* Parameters:
	* id			-	The id of the Note you want to get
	**/
	public static function getNote(id:Number):Note
	{
		if (_notes[id] == undefined) {
			_notes[id] = new Note(id);
		}
		return _notes[id];
	}
	
	function toString():String
	{
		return "[Object org.caleb.flickr.Note - "+id+"]";
	}
}