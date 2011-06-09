import org.caleb.event.ObservableObject;
import org.caleb.xml.SimpleXML;
import org.caleb.yahoo.search.SearchResultXML;

class org.caleb.yahoo.search.YahooSearchUtil extends ObservableObject
{
	public static var APPLICATION_ID:String = 'YahooFlashSDKSearchUtil';
	//public static var BETA_SEARCH_SERVICE_URL:String = 'http://beta.api.search.yahoo.com/';
	private static var SEARCH_SERVICE_ENDPOINT:String = '.yahooapis.com/';
	public static var AUDIO_SEARCH:String 	= 'audio';
	public static var PODCAST_SEARCH:String 	= 'podcast';
	public static var WEB_SEARCH:String 	= 'search';
	public static var IMAGE_SEARCH:String = 'image';
	public static var NEWS_SEARCH:String 	= 'news';
	public static var VIDEO_SEARCH:String = 'video';
	public static var LOCAL_SEARCH:String = 'local';
	public static var TERM_EXTRACTION:String = 'termextraction';
	public static var RELATED_SUGGESTION:String = 'related';
	public static var SPELLING_SUGGESTION:String = 'spelling';
	public static var CONTEXT_ANALYSIS:String = 'contextanalysis';
	
	public static function search(target:Object, query:String, searchType:String, resultsLength:Number):SearchResultXML
	{
		if(searchType == undefined)
		{
			searchType = WEB_SEARCH;
		}
		if(resultsLength == undefined)
		{
			resultsLength = 20;
		}
		var additionalArguments:String = '';
		if(arguments[4] != undefined)
		{
			additionalArguments = arguments[4];
		}
		var eventName:String = 'onYahooSearchResult';
		if(arguments[5] != undefined)
		{
			eventName = arguments[5];
		}
		var $searchXML = new SearchResultXML(eventName);
		
		if(target != undefined)
		{
			$searchXML.addEventObserver(target, eventName)
		}
		$searchXML.init($searchXML.handleSearch, query, searchType, target, '&results=' + resultsLength + additionalArguments);
		
		return $searchXML;
	}
	/**
	 * This method simply returns a properly formated query url for performing a Yahoo! search
	 * 
	 * @usage   this.queryURL:String = YahooSearchUtil.getServiceURL(needle, searchType, zip);
	 * @param   needle    (String) text to search for 
	 * @param   searchType (String) tyoe of search, can be any of the following: 'image', 'audio', 'news', 'video', 'web', 'local'
	 * @return  String
	 */
	public static function getServiceURL(needle:String, searchType:String):String
	{
		var query:String;
		var zip:String;
		var serviceURL:String;
		// chack for zip
		trace('arguments[2]: ' + arguments[2])
		if(arguments[2] != undefined)
		{
			zip = '&zip=' + arguments[2];
		}
		// ensure presence of required parameters
		if(needle == undefined || searchType == undefined)
		{
			return undefined;
		}
		else
		{
			query = '?appid=' + APPLICATION_ID + '&';
		}
		
		var queryKey:String;
		switch(searchType)
		{
			case YahooSearchUtil.TERM_EXTRACTION:
			{
				queryKey = 'context';
			}
			break;
			default:
			{
				queryKey = 'query';
			}
			break;
		}
		query += queryKey.concat('=');
		// access Y! search string
		query += needle;
		// add zip if need be
		if(zip != undefined)
		{
			query += zip;
		}
		var services:Array = new Array;
		services[IMAGE_SEARCH] = 'http://' + WEB_SEARCH + SEARCH_SERVICE_ENDPOINT + 'ImageSearchService/V1/imageSearch';
		services[NEWS_SEARCH]  = 'http://' + WEB_SEARCH + SEARCH_SERVICE_ENDPOINT + 'NewsSearchService/V1/newsSearch';
		services[VIDEO_SEARCH] = 'http://' + WEB_SEARCH + SEARCH_SERVICE_ENDPOINT + 'VideoSearchService/V1/videoSearch';
		services[WEB_SEARCH]   = 'http://' + WEB_SEARCH + SEARCH_SERVICE_ENDPOINT + 'WebSearchService/V1/webSearch';
		services[RELATED_SUGGESTION]   = 'http://' + WEB_SEARCH + SEARCH_SERVICE_ENDPOINT + 'WebSearchService/V1/relatedSuggestion';
		services[SPELLING_SUGGESTION]   = 'http://' + WEB_SEARCH + SEARCH_SERVICE_ENDPOINT + 'WebSearchService/V1/spellingSuggestion';
		services[CONTEXT_ANALYSIS] = 'http://' + WEB_SEARCH + SEARCH_SERVICE_ENDPOINT + 'WebSearchService/V1/contextSearch';	
		services[PODCAST_SEARCH] = 'http://' + WEB_SEARCH + SEARCH_SERVICE_ENDPOINT + 'AudioSearchService/V1/podcastSearch';
		services[TERM_EXTRACTION] = 'http://' + WEB_SEARCH + SEARCH_SERVICE_ENDPOINT + 'ContentAnalysisService/V1/termExtraction';	

		//services[AUDIO_SEARCH] = 'http://' + AUDIO_SEARCH + BETA_SEARCH_SERVICE_URL + 'AudioSearchService/V1/audioSearch';
		services[LOCAL_SEARCH] = 'http://' + LOCAL_SEARCH + SEARCH_SERVICE_ENDPOINT + 'LocalSearchService/V1/localSearch';
		// build service url
		serviceURL = services[searchType].concat(query);
		
		trace('serviceURL: ' + serviceURL);
		return serviceURL;
	}
}