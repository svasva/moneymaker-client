/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:00
 */
package ru.fcl.sdd.singlepers
{
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.location.floors.FloorItemScene;
import ru.fcl.sdd.location.floors.FloorsList;

import ru.fcl.sdd.scenes.MainIsoView;



public class AddSinglePersCommand extends SignalCommand
{
	
    [Inject]
    public var singlePersIsoView:SinglePersIsoView; 
	[Inject]
    public var floorList:FloorsList;
	

    override public function execute():void
    {	
		var scene:FloorItemScene = floorList.get(1) as FloorItemScene;
        scene.addChild(singlePersIsoView);
        scene.render();
    }
}
}
