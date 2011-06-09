//****************************************************************************
// Yahoo Trace Class
// 
// Based on the T class created by: Igor Dimitrijevic
//****************************************************************************
class org.caleb.util.TraceUtil
{
	public static var co_mc:MovieClip;
	public static var co_tf:TextField;
	public static var html:Boolean;
	public static var getString:Function;
	public static var co_format:TextFormat;
	public static var RECURSION_DEPTH:Number = 20;
	public static var INSERT:Boolean = true;
	
	public static var TAB:String = "\t";
	public static var PREFIX:String = "";
	
	static var formats:Object={
		number:'<FONT COLOR="#FF0000"><B>*</B></FONT>',
		boolean:'<FONT COLOR="#0000FF"><B>*</B></FONT>',
		string:'"<FONT COLOR="#009900">*</FONT>"'
	}
	static function tr() {trace(arguments.join(" : "))}

	static function traceObject(o:Object):Void
	{
		getString = getPlainString;
		
		var z={};
		z[":"]=o;
		trace(getStringFromObject(z));
	}
	static function co(o:Object, notHTML:Boolean)
	{
		html = !notHTML;
		getString = (html)? getHTMLString : getPlainString;
		if (!co_mc) createConsole();
		else co_tf.html = html;
		
		var cmenu = new ContextMenu();
		cmenu.hideBuiltInItems();
		co_tf.menu = cmenu;
		cmenu.customItems.push(new ContextMenuItem("Remove TConsole", removeConsole));
		
		var z={};
		z[":"]=o;
		co_tf.htmlText = getStringFromObject(z);
		co_tf.setTextFormat(co_format);
	}
	public static function getStringFromObject( o:Object, loopNo:Number, prevType:String ):String
	{
		if (loopNo == undefined) loopNo = 0;
		var s = "";
		var str;
		
		for( var i in o) 
		{
			str = propToString(i, o[i], loopNo, prevType);
			s += str.pre;
			if (str.type == "xml") continue;
			
			if( typeof o[i] == "object" || typeof o[i] == "movieclip") {
				
				if (loopNo > RECURSION_DEPTH) continue;
				s += getStringFromObject( o[i], loopNo + 1, str.type ) + str.suf;
				
			}
			
		}
		return s;
	}
	static function propToString(name, value, loopNo:Number, prevType:String):Object
	{
		if (prevType == "array") name = "[" + name + "]";
		
		var type = typeof value;
		
		if (value instanceof Array) 
		{
			type = "array";
		}
		if (value instanceof XML) type = "xml";
		var props = getString(loopNo, name, value, type)
		
		return {
			pre: props.pre,
			suf: props.suf,
			type: type
		}
		
	}
	static function getHTMLString(loopNo, name, value, type):Object
	{
		var indent = "";
		var after = "";
		for (var i=0; i<loopNo; i++) indent += " ";
		
		if (value instanceof XML) {
			PREFIX = indent + "  ";
			out = indent + name + ":<B>XML</B><BR/>";
			out += '<FONT COLOR="#FF9900">' + xmlToEntities(xmlGetIndent(value)) + "</FONT><BR/>";
		} else {
		
			if (type == "object" || type == "movieclip") {
				var cName = (value.classType) ? value.classType : "Object";
				var out = indent + name + ":<B>" + cName+ "</B><BR/>";
				out += indent + "<B>{</B><BR/>";
				after = indent + '<B>}</B><BR/>';
			} else if (type == "array") {
				var out = indent + name + ":<B>Array</B><BR/>";
			} else if (type == "function") {
				var out = indent + name + ': <FONT COLOR="#0000FF">function</FONT><BR/>';
			} else {
				var out = indent + name + ": " + formats[type].split("*").join(value) + "<BR/>";
			}
		}
		
		return {
			pre: out,
			suf: after
		}
	}
	static function getPlainString(loopNo, name, value, type):Object
	{
		var indent = "";
		var after = "";
		var out;
		for (var i=0; i<loopNo; i++) indent += " \t ";
		
		if (value instanceof XML) {
			PREFIX = indent + "  ";
			out = indent + name + ":XML\n" + xmlGetIndent(value) + "\n";
		} else {
			
			if (type == "object" || type == "movieclip") {
				var cName = (value.classType)? value.classType : "Object";
				out = indent + name + ":" + cName+ "\n";
			} else if (type == "array") {
				out = indent + name + ":Array\n";
			} else if (type == "function") {
				out = indent + name + ': function\n';
			} else if (type == "string") {
				out = indent + name + ': "' + value + '"\n';
			} else {
				out = indent + name + ": " + value + "\n";
			}
		}
		
		return {
			pre: out,
			suf: after
		}
	}
	static function onKeyDown()
	{
		if (Key.isDown(Key.ESCAPE)) {
			removeConsole();
		}
	};

	static function createConsole()
	{
		co_mc = _level0.createEmptyMovieClip("$_T_mc", _level0.getNextHighestDepth());
		co_mc.createTextField("tf", 1, 0, 0, Stage.width/2, Stage.height/2);
		co_tf = co_mc.tf;
		co_mc._x = Stage.width/4;
		co_mc._y = Stage.height/4;
		co_tf.background = true;
		co_tf.border = true;
		co_tf.multiline = true;
		co_tf.selectable = false;
		if (html) co_tf.html = true;
		
		
		co_format = new TextFormat();
		co_format.font = "_typewriter";
		//co_format.size = 11;
		
		co_mc.onKeyDown = function()
		{
			if (Key.getCode() == Key.ESCAPE) {
				removeConsole();
			}
			if (Key.isDown(Key.CONTROL)) {
				if (Key.isDown(Key.INSERT)) {
					INSERT = !INSERT;
					co_tf.selectable = !co_tf.selectable;
					co_tf.borderColor = (INSERT)? 0x000000 : 0xFF0000;
				} else
				if (Key.isDown(Key.SPACE)) {
					if (co_tf.background) {
						co_tf.background = false;
					} else if (co_mc._visible) {
						co_mc._visible = false;
					} else {
						co_tf.background = true;
						co_mc._visible = true;
					}
				}
			}
			if (INSERT) {
				if (Key.isDown(Key.CONTROL)) {
					if (Key.isDown(Key.RIGHT)) {
						co_tf._width += 10;
					} else
					if (Key.isDown(Key.LEFT)) {
						co_tf._width -= 10;
					} else
					if (Key.isDown(Key.DOWN)) {
						co_tf._height += 10;
					} else
					if (Key.isDown(Key.UP)) {
						co_tf._height -= 10;
					}
				} else {
					
					if (Key.isDown(Key.RIGHT)) {
						co_tf._x += 10;
					} else
					if (Key.isDown(Key.LEFT)) {
						co_tf._x -= 10;
					} else
					if (Key.isDown(Key.DOWN)) {
						co_tf._y += 10;
					} else
					if (Key.isDown(Key.UP)) {
						co_tf._y -= 10;
					}
				}
			}
			
		}
		co_mc.onMouseDown = function()
		{
			if (INSERT && co_mc.hitTest(_xmouse, _ymouse)) {
				co_mc.startDrag();
			}
		}
		co_mc.onMouseUp = function()
		{
			if (INSERT) {
				co_mc.stopDrag();
			}
		}
		Key.addListener(co_mc);
		Mouse.addListener(co_mc);
	}
	static function removeConsole()
	{
		var l = getLowestAvailableDepth(_level0);
		co_mc.swapDepths(l)
		removeMovieClip(co_mc);
		co_mc = undefined;
	}
	static function getLowestAvailableDepth(t:MovieClip)
	{
		var mc,d;
		var ds=[];
		for (var i in t) {
			mc=t[i];
			if (typeof mc == "movieclip") {
				d = mc.getDepth();
				if (d > 0) ds.push(d);
			}
		}
		if (ds.length == 1) return ds[0];
		ds.sort();
		var i = 1;
		while (i == ds[i-1]) i++;
		return i;
	}
	static function xmlGetIndent(x:XMLNode, tab:String):String
	{
		var out;
		if (x.nodeType != 3)
		{
			if (x.nodeName != null) {
				
				out = "<" + x.nodeName;
				for (var v in x.attributes) {
					out += ' ' + v + '="' + x.attributes[v] + '"';
				}
				
				if (x.firstChild == null) {
					out += "/>";
				} else {
					out += ">\r" + PREFIX + TAB + tab + xmlGetIndent(x.firstChild, (tab + TAB));
					out += "\r" + PREFIX + tab + "</" + x.nodeName + ">";
				}
			} else {
				out = PREFIX + xmlGetIndent(x.firstChild, "");
			}
		} else {
			out = x.toString();
		}
		if (x.nextSibling != null) {
			out += "\r" + PREFIX + tab + xmlGetIndent(x.nextSibling, tab);
		}
		
		return out;
	}
	static function xmlToEntities(x:String):String
	{
		var ens = {};
		ens["<"] = "&lt;";
		ens[">"] = "&gt;";
		ens["&"] = "&amp;";
		ens["'"] = "&apos;";
		ens['"'] = "&quot;";
		x = x.toString();
		var l = x.length;
		var c;
		var out = "";
		for (var i = 0; i<l; i++) {
			c = x.charAt(i);
			if (ens[c]) out += ens[c];
			else out += c;
		}
		
		return out;
	}
}
