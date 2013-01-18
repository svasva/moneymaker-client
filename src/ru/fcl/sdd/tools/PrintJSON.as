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
    }



}