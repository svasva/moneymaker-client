/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 17:59
 */
package ru.fcl.sdd.location.floors
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.item.Item;

import ru.fcl.sdd.item.ItemCatalog;
import ru.fcl.sdd.item.UserItemList;
import ru.fcl.sdd.item.PlaceItemCommand;
import ru.fcl.sdd.location.room.RoomCatalog;
import ru.fcl.sdd.location.room.UserRoomList;
import ru.fcl.sdd.scenes.FloorScene;
import ru.fcl.sdd.scenes.grid.PathGrid;

public class CreateFloorCommand extends SignalCommand
{
    [Inject]
    public var itemId:String;
    [Inject]
    public var userRooms:UserRoomList;
    [Inject]
    public var userItems:UserItemList;
    [Inject]
    public var roomCatalog:RoomCatalog;
    [Inject]
    public var itemCatalog:ItemCatalog;
    [Inject]
    public var pathGrid:PathGrid;
    [Inject]
    public var floorScene:FloorScene;

    override public function execute():void
    {

        userItems.iterator().reset();
        while(userItems.iterator().hasNext())
        {
            var item:Item = userItems.iterator().next() as Item;
            //todo:проверить айтем на соответствие этажу.
            PlaceItemCommand(item);
        }
    }
}
}
