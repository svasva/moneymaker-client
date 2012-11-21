/**
 * User: Jessie
 * Date: 20.11.12
 * Time: 11:45
 */
package ru.fcl.sdd.buildapplication.init
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.config.SocialNet;
import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.rsl.IRslLoader;
import ru.fcl.sdd.rsl.MainInterfaceRsl;

public class LoadRSLCommand5 extends SignalCommand
{
    [Inject(name="main_interface_rsl_loader")]
    public var rsl:MainInterfaceRsl;
    [Inject]
    public var flashVars:FlashVarsModel;
    [Inject]
    public var logger:ILogger;

    override public function execute():void
    {
        switch (flashVars.social)
        {
            case (SocialNet.LOCAL):
            {
                logger.log(this, "try load local rsl");
                rsl.loadRsl("./rsl/local/library.swf");
                break;
            }
            case (SocialNet.VKONTAKTE):
            {
                logger.log(this, "try load remote rsl for vk.ru");
                //TODO: get url remote rsl & load it.
                break;
            }
            case (SocialNet.MAIL):
            {
                logger.log(this, "try load remote rsl for mail.ru");
                //TODO: get url remote rsl & load it.
                break;
            }
            default:
            {
                logger.error(this, "unknown social net, try load default rsl for vk.ru");
                break;
            }
        }
    }
}
}
