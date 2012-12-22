/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.controlpanel
{
import flash.events.MouseEvent;

import org.osflash.signals.ISignal;

import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.states.ChangeStateSignal;
import ru.fcl.sdd.states.GameStates;

public class ControlPanelMediator extends Mediator
{
    [Inject]
    public var view:ControlPanelView;
    [Inject]
    public var changeState:ChangeStateSignal;

    [Inject(name="zoom_in")]
    public var zoomIn:ISignal;
    [Inject(name="zoom_out")]
    public var zoomOut:ISignal;

    [Inject(name="floor_up")]
    public var floorUp:ISignal;
    [Inject(name="floor_down")]
    public var floorDown:ISignal;

    override public function onRegister():void
    {
        view.shopBtn.addEventListener(MouseEvent.CLICK, shopBtn_clickHandler);
        view.floorDownBtn.addEventListener(MouseEvent.CLICK, floorUpBtn_clickHandler);
        view.floorUpBtn.addEventListener(MouseEvent.CLICK, floorDownBtn_clickHandler);
        view.zoomInBtn.addEventListener(MouseEvent.CLICK, zoomIn_clickHandler);
        view.zoomOutBtn.addEventListener(MouseEvent.CLICK, zoomOut_clickHandler);
    }

    override public function onRemove():void
    {
        view.shopBtn.removeEventListener(MouseEvent.CLICK, shopBtn_clickHandler);
        view.floorDownBtn.removeEventListener(MouseEvent.CLICK, floorUpBtn_clickHandler);
        view.floorUpBtn.removeEventListener(MouseEvent.CLICK, floorDownBtn_clickHandler);
        view.zoomInBtn.removeEventListener(MouseEvent.CLICK, zoomIn_clickHandler);
        view.zoomOutBtn.removeEventListener(MouseEvent.CLICK, zoomOut_clickHandler);
    }

    private function shopBtn_clickHandler(event:MouseEvent):void
    {
        changeState.dispatch(GameStates.IN_SHOP);
    }


    private function floorUpBtn_clickHandler(event:MouseEvent):void
    {
        floorUp.dispatch();
    }

    private function floorDownBtn_clickHandler(event:MouseEvent):void
    {
        floorDown.dispatch();
    }

    private function zoomIn_clickHandler(event:MouseEvent):void
    {
        zoomIn.dispatch();
    }

    private function zoomOut_clickHandler(event:MouseEvent):void
    {
        zoomOut.dispatch();
    }
}
}
