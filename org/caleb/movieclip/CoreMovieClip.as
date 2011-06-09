import org.caleb.core.CoreInterface;
import org.caleb.Configuration;
/**
 * 
 * @see     MovieClip	
 * @see     CoreInterface	
 */
class org.caleb.movieclip.CoreMovieClip extends MovieClip implements CoreInterface
{
	private var $instanceDescription:String;

	function CoreMovieClip(Void)
	{
		this.setClassDescription('org.caleb.movieclip.CoreMovieClip');
	}
	public function get classType():String
	{
		return this.$instanceDescription.toString().substring(this.$instanceDescription.toString().lastIndexOf('.') + 1);
	}
	public function toString(Void):String
	{
		return this.$instanceDescription;
	}
	private function setClassDescription(d:String):Void
	{
		this.$instanceDescription = d;
	}

}

