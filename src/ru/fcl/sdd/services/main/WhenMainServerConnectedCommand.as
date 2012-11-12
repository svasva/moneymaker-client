/**
 * User: Jessie
 * Date: 09.11.12
 * Time: 13:45
 */
package ru.fcl.sdd.services.main
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.log.ILogger;

public class WhenMainServerConnectedCommand extends SignalCommand
{
    [Inject]
    public var sender:ISender;
    [Inject]
    public var flashVarsModel:FlashVarsModel;
    [Inject]
    public var logger:ILogger;

    override public function execute():void
    {
        var token:Object = {token:flashVarsModel.token};
        sender.send(token);
    }
}
}
