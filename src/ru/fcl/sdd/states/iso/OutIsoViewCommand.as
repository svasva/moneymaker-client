/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 12:21
 */
package ru.fcl.sdd.states.iso
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.scenes.MainIsoView;

public class OutIsoViewCommand extends SignalCommand
{

    override public function execute():void
    {
        mediatorMap.removeMediatorByView(injector.getInstance(MainIsoView));
        mediatorMap.unmapView(MainIsoView);
    }
}
}
