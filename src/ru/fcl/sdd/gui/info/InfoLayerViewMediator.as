/**
 * User: Jessie
 * Date: 17.01.13
 * Time: 13:16
 */
package ru.fcl.sdd.gui.info
{
import as3isolib.geom.Pt;

import flash.events.Event;
import flash.geom.Point;
import org.robotlegs.mvcs.Mediator;


import ru.fcl.sdd.gui.info.icons.Clock;
import ru.fcl.sdd.homus.ClientusIsoView;
import ru.fcl.sdd.homus.HomusMouseOutSignal;
import ru.fcl.sdd.homus.HomusMouseOverSignal;
import ru.fcl.sdd.scenes.MainIsoView;

public class InfoLayerViewMediator extends Mediator
{
    [Inject]
    public var infoView:InfoLayerView;

    [Inject]
    public var mainIsoView:MainIsoView;
    [Inject]
    public var homusMouseOverSignal:HomusMouseOverSignal;
    [Inject]
    public var homusMouseOutSignal:HomusMouseOutSignal;

    private var clientusView:ClientusIsoView;
    private var clock:Clock = new Clock();
    private var screenPt:Point;
    private var isoPt:Pt;


    override public function onRegister():void
    {
        screenPt = new Point();
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
        screenPt = mainIsoView.isoToLocal(isoPt);
        clock.x = screenPt.x-clock.width/2;
        clock.y = screenPt.y-clientusView.height*mainIsoView.currentZoom-80;
        clock.addEventListener(Event.ENTER_FRAME, clock_enterFrameHandler);
    }

    private function onHomusMouseOut():void
    {
        clientusView = null;
        infoView.removeChild(clock);
        clock.removeEventListener(Event.ENTER_FRAME, clock_enterFrameHandler);
    }

    private function clock_enterFrameHandler(event:Event):void
    {
        clock.count = Math.round(clientusView.leaveTimer.currentCount*100/clientusView.maxWaiTime);
        isoPt.x = clientusView.x;
        isoPt.y = clientusView.y;
        isoPt.z = clientusView.z;
        screenPt = mainIsoView.isoToLocal(isoPt);
        clock.x = screenPt.x-clock.width/2;
        clock.y = screenPt.y-clientusView.height*mainIsoView.currentZoom-80;
    }


}
}
