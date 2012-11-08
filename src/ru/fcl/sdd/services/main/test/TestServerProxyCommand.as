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

import ru.fcl.sdd.services.main.IServerProxy;

public class TestServerProxyCommand extends SignalCommand
{
    override public function execute():void
    {
        var serverProxy:IServerProxy = injector.getInstance(IServerProxy);
        serverProxy.connect();
    }
}
}
