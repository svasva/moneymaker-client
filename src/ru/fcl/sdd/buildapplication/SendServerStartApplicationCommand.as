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

public class SendServerStartApplicationCommand extends SignalCommand
{
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var sender:ISender;


    override public function execute():void
    {
        logger.log(this, "sending 2 server star application command...");
        var call:Object = {command:"startApplication"};
        sender.send(call);
        commandMap.execute(WhenStartApplicationServerResponseCommand);
    }
}
}
