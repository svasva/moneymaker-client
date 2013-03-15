/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 12:09
 */
package ru.fcl.sdd.services.main.listen
{
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.quest.QuestAcceptedSig;

public class RegisterListenersCommand extends SignalCommand
{
    [Inject]
    public var callHashMap:CallHashMap;

    override public function execute():void
    {
         injector.mapSingleton(QuestAcceptedSig);
		 callHashMap.addResponseHandler(IncomingClientusListen,"-3");
         callHashMap.addResponseHandler(ChangeUserModelFromServer,"-1");
         callHashMap.addResponseHandler(ChangeItemStateCommand,"-2");
    }
}
}
