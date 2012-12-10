/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 12:21
 */
package ru.fcl.sdd.states.iso
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.scenes.MainIsoView;
import ru.fcl.sdd.scenes.MainIsoViewMediator;

public class EnterIsoViewCommand extends SignalCommand
{

    override public function execute():void
    {
        mediatorMap.mapView(MainIsoView, MainIsoViewMediator);
        var isoView:MainIsoView = injector.getInstance(MainIsoView);
        if (isoView.stage)
        {
            mediatorMap.createMediator(isoView);
        }
    }
}
}
