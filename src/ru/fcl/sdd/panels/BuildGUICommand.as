/**
 * User: Jessie
 * Date: 21.11.12
 * Time: 14:39
 */
package ru.fcl.sdd.panels
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.panels.north.BuildNorthPanel;
import ru.fcl.sdd.panels.north.NorthPanelView;

public class BuildGUICommand extends SignalCommand
{
    override public function execute():void
    {
        commandMap.execute(BuildNorthPanel);

        injector.mapSingleton(MainInterfaceView);

        var mainInterfaceView:MainInterfaceView = injector.getInstance(MainInterfaceView);

        var northPanelView:NorthPanelView = injector.getInstance(NorthPanelView);
        mainInterfaceView.addChild(northPanelView);
    }
}
}
