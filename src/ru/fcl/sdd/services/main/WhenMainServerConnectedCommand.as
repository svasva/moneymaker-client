/**
 * User: Jessie
 * Date: 09.11.12
 * Time: 13:45
 */
package ru.fcl.sdd.services.main
{
import org.robotlegs.mvcs.SignalCommand;

public class WhenMainServerConnectedCommand extends SignalCommand
{
    [Inject]
    public var sender:ISender;

    override public function execute():void
    {
        var o:Object = {message:"test", a1:1, a2:2};
        sender.send(o);
    }
}
}
