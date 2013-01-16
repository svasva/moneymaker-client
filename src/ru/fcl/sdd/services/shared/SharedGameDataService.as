package ru.fcl.sdd.services.shared 
{
	
	
	/**
     * ...
     * @author atuzov
     */
    public class SharedGameDataService implements ISharedGameDataService
    {   
        [Inject]
        public var sharedSrv:ISharedService;
        
        [Inject]
        public var fbVisServUpdated:FriendBarVisServiceUpdatedSignal;
        
        private static const FRIEND_BAR_VIS_STATUS:String = "FRIEND_BAR_VIS_STATUS";
        
        private var _friendBarVisState:Boolean;
         
        [PostConstruct]
        public function init() 
        {
          trace("SharedGameDataService");
            sharedSrv.getLocalObject();
        }
        
        public function get friendBarVisState():Boolean 
        {
            return _friendBarVisState;
        }
        
        public function set friendBarVisState(value:Boolean):void 
        {
            _friendBarVisState = value;
            fbVisServUpdated.dispatch(_friendBarVisState);
            
        }
        
        
    }

}