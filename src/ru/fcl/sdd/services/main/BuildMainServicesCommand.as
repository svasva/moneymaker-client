/**
 * User: Jessie
 * Date: 07.11.12
 * Time: 19:32
 */
package ru.fcl.sdd.services.main
{
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

import org.osflash.signals.AboutString;
import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.error.ServerErrorDispatcher;

import ru.fcl.sdd.services.main.listen.BuildServerListen;
import ru.fcl.sdd.services.main.parser.ParseServerTalkCommand;

public class BuildMainServicesCommand extends SignalCommand
{
    override public function execute():void
    {
        commandMap.execute(BuildServerListen);

        var connected:ISignal = new Signal();
        injector.mapValue(ISignal,connected,"main_server_connected");
        signalCommandMap.mapSignal(connected,WhenMainServerConnectedCommand);

        var serverTalkSignal:ISignal = new AboutString();
        injector.mapValue(ISignal,serverTalkSignal,"main_server_talk");
        signalCommandMap.mapSignal(serverTalkSignal,ParseServerTalkCommand);

        injector.mapSingletonOf(IServerProxy, ServerProxy);

        injector.mapSingletonOf(ISender,Sender);
    }
}
}
