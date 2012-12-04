/**
 * User: Jessie
 * Date: 21.11.12
 * Time: 14:52
 */
package ru.fcl.sdd.buildapplication.buildscreen
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.buildapplication.SendServerStartApplicationCommand;
import ru.fcl.sdd.gui.ingame.InGameGuiView;

import ru.fcl.sdd.gui.main.MainInterfaceView;
import ru.fcl.sdd.scenes.MainIsoView;

public class AddViewsCommand extends SignalCommand
{
    [Inject]
    public var mainIsoView:MainIsoView;

    [Inject]
    public var mainInterfaceView:MainInterfaceView;

    [Inject]
    public var inGameGuiView:InGameGuiView;

    override public function execute():void
    {
        contextView.addChild(mainIsoView);
        contextView.addChild(mainInterfaceView);
        contextView.addChild(inGameGuiView);

        commandMap.execute(SendServerStartApplicationCommand);
    }
}
}
