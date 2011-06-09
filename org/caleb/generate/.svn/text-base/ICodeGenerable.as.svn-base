import org.caleb.core.CoreInterface;

/**
 * Code Generation Interface
 * Provides methods for printing Strings that represent simple language permutations
 * 
 * @author  calebh
 * @version 1.0
 * @see     CoreInterface	
 * @since   
 */
interface org.caleb.generate.ICodeGenerable extends CoreInterface
{
	/**
	 * @return Lower case String identifying the language being generated
	 */
	public function getLanguage():String;
	/**
	 * 
	 * This is the method that invokes each of the other methods.
	 * @param   name 
	 * @return  The entire class String
	 */
	public function printClass(name:String):String
	/**
	 * 
	 * @usage   ICodeGenerable.printAccessor('foo', 'String');
	 * @param   name   String naming the variable being accessed
	 * @param   type   String representing the type of object being accessed
	 * @return  A String that contains the code for 
	 * 			a 'getter' method for the language being generated
	 */
	public function printAccessor(name:String, type:String):String
	/**
	 * @usage   ICodeGenerable.printMutator('foo', 'String');
	 * @param   name   String naming the variable being mutated
	 * @param   type   String representing the type of object being mutated
	 * @return  A String that contains the code for 
	 * 			a 'setter' method for the language being generated
	 */
	public function printMutator(name:String, type:String):String
	/**
	 * @usage   ICodeGenerable.printMutator('foo', 'String');
	 * @param   name   String naming the variable being mutated
	 * @param   type   String representing the type of object being mutated
	 * @return  A String that contains the code for 
	 */
	public function printClassVariable(name:String, type:String):String
	/**
	 * @usage   ICodeGenerable.printMutator('foo', 'String');
	 * @param   name   String naming the variable being mutated
	 * @param   type   String representing the type of object being mutated
	 * @return  A String that contains the code for 
	 */
	public function printCloseMethod(name:String):String
	/**
	 * @usage   ICodeGenerable.printOpenMethod('foo', 'String');
	 * @param   name   String naming the object to be generated
	 * @param   package   String representing the package of the object to be generated
	 * @return  A String that contains the code for 
	 * 			a opening a method on the language being generated
	 */
	public function printOpenMethod(name:String, package:String):String
	/**
	 * @usage   ICodeGenerable.printSoleConstructor('foo', myObj.childTypes);
	 * @param   name   String naming the class being generated
	 * @param   children Associative Array of child objects to be generated.
	 *  	    Keys are Strings representing the name of the object to be generated
	 * 			Values are the object to be generated
	 * @return  A String that contains the code for 
	 * 			a constructor method for the language being generated
	 */
	public function printSoleConstructor(name:String, children:Array):String
}