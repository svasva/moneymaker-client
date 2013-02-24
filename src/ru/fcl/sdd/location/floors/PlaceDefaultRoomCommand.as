package ru.fcl.sdd.location.floors
{
	import as3isolib.display.scene.IsoScene;
	import de.polygonal.ds.Map;
	import flash.utils.ByteArray;
	import org.robotlegs.mvcs.SignalCommand;
	import ru.fcl.sdd.item.iso.ItemIsoView;
	import ru.fcl.sdd.location.room.UserRoomList;
	import ru.fcl.sdd.scenes.MainIsoView;
	
	/**
	 * ...
	 * @author atuzov
	 */
	public class PlaceDefaultRoomCommand extends SignalCommand
	{
		[Embed(source = "../../../../../../art/bin/DefaultMap.xml",  mimeType="application/octet-stream")] private const MAP:Class;
		[Inject]
		public var floorNumber:int;
		
		[Inject]
		 public var floorsList:FloorsList;		
		
		override public function execute():void
		{
			var scene:FloorItemScene = floorsList.toArray()[floorNumber];
			if (scene)
			{
				var xml:XML  = XML(new MAP)
				switch(floorNumber)
				{
				case 0:
					scene.Floor.isoFlor.loadRooms(xml.floors.item[0].rooms);
				break;
				case 4:
				scene.Floor.isoFlor.loadRooms(xml.floors.item[2].rooms);
				
				break;
				default:
				scene.Floor.isoFlor.loadRooms(xml.floors.item[1].rooms);
				
				
				}
			}
		
		}
	
	}

}