/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:39
 */
package ru.fcl.sdd.panels.north
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildNorthPanel extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingletonOf(INorthPanelView, NorthPanelView);
        mediatorMap.mapView(INorthPanelView,NorthPanelMediator);
    }
}
}
