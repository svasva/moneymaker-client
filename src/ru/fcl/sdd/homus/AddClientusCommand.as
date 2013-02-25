/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:00
 */
package ru.fcl.sdd.homus
{
import org.robotlegs.mvcs.SignalCommand;

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
	
	

    override public function execute():void
    {
//        clientusList.set(clientusIsoView.key,clientusIsoView);
        clientusIsoView.localId = homusCounter.count;
		homusCounter.count++
		mediatorMap.createMediator(clientusIsoView);
        mainIsoView.currentFloor.addChild(clientusIsoView);
        mainIsoView.currentFloor.render();
    }
}
}
