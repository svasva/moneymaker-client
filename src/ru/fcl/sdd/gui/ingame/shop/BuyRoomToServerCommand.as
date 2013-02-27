package ru.fcl.sdd.gui.ingame.shop 
{
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.item.ShopModel;
	import ru.fcl.sdd.location.floors.PlaceRoomCommand;
	import ru.fcl.sdd.location.room.Room;
	import ru.fcl.sdd.location.room.RoomCatalog;
    import ru.fcl.sdd.scenes.MainIsoView;
    import ru.fcl.sdd.services.main.ISender;
  
	
	/**
     * ...
     * @author atuzov
     */
    public class BuyRoomToServerCommand extends SignalCommand 
    {
        
        [Inject]
        public var sender:ISender;
        
        [Inject]
        public var shopMdl:ShopModel;  
      
        
          [Inject]
		public var mainIsoView:MainIsoView;
		     [Inject]
		public var roomCatalog:RoomCatalog;
        
        override public function execute():void
        {
             trace("BuyRoomToServerCommand");
             
             
              sender.send( { command:"buyContent", args:[/*item_id:*/shopMdl.forPurshRoomId,/*currency:*/"coins"] }, BuyRoomHnd);
              trace (shopMdl.forPurshRoomId);
              ///	var xml:XML; 
       //  var room:Room =  roomCatalog.get(shopMdl.forPurshRoomId) as Room;
		//  room.order = 7;
		//commandMap.execute(PlaceRoomCommand, room);
          //  xml  = FloorManager.get_Instance().Next();
          //   xml  = FloorManager.get_Instance().Next();
         //   layer.isoFlor.loadRooms(xml.floors.item[mainIsoView.currentFloorNumber].rooms);
              
        }
        
    }

}