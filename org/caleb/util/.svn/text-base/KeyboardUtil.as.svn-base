class org.caleb.util.KeyboardUtil   
{
	public static function get keyboardValueMap():Array
	{
		var keyboardButtonMap = new Array;
		// special characters
		keyboardButtonMap[191] = "/";
		// buttons
		keyboardButtonMap[-100] = "MoreInfo";
		keyboardButtonMap[8] = "Backspace";
		keyboardButtonMap[9] = "Tab";
		keyboardButtonMap[13] = "Enter";
		keyboardButtonMap[16] = "Shift";
		keyboardButtonMap[19] = "Pause";
		keyboardButtonMap[20] = "CapsLock";
		keyboardButtonMap[27] = "Clear";
		keyboardButtonMap[32] = "Space";
		keyboardButtonMap[33] = "PageUp";
		keyboardButtonMap[34] = "PageDown";
		keyboardButtonMap[37] = "Left";
		keyboardButtonMap[38] = "Up";
		keyboardButtonMap[39] = "Right";
		keyboardButtonMap[40] = "Down";
		keyboardButtonMap[110] = "Delete";
		keyboardButtonMap[166] = "Back";
		keyboardButtonMap[176] = "Skip";
		keyboardButtonMap[177] = "Replay";
		keyboardButtonMap[178] = "Stop";
		keyboardButtonMap[250] = "Play";
		// digits
		keyboardButtonMap[48] = 0;
		keyboardButtonMap[49] = 1;
		keyboardButtonMap[50] = 2;
		keyboardButtonMap[51] = 3;
		keyboardButtonMap[52] = 4;
		keyboardButtonMap[53] = 5;
		keyboardButtonMap[54] = 6;
		keyboardButtonMap[55] = 7;
		keyboardButtonMap[56] = 8;
		keyboardButtonMap[57] = 9;
		// characters
		keyboardButtonMap[65] = 'A';
		keyboardButtonMap[66] = 'B';
		keyboardButtonMap[67] = 'C';
		keyboardButtonMap[68] = 'D';
		keyboardButtonMap[69] = 'E';
		keyboardButtonMap[70] = 'F';
		keyboardButtonMap[71] = 'G';
		keyboardButtonMap[72] = 'H';
		keyboardButtonMap[73] = 'I';
		keyboardButtonMap[74] = 'J';
		keyboardButtonMap[75] = 'K';
		keyboardButtonMap[76] = 'L';
		keyboardButtonMap[77] = 'M';
		keyboardButtonMap[78] = 'N';
		keyboardButtonMap[79] = 'O';
		keyboardButtonMap[80] = 'P';
		keyboardButtonMap[81] = 'Q';
		keyboardButtonMap[82] = 'R';
		keyboardButtonMap[83] = 'S';
		keyboardButtonMap[84] = 'T';
		keyboardButtonMap[85] = 'U';
		keyboardButtonMap[86] = 'V';
		keyboardButtonMap[87] = 'W';
		keyboardButtonMap[88] = 'X';
		keyboardButtonMap[89] = 'Y';
		keyboardButtonMap[90] = 'Z';
		
		return keyboardButtonMap
	}
	
	public static function addKeyListener(target:MovieClip)
	{
		var e:org.caleb.event.Event = new org.caleb.event.Event;
		var keyListener:Object = Object;
		org.caleb.decorator.Observer.makeObservable(keyListener);
		keyListener.addEventObserver(target, 'onKeyDown');
		keyListener.addEventObserver(target, 'onKeyUp');
		keyListener.onKeyDown = function() 
		{
			//trace(Key.getCode())
			e.setType('onKeyDown');
			e.addArgument('key', Key.getCode());
			e.addArgument('ascii', Key.getAscii());
			e.addArgument('value', KeyboardUtil.keyboardValueMap[Key.getCode()]);
			this.dispatchEvent(e)
		};
		keyListener.onKeyUp = function() 
		{
			e.setType('onKeyUp');
			e.addArgument('key', Key.getCode());
			e.addArgument('ascii', Key.getAscii());
			e.addArgument('value', KeyboardUtil.keyboardValueMap[Key.getCode()]);
			this.dispatchEvent(e)
		};
		Key.addListener(keyListener);
	}
}