package ru.fcl.sdd.location.floors 
{
    import flash.utils.ByteArray;
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.item.iso.ItemIsoView;
    import ru.fcl.sdd.tempFloorView.controllers.Uni_controller;
    import ru.fcl.sdd.tempFloorView.controllers.Uni_event;
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
        
          [Embed(source="../../../../../../art/bin/BetonMap.xml",  mimeType = "application/octet-stream")] 
        private const HMap1:Class;
        
        
        [Embed(source = "../../../../../../art/bin/Operation_hall.xml", mimeType = "application/octet-stream")] private var  OPERATION_HALL:Class;
        
        [Embed(source = "../../../../../../art/bin/Director.xml" , mimeType = "application/octet-stream")]
        private var DIRECTOR:Class;
      
    
        
       
        
        override public function execute():void 
        {
           // layer = new MapLayer(floor, null);
             layer.scene = floor;
          //  floor.addChild(layer);
           layer.loadMap(HMap1);
            var event:Uni_event = new Uni_event(IsoFloor.PLACE_ROOM);
                var bytes:ByteArray = new OPERATION_HALL();            
            var xml:XML = new XML(bytes.readUTFBytes(bytes.length));            
           // layer.isoFlor.loadRooms(xml.floors.rooms);
            
            bytes = new DIRECTOR(); 
            xml  = new XML(bytes.readUTFBytes(bytes.length));  
            layer.isoFlor.loadRooms(xml.floors.rooms);
         
          
			//Uni_controller.getInstance().dispatchEvent(event);
        }
        
    }

}