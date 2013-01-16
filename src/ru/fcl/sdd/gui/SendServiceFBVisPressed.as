package ru.fcl.sdd.gui 
{
    import org.robotlegs.mvcs.Command;
    import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.services.shared.FriendBarVisModel;
    import ru.fcl.sdd.services.shared.ISharedGameDataService;
 
    
    /**
     * <p>
     * Description
     * 
     * Command:
     * • Commands do <b>not</b> listen for framework events, outside of the event that triggers them, which is available for injection
     * • Commands are executed in response to framework events
     * • Commands are stateless, they execute and die, performing a single unit of work
     * • Commands perform work on Service and Model classes, and occasionally Mediators
     * • Commands receive data from the events that trigger them
     * • Commands dispatch framework events
     * </p>
     *
     * @class SendServiceFBVisPressed
     * @author atuzov
     * @date 01.16.2013
     * @version 1.0
     * @see
     */
    
    public class SendServiceFBVisPressed extends SignalCommand 
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