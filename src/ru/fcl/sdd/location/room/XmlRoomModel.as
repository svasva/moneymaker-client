package ru.fcl.sdd.location.room 
{
   
    public class XmlRoomModel 
    { 
        [Embed(source="../../../../../../art/bin/Rooms.xml",  mimeType = "application/octet-stream")] private const ROOMS:Class;
        
		private var data:XML;
		 
		public function XmlRoomModel() 
        {
			 data  = XML(new ROOMS);            
        }
		
		public function roomByOrder(order:int):XMLList
		{
			return data.rooms.item[order].sections;
		}
		
		//replace room
        public function roomByOrder2(order:int):XMLList
		{
			return data.rooms.item[order].sections2;
		}
		
		//на каком этаже комната
		public function floorByOrder (order:int):int
		{
			return data.rooms.item[order].@floor;
		}
		
		public function floorByOrder2 (order:int):int
		{
			return data.rooms.item[order].sections2.@floor;
		}
		
		//при наличие какой комнаты используем roomByOrder2; -1 нет такой комнаты
		public function relocByOrder (order:int):int
		{
			if (data.rooms.item[order].@reloc_order)
				return data.rooms.item[order].@reloc_order;
			else
				return -1;
		}
      
        
    }

} 