/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 17:59
 */
package ru.fcl.sdd.location.floors
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.item.ItemCatalog;
import ru.fcl.sdd.item.UserItemList;
import ru.fcl.sdd.location.room.RoomCatalog;
import ru.fcl.sdd.location.room.UserRoomList;

public class CreateFloorCommand extends SignalCommand
{
    [Inject]
    public var itemId:String;
    [Inject]
    public var floors:FloorsList;
    [Inject]
    public var userRooms:UserRoomList;
    [Inject]
    public var userItems:UserItemList;
    [Inject]
    public var roomCatalog:RoomCatalog;
    [Inject]
    public var itemCatalog:ItemCatalog;


    override public function execute():void
    {
        var currentFloor:FloorGrid = floors.get(itemId) as FloorGrid;

        floors.iterator().reset();

        userItems.iterator().reset();
        //TODO: Учесть здесь смещение комнаты.
        while(userItems.iterator().hasNext())
        {

        }


    }
}
}
