package ru.fcl.sdd.userdata.reputation 
{
	/**
     * ...
     * @author 
     */
    public class Reputation implements IReputation
    {
         
        private var _countValue:int;
        private var _min_rep:int;      
        
        [Inject]
        public var updater:UpdateReputationSignal;
        
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
            updater.dispatch();
        }
        
        public function get min_rep():int 
        {
            return _min_rep;
        }
        
        public function set min_rep(value:int):void 
        {
            _min_rep = value;
        }
        
    }

}