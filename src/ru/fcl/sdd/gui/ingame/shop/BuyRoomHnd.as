package ru.fcl.sdd.gui.ingame.shop 
{
	import org.robotlegs.mvcs.SignalCommand;
	import ru.fcl.sdd.item.ShopModel;
	import ru.fcl.sdd.location.floors.PlaceRoomCommand;
	import ru.fcl.sdd.location.room.Room;
	import ru.fcl.sdd.scenes.MainIsoView;
	
	/**
     * ...
     * @author atuzov
     */
    public class BuyRoomHnd extends SignalCommand 
    {
        [Inject]
        public var shopMdl:ShopModel;  
      
        
          [Inject]
		public var mainIsoView:MainIsoView;
         
        override public function execute():void
        {
           var room:Room = new Room();
			  room.order = int(shopMdl.forPurshRoomId);
			  room.floor = mainIsoView.currentFloorNumber;
			  commandMap.execute(PlaceRoomCommand, room);
        }
        
    }

}