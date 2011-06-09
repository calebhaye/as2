import org.caleb.event.ObservableObject;
import org.caleb.event.Event;
import org.caleb.xml.SimpleXML;
import org.caleb.remoting.RemotingManager
import org.caleb.util.TraceUtil;
import org.caleb.util.StringUtil;

class org.caleb.generate.CodeGenerator extends ObservableObject
{
	public static var PARSE_XML:Boolean = true;
	public static var PARSE_PHP:Boolean = true;
	public static var PARSE_ACTIONSCRIPT:Boolean = true;
	public static var SAVE_FILES:Boolean = true;
	public static var SERVICE_SAVEFILE:String = 'org.caleb.io.FileManager';
	public static var SERVICE_GATEWAY:String = 'http://mig.media.yahoo.com/amfphp/gateway.php';
	public static var FILE_SAVE_WWWPATH = 'http://mig.media.yahoo.com/generated/';
	public static var FILE_SAVE_SERVICEPATH = '/home/y/share/htdocs/amfphp/services/generated/';
	public static var FILE_SAVE_BASEPATH = '/home/y/share/htdocs/generated/';
	public static var FILE_SAVE_XMLLIST = '/home/calebh/www/generate/generated_xml/';
	private static var PHP:String = 'php';
	private static var ACTIONSCRIPT:String = 'as';
	private var $xmlURL:String;
	private var $saveAttempts:Number;
	private var $xml:SimpleXML;
	private var $actionscript:String;
	private var $php:String;
	private var $objectPrefix:String;
	private var $objectPackage:String;
	private var $remotingManager:RemotingManager;
	private var $objects:Array;
	private var $savedObjects:Array;
	
	public function CodeGenerator()
	{
		this.setClassDescription('org.caleb.generate.CodeGenerator');
		trace('constructor invoked');
		this.$php = new String;
		this.$actionscript = new String;
		this.$objects = new Array;
		this.$saveAttempts = 0;
		this.$savedObjects = new Array;
		this.$xml = new SimpleXML;
		this.$xml.addEventObserver(this, 'onParseSuccess');
		this.addEventObserver(this, 'onObjectsReady');
	}
	public function init(url, objectPrefix:String):Void
	{
		this.$xmlURL = url;
		this.$objectPrefix = objectPrefix;
		this.$objectPackage = arguments[2];
		this.$xml.load(this.$xmlURL);
	}
	public function onParseSuccess(e:org.caleb.event.Event):Void
	{
		trace('onParseSuccess invoked');
		this.createNewObject();
		this.dispatchEvent(new org.caleb.event.Event('onObjectsReady'));
	}
	public function onObjectsReady(e:org.caleb.event.Event):Void
	{
		if(CodeGenerator.PARSE_ACTIONSCRIPT == true)
		{
			//trace("ACTIONSCRIPT:\n"+this.actionscript);
		}
		if(CodeGenerator.PARSE_PHP == true)
		{
			//trace("PHP:\n"+this.php);
		}
		if(CodeGenerator.PARSE_XML == true)
		{
			//trace("XML:\n"+this.xml);
		}
		if(CodeGenerator.SAVE_FILES == true)
		{
			this.$remotingManager = new RemotingManager(SERVICE_GATEWAY);
			this.$remotingManager.addService(SERVICE_SAVEFILE);
			this.saveFiles(FILE_SAVE_BASEPATH);
		}
	}
	private function createNewObject():Void
	{
		trace('createNewObject invoked');
		this.xml2Object(this.$xml);
		this.cleanObjects();		
		trace('created '+this.$objects.length + ' objects');
		if(CodeGenerator.PARSE_ACTIONSCRIPT == true)
		{
			this.buildActionScript();
		}
		if(CodeGenerator.PARSE_PHP == true)
		{
			this.buildPHP();
		}
	}
	private function cleanObjects():Void
	{
		var newObjectArray:Array = new Array;
		var objCount:Number = 0;
		for(var o in this.$objects)
		{
			var pushable:Boolean = false;
			var testObj = this.$objects[o]
			var childCount:Number = 0;
			for(var to in testObj.childTypes)
			{
				childCount++
				pushable = true;
			}
			if(pushable)
			{
				newObjectArray.push(this.$objects[o]);
			}
		}
		this.$objects = newObjectArray;
		// TraceUtil.traceObject(this.$objects);
	}
	private function xml2Object(x:XML):Void
	{
		// todo: iterate and check for attributes and create objects that way too
		for(var i:Number = 0; i < x.childNodes.length; i++)
		{
			var currentNode:XMLNode = x.childNodes[i];
			var objectName = StringUtil.capitalize(currentNode.nodeName)
			if(objectName == undefined)
			{
				return;
			}
			else
			{
				objectName = this.$objectPrefix + objectName;
			}
			this.$objects[objectName] = new Object;
			this.$objects[objectName].xml = x;
			this.$objects[objectName].name = objectName;

			//trace("current:\n"+ currentNode);
			
			if(currentNode.childNodes.length == 1)
			{
				// trace('type: ' + this.actionscriptGetType(currentNode.firstChild.nodeValue))
				this.$objects[objectName].type = this.actionscriptGetType(currentNode.firstChild.nodeValue, this.$objects[objectName].name);
				this.$objects[objectName].testValue = currentNode.firstChild.nodeValue;
			}
			else
			{
				this.$objects[objectName].type = 'Array';
			}
			//trace('');
			
			var objectProperties = new Array;
			
			for(var prop in currentNode.attributes)
			{
				var property = new Object;
				property.name = prop;
				property.type = this.actionscriptGetType(currentNode.attributes[prop], prop);
				property.testValue = currentNode.attributes[prop];
				objectProperties.push(property);
			}
			if(currentNode.childNodes.length > 1)
			{
				var foo = currentNode.childNodes;
				for(var i in foo) 
				{
					var property = new Object;
					property.name = foo[i].nodeName;
					property.type = this.actionscriptGetType(foo[i].nodeValue, foo[i].nodeName);
					property.testValue = foo[i].nodeValue;
					objectProperties.push(property);
					// trace(foo[i].nodeName + ' is a child of: ' + foo[i].parentNode.nodeName);
				}
			}

			if(objectProperties.length > 0)
			{
				this.$objects[objectName].properties = objectProperties;
			}

			this.$objects[objectName].childTypes = new Array;

			for(var attribute in currentNode.attributes)
			{
				// build child
				var newChild:Object = new Object;
				newChild.name = attribute;
				newChild.type = this.actionscriptGetType(currentNode.attributes[attribute], attribute);
				newChild.testValue = currentNode.attributes[attribute];
				this.$objects[objectName].childTypes[attribute] = newChild;
			}
			for(var child in currentNode.childNodes)
			{
				// build child
				var newChild:Object = new Object;
				if(currentNode.childNodes[child].nodeName != null)
				{
					newChild.name = currentNode.childNodes[child].nodeName;
					if(currentNode.childNodes[child].childNodes.length == 1)
					{
						if(currentNode.childNodes[0].nodeName == currentNode.childNodes[1].nodeName)
						{
							if(newChild.name.substr(newChild.name.length-1) != 's')
							{
								newChild.name += 's';
							}
							newChild.type = this.$objectPrefix;
							if(newChild.name.substr(newChild.name.length-1) == 's')
							{
								newChild.type += StringUtil.capitalize(StringUtil.shorten(newChild.name, 1));
							}
							else
							{
								newChild.type += StringUtil.capitalize(newChild.name);
							}
							newChild.type += 'Factory';
							newChild.testValue = "new " + newChild.name;
							newChild.isPrimativeObject = false;
						}
						else
						{
							if(currentNode.childNodes[child].firstChild.nodeValue == null)
							{
								newChild.type = this.$objectPrefix + StringUtil.capitalize(newChild.name);
								newChild.testValue = "new " + this.$objectPrefix + StringUtil.capitalize(newChild.name);
								newChild.isPrimativeObject = false;
							}
							else
							{
								newChild.type = this.actionscriptGetType(currentNode.childNodes[child].firstChild.nodeValue, newChild.name);
								newChild.testValue = currentNode.childNodes[child].firstChild.nodeValue;
							}
						}
					}
					else if(currentNode.childNodes[child].childNodes.length == 0)
					{
						newChild.type = this.$objectPrefix + StringUtil.capitalize(newChild.name);
						newChild.testValue = "new " + this.$objectPrefix + StringUtil.capitalize(newChild.name);
						newChild.isPrimativeObject = false;
					}
					else
					{
						if(newChild.name.substr(newChild.name.length-1) != 's')
						{
							newChild.name += 's';
						}
						newChild.type = this.$objectPrefix;
						if(newChild.name.substr(newChild.name.length-1) == 's')
						{
							newChild.type += StringUtil.capitalize(StringUtil.shorten(newChild.name, 1));
						}
						else
						{
							newChild.type += StringUtil.capitalize(newChild.name);
						}
						newChild.type += 'Factory';
						newChild.testValue = "new " + this.$objectPrefix + StringUtil.capitalize(newChild.name);
						newChild.isPrimativeObject = false;
					}
					this.$objects[objectName].childTypes[currentNode.childNodes[child].nodeName] = newChild;
					// recurse
					this.xml2Object(new XML(currentNode.childNodes[child].toString()));
				}
				else
				{
					newChild.name = currentNode.nodeName;
					newChild.type = actionscriptGetType(currentNode.firstChild.nodeValue, currentNode.nodeName);
					newChild.testValue = currentNode.firstChild.nodeValue;
					this.$objects[objectName].childTypes[newChild.name] = newChild;
				}
			}
		}
	}
	private function buildPHP():Void
	{
		for(var obj in this.$objects)
		{
			this.$php += this.phpPrintClass(obj);
		}
	}
	private function buildActionScript():Void
	{
		for(var obj in this.$objects)
		{
			this.$actionscript += this.actionscriptPrintClass(obj);
		}
	}
	private function saveFiles(basePath:String):Void
	{
		// save the xml location first
		this.saveFile(FILE_SAVE_XMLLIST, this.$objectPrefix.concat('_xml_location.txt').toLowerCase(), this.$xmlURL);
		for(var obj in this.$objects)
		{
			//FILE_SAVE_WWWPATH
			var xmlPath:String = basePath 
						+ 'xml'
						+ '/'
					    + StringUtil.replace(this.$objectPackage, '.', '/') 
						+ '/';
			var xmlFilename:String = this.$objects[obj].name + '.xml';
			var phpPath:String = basePath 
						+ 'src/' + PHP
						+ '/'
					    + StringUtil.replace(this.$objectPackage, '.', '/') 
						+ '/';
			var phpSourcePath:String = basePath 
						+ 'src/phps'
						+ '/'
					    + StringUtil.replace(this.$objectPackage, '.', '/') 
						+ '/';
			var phpFilename:String = this.$objects[obj].name + '.' + PHP;
			var phpTestPath:String = basePath 
						+ 'tests/php'
						+ '/'
					    + StringUtil.replace(this.$objectPackage, '.', '/') 
						+ '/';
			var phpTestFilename:String = this.$objects[obj].name + 'Test.' + PHP;

			var actionscriptTestPath:String = basePath 
						+ 'tests/' + ACTIONSCRIPT
						+ '/'
					    + StringUtil.replace(this.$objectPackage, '.', '/') 
						+ '/';
			var actionscriptTestFilename:String = this.$objects[obj].name + 'Test.' + ACTIONSCRIPT;
			var actionscriptPath:String = basePath 
						+ 'src/' + ACTIONSCRIPT
						+ '/'
					    + StringUtil.replace(this.$objectPackage, '.', '/') 
						+ '/';
			var actionscriptFilename:String = this.$objects[obj].name + '.' + ACTIONSCRIPT;

			this.$objects[obj].phpURL = phpPath + phpFilename;
			this.$objects[obj].phpSourceURL = phpSourcePath + phpFilename;
			this.$objects[obj].actionscriptURL = actionscriptPath + actionscriptFilename;
			
			this.saveFile(xmlPath, xmlFilename, '<?xml version="1.0" encoding="UTF-8" ?>' + this.$objects[obj].xml);
			this.saveFile(phpPath, phpFilename, this.phpPrintClass(obj));
			this.saveFile(FILE_SAVE_SERVICEPATH, phpTestFilename, this.phpPrintClass(obj, true));
			this.saveFile(phpSourcePath, phpFilename + 's', this.phpPrintClass(obj));
			this.saveFile(actionscriptPath, actionscriptFilename, this.actionscriptPrintClass(obj));			
			this.saveFile(actionscriptTestPath, actionscriptTestFilename, this.actionscriptPrintClass(obj, true));			
			this.saveFile(phpTestPath, phpTestFilename, this.phpPrintClass(obj, true));
		}
	}
	private function actionscriptPrintClass(obj:String, test:Boolean):String
	{
		var objectString:String = new String;
		var childCount:Number = 0;
		for(var child in this.$objects[obj].childTypes)
		{
			childCount++;
		}
		if(childCount > 0)
		{
			if(test == true)
			{
				// open class
				objectString += actionscriptOpenMethod(this.$objects[obj].name.concat('Test'), this.$objectPackage);
			}
			else
			{
				// open class
				objectString += actionscriptOpenMethod(this.$objects[obj].name, this.$objectPackage);
			}
			
			// add variables
			for(var child in this.$objects[obj].childTypes)
			{
				objectString += actionscriptClassVariable(this.$objects[obj].childTypes[child].name, this.$objects[obj].childTypes[child].type);
			}
			
			// add line
			objectString += "\n";
			
			// add constructor
			objectString += actionscriptSoleConstructor(this.$objects[obj], test);
			
			// add accessors
			for(var child in this.$objects[obj].childTypes)
			{
				objectString += actionscriptAccessor(this.$objects[obj].childTypes[child].name,
														   false,
														   this.$objects[obj].childTypes[child].type)
			}
			// close class
			objectString += actionscriptCloseMethod();
		}
		return objectString;
	}
	private function actionscriptGetType(val:String, name):String
	{
		var t:String;
		if(isNaN(val))
		{
			if(val == 'true' || val == 'false')
			{
				t = 'Boolean';
			}
			else
			{
				t = 'String';
			}
		}
		else
		{
			if((val == '1' || val == '0') && (StringUtil.startswith(name, 'is') == true || StringUtil.startswith(name, '$is') == true))
			{
				t = 'Boolean';
			}
			else
			{
				t = 'Number';
			}
		}
		//trace('actionscriptGetType thinks that "' + val + '" is a ' + t + '('+name+')');		
		return t;
	}
	private function actionscriptComment(txt:String):String
	{
		var returnString:String = new String;
		returnString += "\n\t/*";
		
		if(returnString.indexOf("\n") != -1)
		{
			var lines:Array = txt.split("\n");
			for(var line in lines)
			{
				returnString += "\n\t * " + lines[line];
			}
		}
		else
		{
			returnString += txt;
		}

		returnString += " var\n\t */";
		
		return returnString;
	}
	private function actionscriptAccessor(variableName:String, isPrivate:Boolean, type:String):String
	{
		var returnString:String = new String;
		
		returnString += actionscriptComment('Accessor for private $' + variableName);
		returnString += "\n\t";
		if(isPrivate == true)
		{
			returnString += 'private';
		}
		else
		{
			returnString += 'public';
		}
		returnString += " function get ";
		returnString += variableName;
		returnString += '()';
		if(type != undefined)
		{
			returnString += ':';
			returnString += type;
		}
		returnString += "\n\t{\n\t\t";
		returnString += 'return this.$';
		returnString += variableName;
		returnString += ";\n\t}";
		
		return returnString;
	}
	private function actionscriptSoleConstructor(obj:Object, test:Boolean):String
	{
		var returnString = new String;
		returnString += "\n\t/*\n\t * Sole Constructor \n\t */";
		returnString += "\n\tpublic function ";
		returnString += obj.name;
		returnString += '()';
		returnString += "\n\t{\n\t\t";
		returnString += "trace('constructor invoked');\n";
		if(test == true)
		{
			for(var child in obj.childTypes)
			{
				returnString += "\t\tthis.$";
				returnString += obj.childTypes[child].name;
				returnString += ' = ';
				if(obj.childTypes[child].isPrimativeObject != false)
				{
					returnString += '"'; 
				}
				returnString += obj.childTypes[child].testValue;
				if(obj.childTypes[child].isPrimativeObject != false)
				{
					returnString += '"';
				}
				returnString += ";\n";
			}
		}
		returnString += "\n\t}\n";
		
		return returnString;
	}
	private function actionscriptClassVariable(variableName:String, type:String):String
	{
		var returnString:String = new String;
		returnString += "\n\tprivate var $";
		returnString += variableName;
		if(type != undefined)
		{
			returnString += ':';
			returnString += type;
		}
		returnString += ';';

		return returnString;
	}
	private function actionscriptCloseMethod(name:String):String
	{
		return "\n}\n\n";
	}
	private function actionscriptOpenMethod(name:String, package:String):String
	{
		var returnString:String = new String;
		returnString += "import org.caleb.core.CoreObject;\n";
		returnString += 'import ' + package + ".*;\n\n";
		returnString += 'class ';
		if(package != undefined)
		{
			returnString += package + '.';
		}
		returnString += name;
		returnString += ' extends CoreObject';
		returnString += "\n{";
		
		return returnString;
	}
	private function phpPrintClass(obj:String, test:Boolean):String
	{
		var objectString:String = new String;
		var childCount:Number = 0;
		for(var child in this.$objects[obj].childTypes)
		{
			childCount++;
		}
		if(childCount > 0)
		{
			objectString += "<?php\n";
			for(var child in this.$objects[obj].childTypes)
			{
				var includeString:String = new String;
				var candidateObject:Object = this.$objects[obj].childTypes[child];
				includeString += 'include_once("' + FILE_SAVE_SERVICEPATH + this.$objectPrefix;
				if(candidateObject.isPrimativeObject == false)
				{
					if(candidateObject.name.substr(candidateObject.name.length-1) == 's')
					{
						includeString += StringUtil.capitalize(StringUtil.shorten(candidateObject.name, 1));
					}
					else
					{
						includeString += StringUtil.capitalize(candidateObject.name);
					}
					if(test == true)
					{
						includeString += "Test";
					}
					includeString += ".php\");\n";
					//trace('includeString: ' + includeString);
					objectString += includeString;
				}
			}
			if(test == true)
			{
				// open class
				objectString += phpOpenMethod(this.$objects[obj].name.concat('Test'), this.$objectPackage);
			}
			else
			{
				// open class
				objectString += phpOpenMethod(this.$objects[obj].name, this.$objectPackage);
			}
			// add variables
			for(var child in this.$objects[obj].childTypes)
			{
				objectString += phpClassVariable(this.$objects[obj].childTypes[child].name, this.$objects[obj].childTypes[child].type);
			}

			// add line
			objectString += "\n";
			
			// add constructor
			objectString += phpSoleConstructor(this.$objects[obj].name, this.$objects[obj].childTypes, test);
			
			// add accessors
			for(var child in this.$objects[obj].childTypes)
			{
				objectString += phpAccessor(this.$objects[obj].childTypes[child].name,
														   false,
														   this.$objects[obj].childTypes[child].type)
			}
			// close class
			objectString += phpCloseMethod();
			objectString += "\n?>\n\n";
		}
		return objectString;
	}
	private function phpAMFMethodTable(variables:Array):String
	{
		var returnString:String = new String;
		returnString += "$this->methodTable = array(";
		var variableCount:Number = 0;
		for(var v in variables)
		{
			variableCount++;
		}
		var i:Number = 0;
		for(var v in variables)
		{
			if(i > 0)
			{
				returnString += "\n\t\t\t\t\t   ";
			}
			returnString += '"get' + StringUtil.capitalize(variables[v].name) + '" => array(';
			returnString += '"description" => "Accessor for ' + variables[v].name + ' var" ,';
			returnString += '"access" => "remote")';			
			if(i+1 < variableCount)
			{
				returnString += ",";
			}
			i++;
		}
		returnString += ");\n\n";
		return returnString;
	}
	private function phpAccessor(variableName:String, isPrivate:Boolean, type:String):String
	{
		var returnString:String = new String;
		
		returnString += actionscriptComment('Accessor for private $' + variableName);
		returnString += "\n\t";
		/*
		if(isPrivate == true)
		{
			returnString += 'private';
		}
		else
		{
			returnString += 'public';
		}
		*/
		returnString += "function get";
		returnString += StringUtil.capitalize(variableName);
		returnString += '()';
		/*
		if(type != undefined)
		{
			returnString += ':';
			returnString += type;
		}
		*/
		returnString += "\n\t{\n\t\t";
		returnString += 'return $this->';
		returnString += variableName;
		returnString += ";\n\t}";
		
		return returnString;
	}
	private function phpClassVariable(variableName:String, type:String):String
	{
		var returnString:String = new String;
		/*
		returnString += "\n\t$";
		returnString += variableName;
		if(type != undefined)
		{
			returnString += ':';
			returnString += type;
		}
		returnString += ';';
		*/

		return returnString;
	}
	private function phpCloseMethod(name:String):String
	{
		var returnString:String = new String;
		returnString += "\n}";
		
		return returnString;
	}
	private function phpOpenMethod(name:String, package:String):String
	{
		var returnString:String = new String;
		returnString += 'class ';
		/*
		if(package != undefined)
		{
			returnString += package + '.';
		}
		*/
		returnString += name;
		//returnString += ' extends CoreObject';
		returnString += "\n{";
		
		return returnString;
	}
	private function phpSoleConstructor(variableName:String, children:Array, test:Boolean):String
	{
		var returnString = new String;
		returnString += "\n\t/*\n\t * Sole Constructor \n\t */";
		returnString += "\n\tfunction __construct";
		returnString += '()';
		returnString += "\n\t{\n\t\t";
		returnString += phpAMFMethodTable(children);
		if(test == true)
		{
			for(var child in children)
			{
				returnString += "\t\t$this->";
				returnString += children[child].name;
				returnString += ' = ';
				if(children[child].isPrimativeObject != false)
				{
					returnString += '"'; 
				}
				returnString += children[child].testValue;
				if(children[child].isPrimativeObject != false)
				{
					returnString += '"';
				}
				else
				{
					if(test == true)
					{
						if(returnString.substr(returnString.length-1) == 's')
						{
							returnString = StringUtil.shorten(returnString, 1);
						}
						returnString += 'Test';
					}
				}
				returnString += ";\n";
			}
		}
		returnString += "\n\t}\n";
		
		return returnString;
	}
	private function saveFile(path:String, filename:String, data:String):Void
	{
		this.$saveAttempts++;
		var fileSaveService = this.$remotingManager.getService(SERVICE_SAVEFILE);
		fileSaveService.write(this, path, filename, data);
	}
	public function onResult(objectDetails:Object):Void
	{
		if(objectDetails['saved'] == true)
		{
			this.$savedObjects.push(objectDetails);
	
			var e:Event = new Event('onObjectSaved');
			e.addArgument('object', objectDetails);
			this.dispatchEvent(e);
	
			if(this.$savedObjects.length == this.$saveAttempts)
			{
				this.dispatchEvent(new Event('onAllObjectsSaved'));
			}
		}
		else
		{
			trace('[Fatal Error!] Event Details Follow:');
			//TraceUtil.traceObject(objectDetails);
		}
	}
	public function get php():String
	{
		return this.$php;
	}
	public function get actionscript():String
	{
		return this.$actionscript;
	}
	public function get xml():SimpleXML
	{
		return this.$xml;
	}
	public function get xmlURL():String
	{
		return this.$xmlURL;
	}
	public function get objects():Array
	{
		return this.$objects;
	}
	public function get objectPackage():String
	{
		return this.$objectPackage;
	}
}