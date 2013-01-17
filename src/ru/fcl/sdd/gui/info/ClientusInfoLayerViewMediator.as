/**
 * User: Jessie
 * Date: 17.01.13
 * Time: 13:16
 */
package ru.fcl.sdd.gui.info
{
import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.homus.ClientusIsoView;

import ru.fcl.sdd.homus.HomusMouseOutSignal;

import ru.fcl.sdd.homus.HomusMouseOverSignal;

public class ClientusInfoLayerViewMediator extends Mediator
{
    [Inject]
    public var homusMouseOverSignal:HomusMouseOverSignal;

    [Inject]
    public var homusMouseOutSignal:HomusMouseOutSignal;

    override public function onRegister():void
    {
        homusMouseOverSignal.add(onHomusMouseOver);
        homusMouseOutSignal.add(onHomusMouseOut);
    }

    private function onHomusMouseOver(value:ClientusIsoView):void
    {

    }

    private function onHomusMouseOut():void
    {

    }
}
}
