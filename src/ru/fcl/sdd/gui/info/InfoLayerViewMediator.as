/**
 * User: Jessie
 * Date: 17.01.13
 * Time: 13:16
 */
package ru.fcl.sdd.gui.info
{
import as3isolib.geom.IsoMath;
import as3isolib.geom.Pt;

import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.gui.info.icons.Clock;

import ru.fcl.sdd.homus.ClientusIsoView;

import ru.fcl.sdd.homus.HomusMouseOutSignal;

import ru.fcl.sdd.homus.HomusMouseOverSignal;

public class InfoLayerViewMediator extends Mediator
{
    [Inject]
    public var homusMouseOverSignal:HomusMouseOverSignal;

    [Inject]
    public var homusMouseOutSignal:HomusMouseOutSignal;

    [Inject]
    public var infoView:InfoLayerView;

    private var clientusView:ClientusIsoView;
    private var clock:Clock = new Clock();
    private var screenPt:Pt;
    private var isoPt:Pt;

    override public function onRegister():void
    {
        screenPt = new Pt();
        isoPt = new Pt();
        clock = new Clock();
        homusMouseOverSignal.add(onHomusMouseOver);
        homusMouseOutSignal.add(onHomusMouseOut);
    }

    private function onHomusMouseOver(value:ClientusIsoView):void
    {
        clientusView = value;
        infoView.addChild(clock);
        isoPt.x = clientusView.x;
        isoPt.y = clientusView.y;
        isoPt.z = clientusView.z;
        screenPt = IsoMath.isoToScreen(isoPt);
        clock.x = clientusView.x;
        clock.y = clientusView.y;
    }

    private function onHomusMouseOut():void
    {
        clientusView = null;
        infoView.removeChild(clock);
    }
}
}
