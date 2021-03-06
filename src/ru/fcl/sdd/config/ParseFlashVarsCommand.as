/**
 * User: Jessie
 * Date: 12.11.12
 * Time: 13:05
 */
package ru.fcl.sdd.config
{

import mx.core.FlexGlobals;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.config.SocialNet;

public class ParseFlashVarsCommand extends SignalCommand
{
    [Inject] public var flashVarsModel:FlashVarsModel;
    [Inject] public var platformModel:PlatformModel;

    override public function execute():void
    {
        flashVarsModel.social=FlexGlobals.topLevelApplication.flashVars.social;
        if(!flashVarsModel.social)
        {
            flashVarsModel.social= SocialNet.LOCAL;
        }

        flashVarsModel.content_url=FlexGlobals.topLevelApplication.flashVars.content_url;
        if(!flashVarsModel.content_url)
        {
            flashVarsModel.content_url= FlashVarsModel.LOCAL_CONTENT_URL;
        }

        flashVarsModel.socketUrl=FlexGlobals.topLevelApplication.flashVars.socket_url;
        if(!flashVarsModel.socketUrl)
        {
            flashVarsModel.socketUrl= FlashVarsModel.LOCAL_SOCKET_URL;
        }

        flashVarsModel.token=FlexGlobals.topLevelApplication.flashVars.token;
        if(!flashVarsModel.token)
        {
            flashVarsModel.token= FlashVarsModel.LOCAL_TOKEN;
        }

        flashVarsModel.greeting=FlexGlobals.topLevelApplication.flashVars.greeting;
        if(!flashVarsModel.greeting)
        {
            flashVarsModel.greeting= FlashVarsModel.LOCAL_GREETING;
        }
    }
}
}
