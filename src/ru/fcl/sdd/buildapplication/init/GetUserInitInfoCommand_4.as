/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 17:01
 */
package ru.fcl.sdd.buildapplication.init
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.log.ILogger;

import ru.fcl.sdd.services.main.ISender;

import ru.fcl.sdd.services.main.responsehandlers.WhenUserInfoReceivedCommand;
import ru.fcl.sdd.services.main.listen.CallHashMap;
import ru.fcl.sdd.user.UserDataModel;

public class GetUserInitInfoCommand_4 extends SignalCommand
{
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var sender:ISender;
    [Inject]
    public var callHashMap:CallHashMap;

    override public function execute():void
    {
        logger.log(this,"getting user init info...");

        var key:String = callHashMap.addValue(WhenUserInfoReceivedCommand);
        var call:Object = {requestId:key, command:"getUser"};
        sender.send(call);
    }
}
}
