/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 16:38
 */
package ru.fcl.sdd.buildapplication
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.log.ILogger;

import ru.fcl.sdd.services.main.ISender;

import ru.fcl.sdd.services.main.WhenItemsListReceivedCommand;
import ru.fcl.sdd.services.main.listen.CallHashMap;
import ru.fcl.sdd.user.UserDataModel;

public class StartApplicationCommand extends SignalCommand
{
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var sender:ISender;
    [Inject]
    public var callHashMap:CallHashMap;

    override public function execute():void
    {
        logger.log(this, "sending 2 server star application command...");

        var key:String = callHashMap.addValue(WhenItemsListReceivedCommand);
        var call:Object = {requestId:key, command:"startApplication"};
        sender.send(call);
    }
}
}
