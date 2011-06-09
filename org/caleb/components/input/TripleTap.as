import org.caleb.util.StringUtil;
import org.caleb.movieclip.CoreMovieClip;

class org.caleb.components.input.TripleTap extends CoreMovieClip
{
	public static var CURSOR:String = '|';
	public var blinking:Boolean;
	private var $text:String;
	private var $keyMap:Array;
	private var $tapCount:Number;
	private var $currentKey:String;
	private var $currentKeyCharacterIndex:Number;
	private var $passwordValue:String;
	private var $pendingText:String;
	private var $resetPassword:Boolean;
	private var $focused:Boolean;
	private var $password:Boolean;
	private var $capsLockKeyDown:Boolean;
	private var $shiftKeyDown:Boolean;
	// objects assumed to exist in fla
	public var input:TextField;
	
	public function TripleTap()
	{
		this.setClassDescription('org.caleb.components.input.TripleTap');
		this.setKeyMap();
		this.$capsLockKeyDown = false;
		this.$shiftKeyDown = false;
		this.$passwordValue = new String();
		this.$tapCount = this.$currentKeyCharacterIndex = 0;
		setInterval(this.doBlink, 500, this)
		this.input.onLoad = function()
		{
			this.selectable  = false;
		}
	}
	// read only
	public function get value():String
	{
		if(this.password != true)
		{
			return StringUtil.replace(this.input.text, TripleTap.CURSOR, '');
		}
		else
		{
			return StringUtil.replace(this.$passwordValue, TripleTap.CURSOR, '');
		}
		
		return undefined;
	}
	// read/write
	public function set text(s:String):Void
	{
		if(s != undefined)
		{
			this.input.text = s;
			this.$passwordValue = s;
		}
	}
	public function set caps(b:Boolean):Void
	{
		_root.helpCalebText = 'caps: '+ b;
		this.$shiftKeyDown= b;
	}
	public function get caps():Boolean
	{
		return this.$shiftKeyDown;
	}
	public function get text():String
	{
		return this.input.$text;
	}
	public function set password(b:Boolean):Void
	{
		this.$password = b;
	}
	public function get password():Boolean
	{
		return this.$password;
	}
	public function set focused(b:Boolean):Void
	{
		this.$focused = b;
		if(b == false)
		{
			if(this.$password == true)
			{
				this.maskPassword();
			}
			this.removeBlink(this);
		}
	}
	public function get focused():Boolean
	{
		return this.$focused;
	}
	// private methods
	private function doBlink(tt)
	{
		if(tt.focused == true)
		{
			if(tt.blinking == true)
			{
				tt.removeBlink(tt);
			}
			else
			{
				tt.blink(tt);
			}
		}
	}
	private function removeBlink(tt)
	{
		trace('remove blink')
		tt.input.text = StringUtil.replace(tt.input.text, TripleTap.CURSOR, "")
		tt.blinking = false;
	}
	private function blink(tt)
	{
		trace('blink')
		tt.input.text += TripleTap.CURSOR;
		tt.blinking = true;
	}
	private function getKey(char:String, tapCount:Number)
	{
		trace('[org.caleb.components.input.TripleTap] getKey invoked, w args: ' + char + ' , ' + tapCount)
		var keyValue = this.$keyMap[char][tapCount];
		if(this.$capsLockKeyDown == true)
		{
			if(this.$shiftKeyDown == true)
			{
				keyValue = keyValue.toLowerCase();
			}
			else
			{
				keyValue = keyValue.toUpperCase();
			}
		}
		else
		{
			if(this.$shiftKeyDown == true)
			{
				keyValue = keyValue.toUpperCase();
			}
			else
			{
//				keyValue = keyValue.toLowerCase();
			}
		}
		
		return keyValue;
	}
	private function setKeyMap()
	{
		this.$keyMap = new Array();
		this.$keyMap['0'] = new Array('0', ' ');
		this.$keyMap['1'] = new Array('1', '-', '_', '+', '=', ':', ';', ',', '.', '/', '?')
		this.$keyMap['2'] = new Array('2', 'A', 'B', 'C', 'a', 'b', 'c');
		this.$keyMap['3'] = new Array('3', 'D', 'E', 'F', 'd', 'e', 'f');
		this.$keyMap['4'] = new Array('4', 'G', 'H', 'I', 'g', 'h', 'i');
		this.$keyMap['5'] = new Array('5', 'J', 'K', 'L', 'j', 'k', 'l');
		this.$keyMap['6'] = new Array('6', 'M', 'N', 'O', 'm', 'n', 'o');
		this.$keyMap['7'] = new Array('7', 'P', 'Q', 'R', 'S', 'p', 'q', 'r', 's');
		this.$keyMap['8'] = new Array('8', 'T', 'U', 'V', 't', 'u', 'v');
		this.$keyMap['9'] = new Array('9', 'W', 'X', 'Y', 'Z', 'w', 'x', 'y', 'z');
		this.$keyMap['Space'] = new Array(' ');
		this.$keyMap['A'] = new Array('a');
		this.$keyMap['B'] = new Array('b');
		this.$keyMap['C'] = new Array('c');
		this.$keyMap['D'] = new Array('d');
		this.$keyMap['E'] = new Array('e');
		this.$keyMap['F'] = new Array('f');
		this.$keyMap['G'] = new Array('g');
		this.$keyMap['H'] = new Array('h');
		this.$keyMap['I'] = new Array('i');
		this.$keyMap['J'] = new Array('j');
		this.$keyMap['K'] = new Array('k');
		this.$keyMap['L'] = new Array('l');
		this.$keyMap['M'] = new Array('m');
		this.$keyMap['N'] = new Array('n');
		this.$keyMap['O'] = new Array('o');
		this.$keyMap['P'] = new Array('p');
		this.$keyMap['Q'] = new Array('q');
		this.$keyMap['R'] = new Array('r');
		this.$keyMap['S'] = new Array('s');
		this.$keyMap['T'] = new Array('t');
		this.$keyMap['U'] = new Array('u');
		this.$keyMap['V'] = new Array('v');
		this.$keyMap['W'] = new Array('w');
		this.$keyMap['X'] = new Array('x');
		this.$keyMap['Y'] = new Array('y');
		this.$keyMap['Z'] = new Array('z');
	}
	private function maskPassword()
	{
		var starCount = this.$passwordValue.length;
		var pwText = "";
		while(starCount--)
		{
			pwText += "*";
		}
		this.input.text = pwText;
	}
	// public methods
	public function backspace(key:String)
	{
		trace('[org.caleb.components.input.TripleTap] backspace invoked w arg: '+key)
		this.removeBlink(this);
		if(key == undefined || key == this.$currentKey)
		{
			this.input.text = this.input.text.slice(0, (this.input.text.length-1))
			if(this.$password == true)
			{
				this.$passwordValue = this.$passwordValue.slice(0, (this.$passwordValue.length-1))
			}
		}
	}
	
	public function addPermanentChar(char:String)
	{
		this.removeBlink(this);
		if(char != undefined)
		{
			this.input.text += char;
			if(this.$password == true)
			{
				this.$passwordValue += char;
				
				var starCount = this.$passwordValue.length - 1;
				var pwText = "";
				while(starCount--)
				{
					pwText += "*";
				}
				pwText += char;
				this.input.text = pwText;
			}
		}
		else
		{
			trace('[org.caleb.components.input.TripleTap] addPermanentChar: DID NOT PRINT, VALUE UNDEFINED')
		}
	}
	public function addPendingChar(key:String, idx:Number)
	{
		if(key != this.$currentKey)
		{
			if(this.getKey(key, 0) != undefined)
			{
				trace('NEW CURRENT KEY')
				// reset current key index
				this.$currentKeyCharacterIndex = 0;
				// update current key
				this.$currentKey = key;
				// a different key was pressed, 
				// so append the previous pending text
				this.addPermanentChar(this.getKey(this.$currentKey, this.$currentKeyCharacterIndex));
			}

		}
		else
		{
			trace('SAME KEY')
			// iterate through different letters for that key
			if(this.$currentKeyCharacterIndex >= (this.$keyMap[key].length - 1))
			{
				if(this.$keyMap[key].length != 1)
				{
					this.backspace(key);
				}
				this.$currentKeyCharacterIndex = 0;
			}
			// other wise, increment the currentKeyCharacterIndex
			else
			{
				// delete last temp char
				this.backspace(key);
				// increment index
				this.$currentKeyCharacterIndex++;
			}
			this.addPermanentChar(this.getKey(key, this.$currentKeyCharacterIndex));
	
			// update current key
			this.$currentKey = key;
		}
	}
	public function handleInput(key:String)
	{
		trace('')
		trace('[org.caleb.components.input.TripleTap] handleInput invoked, w arg: ' + key)
		switch(key.toUpperCase())
		{
			case "CAPSLOCK":				
			{
				this.$capsLockKeyDown = !this.$capsLockKeyDown;
			}
			break;
			case "SHIFT":
			{
				this.$shiftKeyDown = true;
			}
			break;
			case "CLEAR":
			{
				this.backspace(undefined);
			}
			break;
			case "BACKSPACE":
			{
				this.backspace(undefined);
			}
			break;
			case "DELETE":
			{
				this.backspace(undefined);
			}
			break;
			case "LEFT":
			{
				this.backspace(undefined);
			}
			break;
			case "RIGHT":
			{
				this.$currentKeyCharacterIndex = 0;
				// update current key
				this.$currentKey = undefined;
			}
			break;
			case "OK":
			{
				this.$currentKeyCharacterIndex = 0;
				// update current key
				this.$currentKey = undefined;
			}
			break;
			case "ENTER":
			{
				this.$currentKeyCharacterIndex = 0;
				// update current key
				this.$currentKey = undefined;
			}
			break;
			default:
			{
				this.addPendingChar(key, this.$tapCount)
			}
			break;
		}
	}
}