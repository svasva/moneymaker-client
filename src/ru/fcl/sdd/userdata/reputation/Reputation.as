package ru.fcl.sdd.userdata.reputation 
{
	/**
     * ...
     * @author atuzov
     */
    public class Reputation implements IReputation
    {
        private var _countValue:int;
        
        public function Reputation() 
        {
            
        }
        
        public function get countValue():int 
        {
            return _countValue;
        }
        
        public function set countValue(value:int):void 
        {
            _countValue = value;
        }
        
    }

}