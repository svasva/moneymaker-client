/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 15:51
 */
package ru.fcl.sdd.buildapplication.init
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.services.main.ISender;

import ru.fcl.sdd.services.main.responsehandlers.WhenRoomsCatalogReceivedCommand;

public class GetRoomsCommand_3 extends SignalCommand
{
    [Inject]
    public var sender:ISender;

    override public function execute():void
    {
        var call:Object = {command:"getRooms"};
        sender.send(call,WhenRoomsCatalogReceivedCommand);
    }
}
}
