package ru.fcl.sdd.userdata.reputation 
{
    
    /**
     * ...
     * @author 
     */
    public interface IReputation 
    {
       function get countValue():int; 
       function set countValue(value:int):void;
       function get min_rep():int;
       function set min_rep(value:int):void;
       
    }
    
}