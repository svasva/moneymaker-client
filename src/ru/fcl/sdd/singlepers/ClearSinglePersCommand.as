/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:01
 */
package ru.fcl.sdd.singlepers
{
import de.polygonal.ds.HashMapValIterator;
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.location.floors.FloorItemScene;
import ru.fcl.sdd.location.floors.FloorsList;

import ru.fcl.sdd.gui.info.ShowAddReputationInfoCommand;

public class ClearSinglePersCommand extends SignalCommand
{
	[Inject]
	public var persList:SinglePersList;
	[Inject]
	public var floor:int;
	[Inject]
	public var floorList:FloorsList;
	
    override public function execute():void
    {
		var scene:FloorItemScene = floorList.get(floor) as FloorItemScene;
		var it:HashMapValIterator = persList.iterator() as HashMapValIterator;
        it.reset();		
		 while(it.hasNext())
		{	
			scene.removeChild(it.next() as SinglePersIsoView);
		}
		persList.clear();      
		
    }
}
}
