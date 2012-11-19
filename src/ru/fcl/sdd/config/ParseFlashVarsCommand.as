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

public class ParseFlashVarsCommand extends SignalCommand
{
    [Inject] public var flashVarsModel:FlashVarsModel;

    override public function execute():void
    {
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
    }
}
}
