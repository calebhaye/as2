import org.caleb.movieclip.ObservableMovieClip;
import org.caleb.event.Event
/**
 * Provides paging capabilities for collections
 * @see     CoreMovieClip	
 */
class org.caleb.paginator.Paginator extends ObservableMovieClip
{
	static var SymbolName:String = '__Packages.org.caleb.components.paginator.Paginator';
	static var SymbolLinked = Object.registerClass(SymbolName, Paginator);
	
	public static var MENU_INSTANCE:String = 'pageMenuItem' 
	public static var RESULTS_PER_PAGE:Number = 10; 
	private var $resultsTotal:Number;
	private var $limit:Number;
	private var $offset:Number;
	private var $previousOffset:Number;
	private var $nextOffset:Number;
	private var $pages:Number;
	private var $locked:Boolean;
	private var $maxPages:Number;
	private var $currentPage:Number;
	private var $view:MovieClip;
	
	/**
	 * Sole Constructor
	 */
	public function Paginator()
	{
		this.setClassDescription('org.caleb.paginator.Paginator')
		//this.trace('constructor invoked')
		this.$limit = 10; // rows to return
		this.$maxPages = 5;
	}
	private function setCurrentPage(arg:Number):Void
	{
		var e = new Event('onPageChange');
		e.addArgument('previousPage', this.$currentPage)
		this.$currentPage = arg;
		e.addArgument('currentPage', this.$currentPage)
		this.dispatchEvent(e);
	}
	/**
	 * Initialize the pagination display
	 * 
	 * @param   total         total number of pages
	 * @param   limit         number of results to display per page
	 * @param   linkageId     linkage id of each list item
	 * @param   startPosition start position
	 * @param   maxPages      maximum number of pages
	 * @param   context       context object
	 */
	public function init(total:Number, limit:Number, linkageId:String, startPosition:Number, maxPages, context):Void
	{
		if(this.$locked != true)
		{
			/*
			trace('init invoked');
			trace('total: ' + total);
			trace('limit: ' + limit);
			trace('startPosition: ' + startPosition);
			trace('maxPages: ' + maxPages);
			trace('context: ' + context);
			*/
			this.$view.removeMovieClip();
			this.$view = this.createEmptyMovieClip('$view', this.getNextHighestDepth());
			this.$resultsTotal = total;
			this.$limit = limit;
			this.setCurrentPage(Number((((startPosition * limit)/limit - 1) / limit) + 1));
			this.$maxPages = maxPages;
			if (this.$offset == undefined || this.$offset < 1) 
			{
				this.$offset = 1;
			}
			
			if (this.$offset != 1) 
			{ 
				this.$previousOffset = this.$offset - this.$limit;
			}
			
			// calculate number of pages needing links
			this.$pages = Math.ceil(this.$resultsTotal / this.$limit);
					
			var i = 1;
			var xOffset = 0;
			var item:MovieClip;
			if(this.$pages > 1)
			{
				item = this.$view.attachMovie(linkageId,'prev', this.$view.getNextHighestDepth());
				item.name = 'PREV';
				item.txt._visible = false;
				item.arrowRight._visible = false;
				//
				item._x = xOffset;
				xOffset += item._width;
				if(startPosition == 1)
				{
					item._alpha = 35;
					item.useHandCursor = false;
					item.onRelease = undefined;
				}
				else
				{
					item._alpha = 100;
					item.onRelease = function()
					{
						context.previous(context);
					}
				}
			}
			var $tempPageLength = this.$pages;
			while($tempPageLength--)
			{
				// loop thru and add links
				//this.trace('adding page: ' + i);
				item = this.$view.attachMovie(linkageId,linkageId+i, this.$view.getNextHighestDepth());
				item.arrowLeft._visible = false;
				item.arrowRight._visible = false;
				//
				item._x = xOffset;
				xOffset += item._width;
				//
				item.name = i;
				item.page = i;
				item.onRelease = function()
				{
					context.gotoPage(context, this.page);
				} 
				
				//this.trace( Number((((startPosition * limit)/limit - 1) / limit) + 1) +' == '+i)
				if(Number((((startPosition * limit)/limit - 1) / limit) + 1) == i)
				{
					item.gotoAndStop('active');
					item.onRelease = undefined;
				}
				else
				{
					item.gotoAndStop('inactive')
				}
				if(i >= this.$maxPages)
				{
					break;
				}
				i++;
			}
			if(this.$pages > 1)
			{
				item = this.$view.attachMovie(linkageId,'next', this.$view.getNextHighestDepth());
				item.name = 'NEXT';
				item.txt._visible = false;
				item.arrowLeft._visible = false;
				//
				item._x = xOffset;
				xOffset += item._width;
				if((total - startPosition) <= limit || ((maxPages*limit)-startPosition) <= limit)
				{
					item._alpha = 35;
					item.useHandCursor = false;
					item.onRelease = undefined;
				}
				else
				{
					item._alpha = 100;
					item.onRelease = function()
					{
						context.next(context);
					}
				}
			}
			
			// check to see if last page
			if (!((this.$offset/this.$limit) == $pages) && this.$pages != 1) 
			{
				// not last page so give NEXT link
				this.$nextOffset = this.$offset + this.$limit;
			}
		}	
	}
	public function next(context:MovieClip):Void
	{
		//this.trace('next invoked');
	}
	public function previous(context:MovieClip):Void
	{
		//this.trace('previous invoked');
	}
	public function gotoPage(context:MovieClip, page:Number):Void
	{
		//this.trace('gotoPage invoked');
	}
	/**
	 * Returns the Number of the current page
	 * @return  Number
	 */
	public function get currentPage():Number
	{
		return this.$currentPage;
	}
	/**
	 * Retuns the total number of pages
	 */
	public function get pages():Number
	{
		return this.$pages;
	}
	
	public function get locked():Boolean
	{
		return this.$locked
	}
	public function set locked(arg:Boolean):Void
	{
		this.$locked = arg
	}
}