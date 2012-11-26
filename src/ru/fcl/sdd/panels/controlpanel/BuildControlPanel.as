/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:39
 */
package ru.fcl.sdd.panels.controlpanel
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildControlPanel extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(ControlPanelView);
        mediatorMap.mapView(ControlPanelView,ControlPanelMediator);
    }
}
}
