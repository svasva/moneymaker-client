package ru.fcl.sdd.location.floors 
{
    import flash.utils.ByteArray;
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.item.iso.ItemIsoView;
    import ru.fcl.sdd.location.room.UserRoomList;
    import ru.fcl.sdd.scenes.MainIsoView;
   
	
	
	/**
     * ...
     * @author atuzov
     */
    public class BuildFloorsCommand extends SignalCommand 
    {   
       
        [Inject]
        public var floorList:FloorsList;     
        private const NUM_FLOORS:int = 5;
       
        
        override public function execute():void 
        {
         for (var i:int = 0; i < NUM_FLOORS; i++)
		{
		var floor:FloorItemScene = new FloorItemScene(i);
		floorList.set(i, floor);
		
		 commandMap.execute(PlaceDefaultRoomCommand,i);
		}  
        
         	
         
        }
            
        
     
        
    }

}