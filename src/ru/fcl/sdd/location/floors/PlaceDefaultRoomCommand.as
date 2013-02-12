package ru.fcl.sdd.location.floors 
{
    import flash.utils.ByteArray;
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.item.iso.ItemIsoView;
    import ru.fcl.sdd.location.room.UserRoomList;
    import ru.fcl.sdd.scenes.MainIsoView;
    import ru.fcl.sdd.tempFloorView.controllers.Uni_controller;
    import ru.fcl.sdd.tempFloorView.controllers.Uni_event;
	import ru.fcl.sdd.tempFloorView.FloorManager;
    import ru.fcl.sdd.tempFloorView.MapLayer;
    import ru.fcl.sdd.tempFloorView.Nodes.IsoFloor;
	
	/**
     * ...
     * @author atuzov
     */
    public class PlaceDefaultRoomCommand extends SignalCommand 
    {   
       
        [Inject]
        public var floor:Floor1Scene;
      
        
        [Inject]
        public  var layer:MapLayer;
       
       [Inject]
        public var floorNumber:int;    
        
                [Inject]
    public var userRoomList:UserRoomList;
    
  
        
           [Inject]
		public var mainIsoView:MainIsoView;
        
       
        
        override public function execute():void 
        {
           // layer = new MapLayer(floor, null);
             layer.scene = floor;
			 if (!floor.contains(layer))
				floor.addChild(layer);
      //     layer.loadMap(HMap1);
         //   var event:Uni_event = new Uni_event(IsoFloor.PLACE_ROOM);
         //       var bytes:ByteArray = new OPERATION_HALL();            
         //   var xml:XML = new XML(bytes.readUTFBytes(bytes.length));            
         //   layer.isoFlor.loadRooms(xml.floors.rooms);
            
				layer.init();
			
			var xml:XML = FloorManager.get_Instance().Current();           
			layer.isoFlor.loadRooms(xml.floors.item[floorNumber].rooms);  
          
			 
        
         	
         
        }
            
        
     
        
    }

}