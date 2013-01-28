/**
 * User: Jessie
 * Date: 20.11.12
 * Time: 11:45
 */
package ru.fcl.sdd.buildapplication
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.config.SocialNet;
import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.rsl.GuiRsl;
import ru.fcl.sdd.rsl.WhenRemoteRsUrlReceiveCommand;
import ru.fcl.sdd.services.main.ISender;

public class LoadRSLCommand_3 extends SignalCommand
{
    [Inject]
    public var rsl:GuiRsl;
    [Inject]
    public var flashVars:FlashVarsModel;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var sender:ISender;

    override public function execute():void
    {
        switch (flashVars.social)
        {
            case (SocialNet.LOCAL):
            {
                logger.log(this, "try load local rsl");
                commandMap.execute(WhenRemoteRsUrlReceiveCommand,{response:['./rsl/local/library.swf']});
                break;
            }
            case (SocialNet.VKONTAKTE):
            {
                logger.log(this, "try load remote rsl for vk.ru");
                sender.send({command:"getFlashLibs"},WhenRemoteRsUrlReceiveCommand);
                break;
            }
            case (SocialNet.MAIL):
            {
                logger.log(this, "try load remote rsl for mail.ru");
                sender.send({command:"getFlashLibs"},WhenRemoteRsUrlReceiveCommand);
                break;
            }
            default:
            {
                logger.error(this, "unknown social net, try load default rsl for vk.ru");
                sender.send({command:"getFlashLibs"},WhenRemoteRsUrlReceiveCommand);
                break;
            }
        }
    }
}
}
