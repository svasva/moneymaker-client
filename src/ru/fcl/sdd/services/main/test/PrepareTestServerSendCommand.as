/**
 * Created with IntelliJ IDEA.
 * User: questa_4
 * Date: 07.11.12
 * Time: 19:20
 * To change this template use File | Settings | File Templates.
 */
package ru.fcl.sdd.services.main.test
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.main.IServerProxy;
import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.services.main.WebSocketProtocol;

public class PrepareTestServerSendCommand extends SignalCommand
{
    [Inject]
    public var logger:ILogger;
    [Inject] public var serverModel:FlashVarsModel;

    override public function execute():void
    {
        var serverProxy:IServerProxy = injector.getInstance(IServerProxy);
        serverProxy.connect(serverModel.socketUrl, WebSocketProtocol.DUMB_INCREMENT_PROTOCOL, logger);
    }
}
}
