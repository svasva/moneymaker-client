/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 12:07
 */
package ru.fcl.sdd.services.main.listen
{
import org.robotlegs.mvcs.SignalCommand;

public class IncomingClientListen extends SignalCommand
{
    [Inject]
    public var response:Object;
    override public function execute():void
    {
        trace(response);
    }
}
}
