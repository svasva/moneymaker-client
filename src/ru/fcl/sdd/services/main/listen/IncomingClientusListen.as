/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 12:07
 */
package ru.fcl.sdd.services.main.listen
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.homus.AddClientusCommand;
import ru.fcl.sdd.homus.ClientusIsoView;

public class IncomingClientusListen extends SignalCommand
{
    [Inject]
    public var response:Object;
    [Inject]
    public var flashVars:FlashVarsModel;
    override public function execute():void
    {
        var clientusIsoView:ClientusIsoView = injector.getInstance(ClientusIsoView);
//      var clientusIsoView:ClientusIsoView = new ClientusIsoView();
        clientusIsoView.skin = flashVars.content_url+"/"+response.response.swf_url;
//        injector.mapValue(ClientusIsoView,clientusIsoView);

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
