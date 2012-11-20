/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 15:50
 */
package ru.fcl.sdd.services.main.responsehandlers
{
import ru.fcl.sdd.buildapplication.init.LoadRSLCommand5;
import ru.fcl.sdd.services.main.*;

import org.robotlegs.mvcs.Command;

import ru.fcl.sdd.buildapplication.init.InitCompeteCommand;

import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.main.listen.CallHashMap;
import ru.fcl.sdd.services.main.parser.ParseUserDataCommand;
import ru.fcl.sdd.user.UserDataModel;

public class WhenUserInfoReceivedCommand extends Command
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
//        callHashMap.remove(WhenUserInfoReceivedCommand);
        commandMap.execute(ParseUserDataCommand,userObject);
        logger.log(this,"socket server authorization completed.");

        commandMap.execute(LoadRSLCommand5);
    }
}
}
