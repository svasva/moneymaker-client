/**
 * User: Jessie
 * Date: 18.12.12
 * Time: 10:54
 */
package ru.fcl.sdd.pathfind
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.item.ItemIsoView;

public class PlacePathGridItemCommand extends SignalCommand
{
    [Inject]
    public var iso:ItemIsoView;
    [Inject]
    public var pathGreed:PathGrid;

    override public function execute():void
    {
        for (var i:int = 0; i < iso.width / IsoConfig.CELL_SIZE; i++)
        {
            for (var j:int = 0; j < iso.length / IsoConfig.CELL_SIZE; j++)
            {
                pathGreed.setWalkable(i / IsoConfig.CELL_SIZE + iso.x / IsoConfig.CELL_SIZE, j / IsoConfig.CELL_SIZE + iso.y / IsoConfig.CELL_SIZE, false);
            }
        }
    }
}
}
