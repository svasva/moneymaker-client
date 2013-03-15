/**
 * User: Jessie
 * Date: 18.12.12
 * Time: 10:54
 */
package ru.fcl.sdd.pathfind
{
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.item.ItemCatalog;
import ru.fcl.sdd.location.room.Room;
import ru.fcl.sdd.location.room.UserRoomList;
import ru.fcl.sdd.location.room.XmlRoomModel;
import ru.fcl.sdd.scenes.MainIsoView;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.item.iso.ItemIsoView;

public class PlacePathGridItemCommand extends SignalCommand
{
    [Inject]
    public var iso:ItemIsoView;
    [Inject]
    public var pathGreeds:FloorPathGridItemList;
	  [Inject]
    public var userRoomList:UserRoomList;
	[Inject]
    public var itemCatalog:ItemCatalog;
	  [Inject]
     public var xmlRoomModel:XmlRoomModel;

	  [Inject]
     public var mainIsoView:MainIsoView;

    override public function execute():void
    {
		var floor:int
		if (iso.catalogKey)
		{
		
			var item:Item = itemCatalog.get(iso.catalogKey) as Item;
			
			
			var room:Room =  userRoomList.get(item.room_id) as Room;
	   
			if(room) 
			floor = xmlRoomModel.floorByOrder(room.order);
		}
		else
			floor = mainIsoView.currentFloorNumber;
			
		var pathGreed:ItemsPathGrid =  pathGreeds.get(floor) as ItemsPathGrid;
	   
        for (var j:int = 0; j < iso.length / IsoConfig.CELL_SIZE; j++)
        {
            for (var i:int = 0; i < iso.width / IsoConfig.CELL_SIZE; i++)
            {
                pathGreed.setWalkable(i + iso.x / IsoConfig.CELL_SIZE, j + iso.y / IsoConfig.CELL_SIZE, false);
                
            }
        }
    }
}
}
