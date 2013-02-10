/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 12:09
 */
package ru.fcl.sdd.services.main.listen
{
import org.robotlegs.mvcs.SignalCommand;

public class RegisterListenersCommand extends SignalCommand
{
    [Inject]
    public var callHashMap:CallHashMap;

    override public function execute():void
    {
         callHashMap.addResponseHandler(IncomingClientusListen,"-3");
         callHashMap.addResponseHandler(ChangeUserModelFromServer,"-1");
         callHashMap.addResponseHandler(ChangeItemStateCommand,"-2");
    }
}
}
