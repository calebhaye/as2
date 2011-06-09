import org.caleb.yahoo.search.*;

class org.caleb.yahoo.YahooAPI
{
	public static var PODCAST_SEARCH:String = YahooSearchUtil.PODCAST_SEARCH;
	public static var WEB_SEARCH:String = YahooSearchUtil.WEB_SEARCH;
	public static var IMAGE_SEARCH:String = YahooSearchUtil.IMAGE_SEARCH;
	public static var NEWS_SEARCH:String = YahooSearchUtil.NEWS_SEARCH;
	public static var VIDEO_SEARCH:String = YahooSearchUtil.VIDEO_SEARCH;
	public static var LOCAL_SEARCH:String = YahooSearchUtil.LOCAL_SEARCH;
	public static var TERM_EXTRACTION:String = YahooSearchUtil.TERM_EXTRACTION;
	public static var RELATED_SUGGESTION:String = YahooSearchUtil.RELATED_SUGGESTION;
	public static var SPELLING_SUGGESTION:String = YahooSearchUtil.SPELLING_SUGGESTION;
	public static var CONTEXT_ANALYSIS:String = YahooSearchUtil.CONTEXT_ANALYSIS;
	
	public static function search(target:Object, query:String, searchType:String, resultsLength:Number):SearchResultXML
	{
		return YahooSearchUtil.search(target, query, searchType, resultsLength, arguments[4], arguments[5]);
	}
	public static function webSearch(target:Object, needle:String, resultsLength:Number):SearchResultXML
	{
		return YahooAPI.search(target, needle, YahooAPI.WEB_SEARCH, resultsLength);
	}
	public static function contextSearch(target:Object, needle:String, context:String, resultsLength:Number):SearchResultXML
	{
		return YahooAPI.search(target, needle, YahooAPI.CONTEXT_ANALYSIS, resultsLength, '&context='+context);
	}
	public static function imageSearch(target:Object, needle:String, resultsLength:Number):SearchResultXML
	{
		return YahooAPI.search(target, needle, YahooAPI.IMAGE_SEARCH, resultsLength);
	}
	public static function newsSearch(target:Object, needle:String, resultsLength:Number):SearchResultXML
	{
		return YahooAPI.search(target, needle, YahooAPI.NEWS_SEARCH, resultsLength);
	}
	public static function termExtraction(target:Object, needle:String, resultsLength:Number):SearchResultXML
	{
		return YahooAPI.search(target, needle, YahooAPI.TERM_EXTRACTION, resultsLength);
	}
	public static function localSearch(target:Object, needle:String, zip:Number, resultsLength:Number):SearchResultXML
	{
		trace('*********** zip: ' + zip);
		return YahooAPI.search(target, needle, YahooAPI.LOCAL_SEARCH, resultsLength, '&zip='+zip);
	}
	public static function spellingSuggestion(target:Object, needle:String, resultsLength:Number):SearchResultXML
	{
		return YahooAPI.search(target, needle, YahooAPI.SPELLING_SUGGESTION, resultsLength);
	}
	public static function relatedSuggestion(target:Object, needle:String, resultsLength:Number):SearchResultXML
	{
		return YahooAPI.search(target, needle, YahooAPI.RELATED_SUGGESTION, resultsLength);
	}
	public static function podcastSearch(target:Object, needle:String, resultsLength:Number):SearchResultXML
	{
		return YahooAPI.search(target, needle, YahooAPI.PODCAST_SEARCH, resultsLength);
	}
}