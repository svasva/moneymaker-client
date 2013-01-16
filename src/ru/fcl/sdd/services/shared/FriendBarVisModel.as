package ru.fcl.sdd.services.shared 
{
	/**
     * ...
     * @author atuzov
     */
    public class FriendBarVisModel 
    {
        [Inject]
        public var modelUpdater:FriendBarVisModelUpdatedSignal;
        
        private var _friendBarVisStatus:Boolean
        
        public function FriendBarVisModel() 
        {
          
        }
        
        public function get friendBarVisStatus():Boolean 
        {
            return _friendBarVisStatus;
        }
        
        public function set friendBarVisStatus(value:Boolean):void 
        {
            _friendBarVisStatus = value;
            modelUpdater.dispatch(_friendBarVisStatus);
        }
        
        
    }

}