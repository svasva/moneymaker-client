package ru.fcl.sdd.services.main
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.error.IErrorHandler;
import ru.fcl.sdd.log.ILogger;

public class ConnectSocketServerCommand extends SignalCommand
{
    [Inject]
    public var logger:ILogger;
    [Inject(name="socket_server_error_handler")]
    public var errorHandler:IErrorHandler;

    [Inject]
    public var serverModel:FlashVarsModel;

    override public function execute():void
    {
        var serverProxy:IServerProxy = injector.getInstance(IServerProxy);
        serverProxy.connect(serverModel.socketUrl, WebSocketProtocol.FRAGGLE_PROTOCOL, logger, errorHandler);
    }
}
}
