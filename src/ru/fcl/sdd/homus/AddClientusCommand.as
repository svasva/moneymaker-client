/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:00
 */
package ru.fcl.sdd.homus
{
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.location.floors.FloorItemScene;

import ru.fcl.sdd.location.floors.Floor1Scene;

public class AddClientusCommand extends SignalCommand
{
//    [Inject]
//    public var clientusList:ClientusList;
    [Inject]
    public var currentFloor:Floor1Scene;
    [Inject]
    public var clientusIsoView:ClientusIsoView;
    
    [Inject]
    public var floor:FloorItemScene;

    override public function execute():void
    {
//        clientusList.set(clientusIsoView.key,clientusIsoView);
        mediatorMap.createMediator(clientusIsoView);
        floor.addChild(clientusIsoView);
        floor.render();
    }
}
}
