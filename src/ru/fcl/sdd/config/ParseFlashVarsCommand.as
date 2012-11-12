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
        flashVarsModel.token=contextView.loaderInfo.parameters.token;
        flashVarsModel.greeting=contextView.loaderInfo.parameters.greeting;
    }
}
}
