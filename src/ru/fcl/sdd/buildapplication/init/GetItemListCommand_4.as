/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 15:50
 */
package ru.fcl.sdd.buildapplication.init
{
import org.robotlegs.mvcs.Command;

import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.main.*;
import ru.fcl.sdd.services.main.listen.CallHashMap;
import ru.fcl.sdd.services.main.responsehandlers.WhenItemListReceivedCommand;
import ru.fcl.sdd.user.UserDataModel;

public class GetItemListCommand_4 extends Command
{
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var sender:ISender;

    override public function execute():void
    {
        logger.log(this,"getting item table...");

        var call:Object = {command:"getItems"};
        sender.send(call,WhenItemListReceivedCommand);
    }
}
}
