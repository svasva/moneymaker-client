/**
 * User: Jessie
 * Date: 12.12.12
 * Time: 17:06
 */
package ru.fcl.sdd.item.iso
{
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.pathfind.RoomsPathGrid;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.item.iso.ItemIsoView;

import ru.fcl.sdd.location.room.Room;

import ru.fcl.sdd.location.room.UserRoomList;

import ru.fcl.sdd.log.LogServerResponseCommand;
import ru.fcl.sdd.pathfind.PlacePathGridItemCommand;
import ru.fcl.sdd.services.main.ISender;
import ru.fcl.sdd.states.ChangeStateSignal;
import ru.fcl.sdd.states.GameStates;

public class PlaceMovedItemCommand extends SignalCommand
{
    [Inject]
    public var sender:ISender;

    [Inject]
    public var userRoomList:UserRoomList;

	 [Inject]
    public var roomsPathGrid:RoomsPathGrid;
    [Inject]
    public var changeState:ChangeStateSignal;

    [Inject(name="item_for_move")]
    public var item:ItemIsoView;

    override public function execute():void
    {
       /// var room:Room = userRoomList.iterator().next() as Room;
        changeState.dispatch(GameStates.VIEW);
		var room_id:String = String(roomsPathGrid.getNode(item.x / IsoConfig.CELL_SIZE, item.y / IsoConfig.CELL_SIZE).data);
  
		sender.send({command:"placeItem", args:[room_id,item.key,item.x/IsoConfig.CELL_SIZE, item.y/IsoConfig.CELL_SIZE,item.direction]},LogServerResponseCommand);
        commandMap.execute(PlacePathGridItemCommand,item);
    }
}
}
