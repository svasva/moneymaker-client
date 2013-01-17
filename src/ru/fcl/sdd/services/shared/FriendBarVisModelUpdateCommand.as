package ru.fcl.sdd.services.shared 
{
    import org.robotlegs.mvcs.Command;
    import org.robotlegs.mvcs.SignalCommand;
    
   
    
    public class FriendBarVisModelUpdateCommand extends SignalCommand 
    {
        [Inject]
        public var fbIsVisible:Boolean
        
         [Inject]
        public var model:FriendBarVisModel;
        
        /*-----------------------------------------------------------------------------------------
        Public methods
        -------------------------------------------------------------------------------------------*/		
        override public function execute():void 
        {
            model.friendBarVisStatus = fbIsVisible;
        }
        
        /*-----------------------------------------------------------------------------------------
        Private methods
        -------------------------------------------------------------------------------------------*/
        
        /*-----------------------------------------------------------------------------------------
        Event Handlers
        -------------------------------------------------------------------------------------------*/
    }
    
}