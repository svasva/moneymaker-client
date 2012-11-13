/**
 * User: Jessie
 * Date: 09.11.12
 * Time: 13:45
 */
package ru.fcl.sdd.services.main
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.main.listen.CallHashMap;
import ru.fcl.sdd.services.main.listen.CallCommandClassMap;

public class WhenMainServerConnectedCommand extends SignalCommand
{
    [Inject]
    public var sender:ISender;
    [Inject]
    public var flashVarsModel:FlashVarsModel;
    [Inject]
    public var logger:ILogger;

    [Inject] public var callHashMap: CallHashMap;

    override public function execute():void
    {
        var key:String = callHashMap.addValue(new CallCommandClassMap("test"));
        var token:Object = {requestId:key, token:flashVarsModel.token};
        sender.send(token);
    }


}
}
