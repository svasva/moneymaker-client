package ru.fcl.sdd.item 
{
	import org.robotlegs.mvcs.SignalCommand;
   
    import ru.fcl.sdd.location.room.RoomModel;
    import ru.fcl.sdd.pathfind.DeletePathGreedItemCommand;
	import ru.fcl.sdd.scenes.MainIsoView;
    import ru.fcl.sdd.services.main.ISender;
	
	/**
     * ...
     * @author atuzov
     */
    public class SellItemCommand extends SignalCommand 
    {
      
       [Inject]
        public var sender:ISender;
        
        [Inject] 
        public var roomMdl:RoomModel;
        
        [Inject]
        public var mainIsoView:MainIsoView;
        
      override public function execute():void
        {
            trace("SellItemCommand");
            mainIsoView.currentFloor.removeChild(roomMdl.selectedItem);
            commandMap.execute(DeletePathGreedItemCommand, roomMdl.selectedItem);
            mainIsoView.currentFloor.render();
            sender.send( { command:"sellContent", args:[roomMdl.selectedItem.key] } );
            
        }
        
    }

}