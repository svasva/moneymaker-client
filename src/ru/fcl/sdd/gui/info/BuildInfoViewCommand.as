/**
 * User: Jessie
 * Date: 17.01.13
 * Time: 14:10
 */
package ru.fcl.sdd.gui.info
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildInfoViewCommand extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(InfoLayerView);
        mediatorMap.mapView(InfoLayerView,InfoLayerViewMediator);
    }
}
}
