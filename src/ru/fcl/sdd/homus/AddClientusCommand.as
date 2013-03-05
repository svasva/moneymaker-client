/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:00
 */
package ru.fcl.sdd.homus
{
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.location.floors.FloorItemScene;
import ru.fcl.sdd.location.floors.FloorsList;

import ru.fcl.sdd.scenes.MainIsoView;



public class AddClientusCommand extends SignalCommand
{
//    [Inject]
//    public var clientusList:ClientusList;
   
    [Inject]
    public var clientusIsoView:ClientusIsoView;
    
    [Inject]
    public var mainIsoView:MainIsoView; 
	
	[Inject]
    public var homusCounter:HomusCounterModel;
	[Inject]
    public var floorList:FloorsList;
	

    override public function execute():void
    {
//        clientusList.set(clientusIsoView.key,clientusIsoView);
        clientusIsoView.localId = homusCounter.count;
		homusCounter.count++
		mediatorMap.createMediator(clientusIsoView);
		var scene:FloorItemScene = floorList.get(1) as FloorItemScene;
        scene.addChild(clientusIsoView);
        scene.render();
    }
}
}
