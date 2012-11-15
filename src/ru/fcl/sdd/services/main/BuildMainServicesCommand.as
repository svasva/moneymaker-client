/**
 * User: Jessie
 * Date: 07.11.12
 * Time: 19:32
 */
package ru.fcl.sdd.services.main
{
import org.osflash.signals.AboutObject;
import org.osflash.signals.AboutString;
import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.buildapplication.init.AuthoriseSocketServerCommand_2;

import ru.fcl.sdd.services.main.errorhandle.ServerResponseErrorHandleCommand;
import ru.fcl.sdd.services.main.listen.BuildServerListen;
import ru.fcl.sdd.services.main.parser.ParseExecutedCommand;

public class BuildMainServicesCommand extends SignalCommand
{
    override public function execute():void
    {
        commandMap.execute(BuildServerListen);

        var connected:ISignal = new Signal();
        injector.mapValue(ISignal,connected,"main_server_connected");
        signalCommandMap.mapSignal(connected,AuthoriseSocketServerCommand_2);

        var errorResponse:ISignal = new AboutObject();
        injector.mapValue(ISignal,errorResponse,"error_response_signal");
        signalCommandMap.mapSignal(errorResponse,ServerResponseErrorHandleCommand);

        var serverTalkSignal:ISignal = new AboutString();
        injector.mapValue(ISignal,serverTalkSignal,"main_server_talk");
        signalCommandMap.mapSignal(serverTalkSignal,ParseExecutedCommand);

        injector.mapSingletonOf(IServerProxy, ServerProxy);

        injector.mapSingletonOf(ISender,Sender);
    }
}
}
