package ru.fcl.sdd.location.room 
{
	import flash.geom.Point;
	
   
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
		public function CooordByOrder(order:int):Point
		{
			var p:Point = new Point();
			p.x = int(data.rooms.item[order].sections.@x);
			p.y = int(data.rooms.item[order].sections.@y);
			return p;
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
		public function PersonsByOrder (order:int):Array
		{
			var persons:Array = [];
			if(data.rooms.item[order].persons)
			for each( var item:XML in data.rooms.item[order].persons.item)
			{
				var obj:Object = { "x":item.@x, "y":item.@y, "class_name" : item.@class_name, "direction": item.@direction, "anim" : (item.@anim && item.@anim == "true")? true: false };
				persons.push(obj);
			}
			return persons;
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