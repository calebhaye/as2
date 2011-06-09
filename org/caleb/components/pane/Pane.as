import org.caleb.movieclip.CoreMovieClip;

class org.caleb.components.pane.Pane extends CoreMovieClip
{
	private var m_parentNodeName:String;
	private var m_libraryClip:String;
	private var m_paneInstanceId:String;
	
	public function Pane()
	{
		this.setParentNodeName(undefined);
		this.setLibraryClip(undefined);
		this.setPaneInstanceId(undefined);
		this.setClassDescription('org.caleb.components.pane.Pane');
	}
	public function setLibraryClip(c:String):Void
	{
		this.m_libraryClip = c;
	}
	public function getLibraryClip():String
	{
		return m_libraryClip;
	}
	public function getParentNodeName():String
	{
		return m_parentNodeName;
	}
	public function setParentNodeName(n:String):Void
	{
		this.m_parentNodeName = n;
	}	
	public function getPaneInstanceId():String
	{
		return m_paneInstanceId;
	}
	public function setPaneInstanceId(id:String):Void
	{
		this.m_paneInstanceId = id;
	}	
}