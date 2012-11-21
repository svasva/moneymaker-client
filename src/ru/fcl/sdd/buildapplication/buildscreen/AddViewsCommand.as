/**
 * User: Jessie
 * Date: 21.11.12
 * Time: 14:52
 */
package ru.fcl.sdd.buildapplication.buildscreen
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.buildapplication.SendServerStartApplicationCommand;

import ru.fcl.sdd.panels.MainInterfaceView;
import ru.fcl.sdd.scenes.MainIsoView;

public class AddViewsCommand extends SignalCommand
{
    [Inject]
    public var mainIsoView:MainIsoView;

    [Inject]
    public var mainInterfaceView:MainInterfaceView;

    override public function execute():void
    {
        contextView.addChild(mainIsoView);
        contextView.addChild(mainInterfaceView);

        commandMap.execute(SendServerStartApplicationCommand);
    }
}
}
