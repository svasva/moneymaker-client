/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 15:50
 */
package ru.fcl.sdd.services.main
{
import org.robotlegs.mvcs.Command;

import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.main.listen.CallHashMap;
import ru.fcl.sdd.services.main.parser.ParseItemListCommand;
import ru.fcl.sdd.user.UserDataModel;

public class WhenItemsListReceivedCommand extends Command
{
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var items:Object;

    override public function execute():void
    {
        logger.log(this,"item list received.");
        commandMap.execute(ParseItemListCommand,items);
    }
}
}
