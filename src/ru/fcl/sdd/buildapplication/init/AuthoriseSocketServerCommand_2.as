/**
 * User: Jessie
 * Date: 09.11.12
 * Time: 13:45
 */
package ru.fcl.sdd.buildapplication.init
{
import ru.fcl.sdd.services.main.*;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.main.listen.CallHashMap;

public class AuthoriseSocketServerCommand_2 extends SignalCommand
{
    [Inject]
    public var sender:ISender;
    [Inject]
    public var flashVarsModel:FlashVarsModel;
    [Inject]
    public var logger:ILogger;

    override public function execute():void
    {
        logger.log(this, "socket server connect initialised, authorization...");

        var token:Object = {token:flashVarsModel.token};
        sender.send(token,GetItemListCommand_3);
    }
}
}
