/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 12:07
 */
package ru.fcl.sdd.services.main.listen
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.homus.AddClientusCommand;
import ru.fcl.sdd.homus.ClientOperation;
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
        clientusIsoView.skin = flashVars.content_url+"/"+response.response.swf_url;
         clientusIsoView.setSize(IsoConfig.CELL_SIZE,IsoConfig.CELL_SIZE,response.response.height*IsoConfig.CELL_SIZE);
        var temp:Array = response.response.operations_mapped;
        clientusIsoView.maxWaiTime = response.response.wait_time*1000;

        //fixme:КОСТЫЛЬ! С сервера приходят данные через строку: нечетные - id операции, четные - деньги на нее.
        for (var i:int = 0; i < temp.length; i+=2)
        {
            var operation:ClientOperation = new ClientOperation();
            operation.id = temp[i];
            operation.money = temp[i+1];
            clientusIsoView.operations.push(operation);
        }

        clientusIsoView.key = response.response._id;
        commandMap.execute(AddClientusCommand,clientusIsoView);
    }
}
}
