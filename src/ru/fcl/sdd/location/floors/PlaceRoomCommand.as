package ru.fcl.sdd.location.floors
{
	import as3isolib.display.scene.IsoScene;
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
		
		override public function execute():void
		{
			var scene:FloorItemScene = floorsList.toArray()[room.floor];
			if (scene)
			{
				var xml:XML  = XML(new ROOMS)
				if (room.order > 2) return;
				
				scene.Floor.isoFlor.loadRooms(xml.rooms.item[room.order].sections);
			}
		
		}
	
	}

}