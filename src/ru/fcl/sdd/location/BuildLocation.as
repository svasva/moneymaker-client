/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 12:36
 */
package ru.fcl.sdd.location
{
import org.osflash.signals.AboutInt;
import org.osflash.signals.ISignal;
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.location.floors.ChangeFloorCommand;

import ru.fcl.sdd.location.floors.CreateFloorsCommand;

public class BuildLocation extends SignalCommand
{

    override public function execute():void
    {
        var changeFloor:ISignal = new AboutInt();
        injector.mapValue(ISignal, changeFloor, "change_floor");
        signalCommandMap.mapSignal(changeFloor, ChangeFloorCommand);
        var im
        //TODO: Запилить логику этажей, когда сервер начнет их слать.
        commandMap.execute(CreateFloorsCommand);

    }
}
}
