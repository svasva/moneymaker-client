/**
 * User: Jessie
 * Date: 20.11.12
 * Time: 15:27
 */
package ru.fcl.sdd.rsl
{
import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;
import org.robotlegs.mvcs.SignalCommand;

public class BuildRslCommand extends SignalCommand
{
    override public function execute():void
    {
        var rslLoaded:ISignal = new Signal();
        signalCommandMap.mapSignal(rslLoaded,WhenRslLoaded,"rsl_loaded");

        injector.mapSingletonOf(IRslLoader, MainInterfaceRsl,"main_interface_rsl_loader");
    }
}
}
