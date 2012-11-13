/**
 * User: Jessie
 * Date: 12.11.12
 * Time: 13:05
 */
package ru.fcl.sdd.config
{

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;

public class ParseFlashVarsCommand extends SignalCommand
{
    [Inject] public var flashVarsModel:FlashVarsModel;

    override public function execute():void
    {
        flashVarsModel.socketUrl=contextView.loaderInfo.parameters.socket_url;
        if(!flashVarsModel.socketUrl)
        {
            flashVarsModel.socketUrl= FlashVarsModel.LOCAL_SOCKET_URL;
        }
        flashVarsModel.token=contextView.loaderInfo.parameters.token;
        if(!flashVarsModel.socketUrl)
        {
            flashVarsModel.socketUrl= FlashVarsModel.LOCAL_TOKEN;
        }

        flashVarsModel.greeting=contextView.loaderInfo.parameters.greeting;
    }
}
}
