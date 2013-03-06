package ru.fcl.sdd.location.floors
{
	import as3isolib.display.scene.IsoScene;
	import de.polygonal.ds.HashMapValIterator;
	import de.polygonal.ds.Map;
	import flash.utils.ByteArray;
	import org.robotlegs.mvcs.SignalCommand;
	import ru.fcl.sdd.item.iso.ItemIsoView;
	import ru.fcl.sdd.location.room.Room;
	import ru.fcl.sdd.location.room.UserRoomList;
	import ru.fcl.sdd.location.room.XmlRoomModel;
	import ru.fcl.sdd.pathfind.ClearPathGridRoomCommand;
	import ru.fcl.sdd.pathfind.PlacePathGridRoomCommand;
	import ru.fcl.sdd.scenes.MainIsoView;
	import ru.fcl.sdd.singlepers.CreateSinglePersCommand;
	
	/**
	 * ...
	 * @author atuzov
	 */
	public class PlaceRoomCommand extends SignalCommand
	{
		
		[Inject]
		public var room:Room;
		
		[Inject]
		 public var floorsList:FloorsList;
		 
		 [Inject]
		public var userRooms:UserRoomList;
		
		 [Inject]
		public var xmlRoomModel:XmlRoomModel;
		[Inject]
		public var mainIsoView:MainIsoView;
		
		private function placeRoom():void
		{
			
		}
		
		private function update_grid(rooms:XMLList):void
		{
			
			for each (var item:XML in rooms.item)
			{
				var ro:Object = { "x" : item.@x, "y": item.@y, "id" : room.id }; 
			
				commandMap.execute(PlacePathGridRoomCommand, ro);
			}
			commandMap.execute(CreateSinglePersCommand, room);
		}
		
		override public function execute():void
		{
	
			var scene:FloorItemScene = floorsList.toArray()[mainIsoView.currentFloorNumber];
			
			if (xmlRoomModel.relocByOrder(room.order)>0)
			{
				var iterator:HashMapValIterator = userRooms.iterator() as HashMapValIterator;
				//iterator.reset();
				 while(iterator.hasNext())
				{
					var room1:Room = iterator.next() as Room;
					if (room1.order == xmlRoomModel.relocByOrder(room.order))
					{
						if (xmlRoomModel.floorByOrder2(room.order) == mainIsoView.currentFloorNumber)
						{
							scene.Floor.isoFlor.loadRooms(xmlRoomModel.roomByOrder2(room.order));
							update_grid(xmlRoomModel.roomByOrder2(room.order));
						}
						return;
					}
				}
			}
			
			if (xmlRoomModel.floorByOrder(room.order) == mainIsoView.currentFloorNumber)
			{
				scene.Floor.isoFlor.loadRooms(xmlRoomModel.roomByOrder(room.order));
				update_grid(xmlRoomModel.roomByOrder(room.order));
			}			
	
	}
	}

}