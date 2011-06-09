class org.caleb.util.XMLUtil 
{
	static function findChildNode( node:XMLNode, childName:String )
	{
		if (node.hasChildNodes()) {
			for (var child:XMLNode = node.firstChild; child != null ; child = child.nextSibling) {
				if (child.localName == childName)
					return child;
			}
		}
		return null;
	}

    static function createTextElement( xml:XML, 
                                elementName:String, 
                                elementValue:String ) :XMLNode
    {
        if (!elementValue)
            return undefined;

        var node:XMLNode = xml.createElement( elementName );
        node.appendChild( xml.createTextNode( elementValue ) );
        return node;
    }

    
    // help for extracting a list of string or objects
    // listType.object == "String" , then listType.name == the element name for each
    // list element
    // otherwise listType.object == ClassName (and class has a fromXML method)
	static function extractList( node:XMLNode, listType:Object )
	{
        var result:Array = new Array();
        for (var child:XMLNode = node.firstChild; child ; child = child.nextSibling) {
            if (listType.object == "String") {
                if (child.localName == listType.name) {
                    var element = child.firstChild.nodeValue;
                    if (element)
                        result.push( element );
                } else {
                    trace("List element doesn't match expected: " + child.localName + "!=" + listType.name);
                }
            } else {
                // var obj = new listType.object();
                var destination = listType.object.fromXML( child );
                if (destination) {
                    result.push( destination );
                } else {
                    trace("Failed to parse: " + child );
                }
            }
        }
        return result;
    }

    // a helper function for parsing xml into a destination object
    // takes an object which maps xml element names to property names
    // and a property type
    // the xml is parsed and if matching elements are found, they're mapped
    // to properties on the object and converted if necessary
	static function extractValues( node:XMLNode, propertyMap:Object, destination:Object )
	{
        for (var child:XMLNode = node.firstChild; child ; child = child.nextSibling) {
            var mapping:Object = propertyMap[child.localName];
            if (mapping) {
                var value:Object;
                if (mapping.type == "List") {
                    value = extractList( child,
                                         mapping.listType);
                    destination[ mapping.target ] = value;
                } else if (mapping.type instanceof Function) {
                    value = mapping.type.fromXML( child );
                    if (!value) {
                        trace("failed to extract from: " + child + "-" + mapping);
                    }
                    destination[ mapping.target ] = value;
                } else {
                    var textValue:String = child.firstChild.nodeValue;
                    if (textValue) {
                        if (mapping.type == "Int") 
                            value = parseInt( textValue );
                        else if (mapping.type == "Float")
                            value = parseFloat( textValue );
                        else
                            value = textValue;
                        destination[ mapping.target ] = value;
                    } else {
                        trace("trying to extract: " + child.localName + " but failed to find child node - " + child);
                    }
                }
            } else {
                trace("Ignored: " + child.localName );
            }
		}
	}
	
}
