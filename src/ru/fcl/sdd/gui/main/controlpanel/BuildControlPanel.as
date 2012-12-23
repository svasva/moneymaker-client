/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:39
 */
package ru.fcl.sdd.gui.main.controlpanel
{
import org.osflash.signals.AboutInt;
import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;
import org.robotlegs.mvcs.SignalCommand;

public class BuildControlPanel extends SignalCommand
{
    override public function execute():void
    {
        var zoomIn:ISignal = new Signal();
        injector.mapValue(ISignal,zoomIn,"zoom_in");
        var zoomOut:ISignal = new Signal();
        injector.mapValue(ISignal,zoomOut,"zoom_out");
//        var floor:ISignal = new AboutInt();
//        injector.mapValue(ISignal,floor,"floor");

        injector.mapSingleton(ControlPanelView);
        mediatorMap.mapView(ControlPanelView, ControlPanelMediator);
    }
}
}
