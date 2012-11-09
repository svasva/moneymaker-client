/**
 * Created with IntelliJ IDEA.
 * User: questa_4
 * Date: 07.11.12
 * Time: 19:20
 * To change this template use File | Settings | File Templates.
 */
package ru.fcl.sdd.services.main.test
{
import ru.fcl.sdd.log.ILogger;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.services.ServicesConfig;
import ru.fcl.sdd.services.main.IServerProxy;
import ru.fcl.sdd.services.main.WebSocketProtocol;

public class PrepareTestServerSendCommand extends SignalCommand
{
    [Inject]
    public var logger:ILogger;

    override public function execute():void
    {
        var serverProxy:IServerProxy = injector.getInstance(IServerProxy);
        serverProxy.connect(ServicesConfig.EXTERNAL_DEVELOP_MAIN_SERVER_URL, WebSocketProtocol.DUMB_INCREMENT_PROTOCOL, logger);


    }
}
}
