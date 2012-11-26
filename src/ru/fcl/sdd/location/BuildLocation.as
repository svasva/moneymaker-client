/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 12:36
 */
package ru.fcl.sdd.location
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.location.floors.CreateFloorCommand;

import ru.fcl.sdd.location.floors.FloorGrid;
import ru.fcl.sdd.location.floors.FloorsList;

public class BuildLocation extends SignalCommand
{
    [Inject]
    public var floors:FloorsList;

    override public function execute():void
    {
        var floor1Grid:FloorGrid = new FloorGrid();
        injector.mapValue(FloorGrid,floor1Grid,"floor_1");

        //TODO: Запилить логику этажей, когда сервер начнет их слать.
        var floorId:String = "1";
        floors.set(1,floor1Grid);

        commandMap.execute(CreateFloorCommand,floorId);
    }
}
}
