package ru.fcl.sdd.gui.main 
{
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.services.shared.SharedGameDataService;
	
	/**
     * ...
     * @author atuzov
     */
    public class SetFriendBarVisCommand extends SignalCommand 
    {
        [Inject]
        public var sharedServ:SharedGameDataService
        
        [Inject]
        public var isVis:Boolean;
        
        override public function execute():void
        {
           //sharedServ.friendBarVisState =  
        }

}
}