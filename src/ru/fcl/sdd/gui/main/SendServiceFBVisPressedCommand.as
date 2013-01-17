package ru.fcl.sdd.gui.main 
{
    import org.robotlegs.mvcs.Command;
    import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.services.shared.FriendBarVisModel;
    import ru.fcl.sdd.services.shared.ISharedGameDataService;
 
    
       
    public class SendServiceFBVisPressedCommand extends SignalCommand 
    {
        [Inject]
        public var fBVisModel:FriendBarVisModel;
        
        [Inject]
        public var sharedGameDataSrv:ISharedGameDataService;
        
        /*-----------------------------------------------------------------------------------------
        Public methods
        -------------------------------------------------------------------------------------------*/		
        override public function execute():void 
        {
            sharedGameDataSrv.friendBarVisState = !fBVisModel.friendBarVisStatus;
        }
        
        /*-----------------------------------------------------------------------------------------
        Private methods
        -------------------------------------------------------------------------------------------*/
        
        /*-----------------------------------------------------------------------------------------
        Event Handlers
        -------------------------------------------------------------------------------------------*/
    }
    
}