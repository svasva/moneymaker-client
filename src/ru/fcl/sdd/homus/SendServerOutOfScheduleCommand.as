/**
 * User: Jessie
 * Date: 15.01.13
 * Time: 17:23
 */
package ru.fcl.sdd.homus
{
import ru.fcl.sdd.services.main.ISender;
import org.robotlegs.mvcs.SignalCommand;

public class SendServerOutOfScheduleCommand extends SignalCommand
{
    [Inject]
    public var sender:ISender;

    override public function execute():void
    {
        var object:Object = {command:"noResina",args:[]};
        sender.send(object);
    }
}
}
