/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:39
 */
package ru.fcl.sdd.gui.main.controlpanel
{
import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;
import org.robotlegs.mvcs.SignalCommand;

public class BuildControlPanel extends SignalCommand
{
    override public function execute():void
    {


        injector.mapSingleton(ControlPanelView);
        mediatorMap.mapView(ControlPanelView, ControlPanelMediator);
    }
}
}