package ru.fcl.sdd.userdata.experience 
{
    
    /**
     * ...
     * @author atuzov
     */
    public interface IExperience 
    {
        function get count():int;
        function set count(value:int):void;
        function get nextLevel():int ;
        function set nextLevel(value:int):void;
        function get levelNumer():int;
        function set levelNumer(value:int):void;
    }
    
}