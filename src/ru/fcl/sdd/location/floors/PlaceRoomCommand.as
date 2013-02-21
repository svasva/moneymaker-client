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
	import ru.fcl.sdd.scenes.MainIsoView;
	
	/**
	 * ...
	 * @author atuzov
	 */
	public class PlaceRoomCommand extends SignalCommand
	{
		[Embed(source="../../../../../../art/bin/Rooms.xml",  mimeType = "application/octet-stream")] private const ROOMS:Class;
		
		[Inject]
		public var room:Room;
		
		[Inject]
		 public var floorsList:FloorsList;
		 
		 [Inject]
		public var userRooms:UserRoomList;
		
		private function placeRoom():void
		{
			
		}
		
		override public function execute():void
		{
			var xml:XML  = XML(new ROOMS);
			var scene:FloorItemScene = floorsList.toArray()[room.floor];
			
			if (xml.rooms.item[room.order].@reloc_odrer>0)
			{
				var iterator:HashMapValIterator = userRooms.iterator() as HashMapValIterator;
				//iterator.reset();
				 while(iterator.hasNext())
				{
					var room1:Room = iterator.next() as Room;
					if (room1.order == xml.rooms.item[room.order].@reloc_order)
					{
						if (xml.rooms.item[room.order].sections2.@floor == room.floor)
							scene.Floor.isoFlor.loadRooms(xml.rooms.item[room.order].sections2);
						return;
					}
				}
			}
			
			if (xml.rooms.item[room.order].@floor == room.floor)
			scene.Floor.isoFlor.loadRooms(xml.rooms.item[room.order].sections);
			
	
	}
	}

}