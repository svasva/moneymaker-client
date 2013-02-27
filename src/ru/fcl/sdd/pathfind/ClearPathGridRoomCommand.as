/**
 * User: Jessie
 * Date: 18.12.12
 * Time: 10:54
 */
package ru.fcl.sdd.pathfind
{
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.location.floors.Nodes.IsoRoom;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.item.iso.ItemIsoView;

public class ClearPathGridRoomCommand extends SignalCommand
{
    
    [Inject]
    public var pathGreed:RoomsPathGrid;

    override public function execute():void
    {
        for (var j:int = 0; j < pathGreed.numRows; j++)
        {
            for (var i:int = 0; i < pathGreed.numCols; i++)
            {
                pathGreed.setWalkable(i , j, false);
                
            }
        }
    }
}
}
