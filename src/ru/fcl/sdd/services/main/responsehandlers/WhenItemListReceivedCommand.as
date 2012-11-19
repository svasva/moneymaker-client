/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 15:50
 */
package ru.fcl.sdd.services.main.responsehandlers
{
import org.robotlegs.mvcs.Command;

import ru.fcl.sdd.buildapplication.init.GetUserInitInfoCommand_4;
import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.main.listen.CallHashMap;
import ru.fcl.sdd.services.main.parser.ParseItemListCommand;

public class WhenItemListReceivedCommand extends Command
{
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var items:Object;
    [Inject]
    public var callHashMap:CallHashMap;

    override public function execute():void
    {
//        callHashMap.remove(WhenItemsListReceivedCommand);
        logger.log(this,"item list received.");
        commandMap.execute(ParseItemListCommand,items);
        commandMap.execute(GetUserInitInfoCommand_4);
    }
}
}
