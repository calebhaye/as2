class org.caleb.util.ValidationUtil
{
	// Complete email validation
	
	
	public static function isValidEmail(email:String):Boolean
	{
        var xES:String = email.toLowerCase();
        var xVE:Boolean = true;
        var xA:Number = xES.indexOf("@");
        var xB:String = xES.substring(0,xA);
        var xD:Number =xES.length-1;
        var xE:Number =xES.lastIndexOf(".");
        var xC:String = xES.substring(xA+1,xE);
        var xF:Number =(xD)-(xE+1);
        
        if(xA==-1){xVE=false;}
        if(xA != xES.lastIndexOf("@")){xVE=false;}
        if(xCheckSUVC(xB)!=true){xVE=false;}
        if(xB.length<1){xVE=false;}
        if(xCheckSUVC(xC)!=true){xVE=false;}
        if(xC.length<2){xVE=false;}
        if(xCheckSUVC(xES.substr(xE+1,xD))!=true){xVE=false;}
        if(xF<1 || xF>3){xVE=false;}
	        
        return xVE;
	}
	private static function xCheckSUVC(xESS):Boolean
	{
	        var xV:Boolean = true;
	        var xUC:Array = new Array("!","Â£","$","%","^","&","*","_","+","=","?",":",";","'","	"," ",'"',"~","#","/");
	        for(var i:Number=0;i<=xUC.length-1;i++){
	                if(xESS.indexOf(xUC[i],0)!=-1){
	                        xV=false;
	                        break;
	                }
	        }
	        return xV;
	}
}