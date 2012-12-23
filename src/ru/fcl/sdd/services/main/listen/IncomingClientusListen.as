/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 12:07
 */
package ru.fcl.sdd.services.main.listen
{
import com.adobe.utils.ArrayUtil;

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
        var temp:Array = response.response.operations_mapped;
        //fixme:КОСТЫЛЬ!
        for (var i:int = 0; i < temp.length; i+=2)
        {
            clientusIsoView.operations.push(temp[i]);
        }

        clientusIsoView.key = response.response._id;
        commandMap.execute(AddClientusCommand,clientusIsoView);
    }
}
}
