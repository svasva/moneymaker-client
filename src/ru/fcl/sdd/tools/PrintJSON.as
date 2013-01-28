package ru.fcl.sdd.tools
{
    
    /**
     * ...
     * @author atuzov
     */
    public class PrintJSON
    {
        
       
        public static function o(oObj:Object, sPrefix:String = ""):void
        {
            
            sPrefix == "" ? sPrefix = "---" : sPrefix += "---";              
            for (var i:* in oObj)  
            {                  
                trace(sPrefix, i + " : " + oObj[i], "  ");                
                if (typeof( oObj[i] ) == "object") o(oObj[i], sPrefix); // around we go again          
            }  
        
        }
        public static function deepTrace( obj : * , level : int = 0 ) : void
        {
            var tabs : String = "";
            for ( var i : int = 0 ; i < level ; i++, tabs += "\t" );
        
            for ( var prop : String in obj ){
                trace( tabs + "[" + prop + "] -> " + obj[ prop ] );
                deepTrace( obj[ prop ], level + 1 );
            }
        }
    }



}