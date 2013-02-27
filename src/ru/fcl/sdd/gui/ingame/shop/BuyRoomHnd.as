package ru.fcl.sdd.gui.ingame.shop 
{
	import org.robotlegs.mvcs.SignalCommand;
	import ru.fcl.sdd.buildapplication.init.GetUserInitInfoCommand_6;
	import ru.fcl.sdd.item.ShopModel;
	import ru.fcl.sdd.location.floors.PlaceRoomCommand;
	import ru.fcl.sdd.location.room.Room;
	import ru.fcl.sdd.location.room.RoomCatalog;
	import ru.fcl.sdd.location.room.UserRoomList;
	import ru.fcl.sdd.location.room.XmlRoomModel;
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
		 [Inject]
		public var userRooms:UserRoomList;		
		 [Inject]
		public var xmlRoomModel:XmlRoomModel;
          [Inject]
		public var roomCatalog:RoomCatalog;
		
        override public function execute():void
        {
		
			 commandMap.execute(GetUserInitInfoCommand_6);			 
			var room:Room =  roomCatalog.get(shopMdl.forPurshRoomId) as Room;		 
			commandMap.execute(PlaceRoomCommand, room);
        }
        
    }

}