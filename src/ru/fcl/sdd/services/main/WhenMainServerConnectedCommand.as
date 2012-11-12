/**
 * User: Jessie
 * Date: 09.11.12
 * Time: 13:45
 */
package ru.fcl.sdd.services.main
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;

public class WhenMainServerConnectedCommand extends SignalCommand
{
    [Inject]
    public var sender:ISender;
    [Inject]
    public var flashVarsModel:FlashVarsModel;

    override public function execute():void
    {
        var o:Object = {token:flashVarsModel.token};
        sender.send(o);
    }
}
}
