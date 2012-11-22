/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 15:50
 */
package ru.fcl.sdd.services.main.responsehandlers
{
import org.robotlegs.mvcs.Command;

import ru.fcl.sdd.buildapplication.init.GetItemListCommand_4;
import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.main.listen.CallHashMap;
import ru.fcl.sdd.services.main.parser.ParseRoomListCommand;

public class WhenRoomListReceivedCommand extends Command
{
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var rooms:Object;
    [Inject]
    public var callHashMap:CallHashMap;

    override public function execute():void
    {
//        callHashMap.remove(WhenItemsListReceivedCommand);
        logger.log(this, "room list received.");
        commandMap.execute(ParseRoomListCommand, rooms);
        commandMap.execute(GetItemListCommand_4);
    }
}
}
