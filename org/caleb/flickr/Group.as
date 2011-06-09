

/**
* Class: org.caleb.flickr.Group
* Class to describe a group from Flickr.
* 
* Instances of this class are created to hold groups who have been
* returned in data from calls to the Flickr API.
* 
* Currently very bare bones -
**/
class org.caleb.flickr.Group extends org.caleb.core.CoreObject
{
	/**
	* Function: Group
	* Constructor function - creates a new Group object. 
	* 
	* Don't call directly, use <getGroup> to make sure that there is only one Group instance
	* for each nsid as returned by flickr.com
	**/
	private function Group(nsid:String)
	{
		this.setClassDescription('org.caleb.flickr.Group');
		trace('constructor invoked w/ nsid: ' + nsid);
		this.nsid = nsid;
	}
	/**
	* Variable: nsid
	* This group's nsid.
	**/
	public var nsid:String;
	/**
	* Variable: name
	* The name of this group
	**/
	public var name:String;
	/**
	* Variable: eighteenPlus
	* Whether this group is visible to members over 18 only.
	**/
	public var eighteenPlus:Boolean;
	/**
	* Variable: _groups
	* A private static Object containing Group objects. Used by <getGroup> to insure that only one Group
	* is created for each nsid returned from flickr.com
	**/
	private static var _groups:Object = {};
	
	/**
	* Function: getGroup
	* Get's a Group object for the given nsid.
	* 
	* Consults <_groups> to make sure that only one Group instance is created for each
	* nsid from flickr.com
	* 
	* Parameters:
	* nsid			-	The nsid of the Group you want to get
	**/
	public static function getGroup(nsid:String):Group
	{
		if (_groups[nsid] == undefined) {
			_groups[nsid] = new Group(nsid);
		}
		return _groups[nsid];
	}
	
	function toString():String
	{
		return "[Object org.caleb.flickr.Group - "+nsid+"]";
	}
}