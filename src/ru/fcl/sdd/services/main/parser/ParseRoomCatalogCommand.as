/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 18:53
 */
package ru.fcl.sdd.services.main.parser
{
import flash.geom.Point;
import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.tools.PrintJSON;

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
    [Inject]
    public var flashVars:FlashVarsModel;

    override public function execute():void
    {
        logger.log(this, "parse room list...");
        var roomsArray:Array = roomListObject.response;
       // PrintJSON.deepTrace( roomListObject.response);
        roomsArray.forEach(add2List);
        logger.log(this, "item list parsed.");
    }

    private function add2List(object:Object,index:int, array:Array):void
    {
        var room:Room = new Room();
        room.id = object._id;
        room.size = new Point(object.size_x,object.size_y);
        room.name = object.name;
        room.decription = object.desc;
        room.icon_url =flashVars.content_url+ object.icon_url
        room.order = object.order;
        
        if(object.money_cost)
        room.money_cost = int(object.money_cost);
        
        if(object.coins_cost)
        room.coins_cost = int(object.coins_cost);
		
		room.reqExp = int(object.requirements.reputation);
		room.requirementLevel = int(object.requirements.level);
		
		if (object.requirements.rooms)
		{
			for  (var items:String in object.requirements.rooms)
			{
				room.reqRoom = items;
			}
		}		
        
        room.room_type_id = object.room_type_id;
        roomListModel.set(room.id, room);
        roomListModel.roomCatalogByRommTypeId.set(room.room_type_id,room);
    }
}
}
