/**
 * User: Jessie
 * Date: 12.12.12
 * Time: 17:06
 */
package ru.fcl.sdd.item
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.IsoConfig;

import ru.fcl.sdd.location.room.Room;

import ru.fcl.sdd.location.room.RoomCatalog;
import ru.fcl.sdd.location.room.UserRoomList;

import ru.fcl.sdd.log.LogServerResponseCommand;
import ru.fcl.sdd.services.main.ISender;
import ru.fcl.sdd.states.ChangeStateSignal;
import ru.fcl.sdd.states.GameStates;

public class SendServerPlaceMovedItemCommand extends SignalCommand
{
    [Inject]
    public var sender:ISender;

    [Inject]
    public var userRoomList:UserRoomList;

    [Inject]
    public var changeState:ChangeStateSignal;

    [Inject(name="item_for_move")]
    public var item:ItemIsoView;

    override public function execute():void
    {
        var room:Room = userRoomList.iterator().next() as Room;
        changeState.dispatch(GameStates.VIEW);
        sender.send({command:"placeItem", args:[room.id,item.key,item.x/IsoConfig.CELL_SIZE, item.y/IsoConfig.CELL_SIZE,item.rotationIso]},LogServerResponseCommand);
    }
}
}
