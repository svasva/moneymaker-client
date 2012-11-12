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
        serverProxy.connect(serverModel.socketUrl, WebSocketProtocol.FRAGGLE_PROTOCOL, logger);
    }
}
}
