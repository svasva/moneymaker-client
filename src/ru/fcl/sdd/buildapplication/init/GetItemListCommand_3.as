/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 15:50
 */
package ru.fcl.sdd.buildapplication.init
{
import org.robotlegs.mvcs.Command;

import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.main.*;
import ru.fcl.sdd.services.main.listen.CallHashMap;
import ru.fcl.sdd.services.main.responsehandlers.WhenItemsListReceivedCommand;
import ru.fcl.sdd.user.UserDataModel;

public class GetItemListCommand_3 extends Command
{
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var userDataModel:UserDataModel;
    [Inject]
    public var userObject:Object;
    [Inject]
    public var sender:ISender;
    [Inject]
    public var callHashMap:CallHashMap;

    override public function execute():void
    {
//        callHashMap.remove(GetItemListCommand_3);
        logger.log(this,"getting items table...");

        var key:String = callHashMap.addValue(WhenItemsListReceivedCommand);
        var call:Object = {requestId:key, command:"getItems"};
        sender.send(call);
    }
}
}
