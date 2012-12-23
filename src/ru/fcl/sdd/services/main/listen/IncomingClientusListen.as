/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 12:07
 */
package ru.fcl.sdd.services.main.listen
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.homus.AddClientusCommand;

import ru.fcl.sdd.homus.ClientusIsoView;

public class IncomingClientusListen extends SignalCommand
{
    [Inject]
    public var response:Object;
    override public function execute():void
    {
        var clientusIsoView:ClientusIsoView = injector.getInstance(ClientusIsoView);
        clientusIsoView.operations = response.response.operations;
        clientusIsoView.key = response.response._id;
        commandMap.execute(AddClientusCommand,clientusIsoView);
    }
}
}
