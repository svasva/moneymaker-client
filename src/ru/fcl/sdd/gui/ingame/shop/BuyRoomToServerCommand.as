package ru.fcl.sdd.gui.ingame.shop 
{
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.item.ShopModel;
    import ru.fcl.sdd.scenes.MainIsoView;
    import ru.fcl.sdd.services.main.ISender;
    import ru.fcl.sdd.tempFloorView.FloorManager;
    import ru.fcl.sdd.tempFloorView.MapLayer;
	
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
        public  var layer:MapLayer;
        
          [Inject]
		public var mainIsoView:MainIsoView;
        
        override public function execute():void
        {
             trace("BuyRoomToServerCommand");
             
             
              sender.send( { command:"buyContent", args:[/*item_id:*/shopMdl.forPurshRoomId,/*currency:*/"coins"] }, BuyRoomHnd);
              
              	var xml:XML; 
          
          //  xml  = FloorManager.get_Instance().Next();
             xml  = FloorManager.get_Instance().Next();
            layer.isoFlor.loadRooms(xml.floors.item[mainIsoView.currentFloorNumber].rooms);
              
        }
        
    }

}