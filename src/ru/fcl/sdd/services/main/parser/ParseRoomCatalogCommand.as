/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 18:53
 */
package ru.fcl.sdd.services.main.parser
{
import flash.geom.Point;

import org.robotlegs.mvcs.Command;

import ru.fcl.sdd.location.room.Room;
import ru.fcl.sdd.location.room.RoomCatalog;
import ru.fcl.sdd.log.ILogger;

public class ParseRoomCatalogCommand extends Command
{
    [Inject]
    public var roomListObject:Object;
    [Inject]
    public var roomListModel:RoomCatalog;
    [Inject]
    public var logger:ILogger;

    override public function execute():void
    {
        logger.log(this, "parse room list...");
        var roomsArray:Array = roomListObject.response;
        roomsArray.forEach(add2List);
        logger.log(this, "item list parsed.");
    }

    private function add2List(object:Object,index:int, array:Array):void
    {
        var room:Room = new Room();
        room.id = object._id;
        room.size = new Point(object.size_x,object.size_y);
        room.name = object.name;
        roomListModel.set(room.id,room);
    }
}
}
