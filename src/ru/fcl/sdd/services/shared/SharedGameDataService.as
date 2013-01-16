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
        
        public static const FRIEND_BAR_VIS_STATUS:String = "FRIEND_BAR_VIS_STATUS";
        
        private var _friendBarVisState:Boolean;
         
        [PostConstruct]
        public function init():void 
        {         
            sharedSrv.getLocalObject();
        }
        
        public function get friendBarVisState():Boolean 
        {
            if (sharedSrv.getLocal(FRIEND_BAR_VIS_STATUS) == null)
            return true;
            
            _friendBarVisState = sharedSrv.getLocal(FRIEND_BAR_VIS_STATUS);
            return _friendBarVisState;
        }
        
        public function set friendBarVisState(value:Boolean):void 
        {
            _friendBarVisState = value;            
            sharedSrv.setLocal(FRIEND_BAR_VIS_STATUS,value);
            fbVisServUpdated.dispatch(_friendBarVisState);
            
        }
        
        
    }

}