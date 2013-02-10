package ru.fcl.sdd.tempFloorView.Nodes 
{
	import as3isolib.core.IsoDisplayObject;
	import as3isolib.data.INode;
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import flash.events.Event;

    import ru.fcl.sdd.tempFloorView.controllers.Uni_controller;
    import ru.fcl.sdd.tempFloorView.controllers.Uni_event;
	
	/**
	 * ...
	 * @author Timonin
	 */
	public class IsoFloor extends  IsoDisplayObject 
	{
		var vrooms:Vector.<INode>;
		private const CELL:int = 50;
		private var view:IsoView;
		private var hall_layer:IsoSprite = new IsoSprite();
		private var rooms_layer:IsoSprite = new IsoSprite();
		
		public static const PLACE_ROOM:String = "Place_Room";
		//
	//	private var wall_layer:IsoSprite = new IsoSprite();
		public function IsoFloor(view:IsoView):void 
		{
			vrooms = new Vector.<INode>
			this.view = view;
			addChild(hall_layer);
			addChild(rooms_layer);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, clear);
			
		}
		public function loadHall(halls:XMLList):void
		{
			for each (var hall:XML in halls.item)
			{
				var item:IsoHall = new IsoHall(view);
				addHall(hall.@x, hall.@y, item);
				item.loadGround(hall.grounds);
				//item.loadWall(hall.walls);
			//	item.loadObject(hall.objects);
			}
			
		}
		private  function clear(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, clear);
			Uni_controller.getInstance().removeEventListener(PLACE_ROOM, PlaceRoomHandler);
			
		}
		
		private  function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Uni_controller.getInstance().addEventListener(PLACE_ROOM, PlaceRoomHandler);
			
		}
		
		private function PlaceRoomHandler(e:Uni_event):void
		{
			var data:XMLList = e.arg;
			
			loadRooms(data);
		}
		
		public function loadRooms(rooms:XMLList):void
		{
		
            
            for each (var room:XML in rooms.item)
			{
				var i:int = -1;
				if (vrooms.length >0)
				 i = romoveRoom(int(room.@r_id));
				var item:IsoRoom = new IsoRoom(view);
				item.Room_id = int(room.@r_id);
				
				
				addRoom(room.@x, room.@y, item);
				if (i > -1)
				rooms_layer.setChildIndex(item, i);
				item.loadGround(room.grounds);
				item.loadWall(room.walls);
				item.loadObject(room.objects);
			}
			
		}
		public function addHall(x:Number, y:Number, hall:IsoHall):void
		{
			hall_layer.addChild(hall);
			hall.x = x*CELL;
			hall.y = y * CELL;
		//	(room as IsoDisplayObject).
			//rooms.push(room);
		}
		public function findById(id:int):IsoRoom
		{
			for each (var room:IsoRoom in vrooms)
			if (room.Room_id == id) return room;
			
			return null;
			
		}
		
		public function romoveRoom(id:int):int
		{
			var room:IsoRoom = findById(id);
			if (room == null) return -1;
			var ind:int = rooms_layer.getChildIndex(room);
			rooms_layer.removeChild(room);
			vrooms.splice(vrooms.indexOf(room), 1);
			room = null;
			render(true);
			return ind;
		}
		
		public function addRoom(x:Number, y:Number, room:IsoRoom):void
		{
			rooms_layer.addChild(room);
			room.x = x*CELL;
			room.y = y * CELL;
		//	(room as IsoDisplayObject).
			vrooms.push(room);
		}
		
	}

}