package ru.fcl.sdd.item 
{
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.location.floors.Floor1Scene;
    import ru.fcl.sdd.location.room.RoomModel;
    import ru.fcl.sdd.pathfind.DeletePathGreedItemCommand;
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
        public var floor:Floor1Scene;
        
      override public function execute():void
        {
            trace("SellItemCommand");
            floor.removeChild(roomMdl.selectedItem);
            commandMap.execute(DeletePathGreedItemCommand, roomMdl.selectedItem);
            floor.render();
            sender.send( { command:"sellContent", args:[roomMdl.selectedItem.key] } );
            
        }
        
    }

}