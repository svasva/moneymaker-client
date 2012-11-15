/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 16:38
 */
package ru.fcl.sdd.buildapplication
{
import mx.core.FlexGlobals;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.SDD;

import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.main.ISender;
import ru.fcl.sdd.services.main.listen.CallHashMap;

public class SendServerStartApplicationCommand extends SignalCommand
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

        var key:String = callHashMap.addValue(WhenStartApplicationServerResponseCommand);
        var call:Object = {requestId:key, command:"startApplication"};
        sender.send(call);
    }
}
}
