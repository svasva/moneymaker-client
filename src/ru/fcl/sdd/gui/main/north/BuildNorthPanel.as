/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:39
 */
package ru.fcl.sdd.gui.main.north
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildNorthPanel extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(NorthPanelView);
        mediatorMap.mapView(NorthPanelView,NorthPanelMediator);
    }
}
}
