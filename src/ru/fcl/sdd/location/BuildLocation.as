/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 12:36
 */
package ru.fcl.sdd.location
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.location.floors.CreateFloorCommand;

public class BuildLocation extends SignalCommand
{

    override public function execute():void
    {
        //TODO: Запилить логику этажей, когда сервер начнет их слать.

        commandMap.execute(CreateFloorCommand);
    }
}
}
