/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 13:45
 */
package ru.fcl.sdd.services.main.parser
{
import flash.geom.Point;
import ru.fcl.sdd.tools.PrintJSON;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.location.room.Room;
import ru.fcl.sdd.location.room.RoomCatalog;
import ru.fcl.sdd.location.room.UserRoomList;

public class ParseUserRooms extends SignalCommand
{
    [Inject]
    public var rooms:Array;

    [Inject]
    public var userRoomList:UserRoomList;

    [Inject]
    public var roomList:RoomCatalog;

    override public function execute():void
    {     
        if (!userRoomList.isEmpty)
        userRoomList.clear();
		
		PrintJSON.deepTrace( rooms);
        rooms.forEach(parseRooms);
        
    }

    private function parseRooms(object:Object,index:int, array:Array):void
    {       
         var room:Room = new Room();
        room.id = object._id;
        room.catalogId = object.reference_id;
        room.offset = new Point(object.x,object.y);
        room.size = Room(roomList.get(room.catalogId)).size;
        room.name = Room(roomList.get(room.catalogId)).name;
        room.room_type_id = object.room_type_id;
		room.order = object.order;
		room.floor = object.floor;
        userRoomList.set(room.id,room);
    }
}
}
