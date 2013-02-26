/**
 * User: Jessie
 * Date: 18.12.12
 * Time: 10:54
 */
package ru.fcl.sdd.pathfind
{
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.location.floors.Nodes.IsoRoom;
import ru.fcl.sdd.location.room.Room;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.item.iso.ItemIsoView;

public class PlacePathGridRoomCommand extends SignalCommand
{
    
    [Inject]
    public var pathGreed:RoomsPathGrid;

	[Inject]
    public var room:Object;
	
    override public function execute():void
    {
        for (var j:int = 1; j < 10; j++)
        {
            for (var i:int = 1; i < 10; i++)
            {
                pathGreed.setWalkable(i + int(room.x), j + int(room.y), true);
				pathGreed.getNode(i + int(room.x), j + int(room.y)).data = room.id;  
                
            }
        }
    }
}
}
