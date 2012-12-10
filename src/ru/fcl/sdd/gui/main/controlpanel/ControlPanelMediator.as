/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.controlpanel
{
import flash.events.MouseEvent;

import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.states.ChangeStateSignal;
import ru.fcl.sdd.states.GameStates;

public class ControlPanelMediator extends Mediator
{
    [Inject]
    public var view:ControlPanelView;
    [Inject]
    public var changeState:ChangeStateSignal;

    override public function onRegister():void
    {
        view.shopBtn.addEventListener(MouseEvent.CLICK, shopBtn_clickHandler);
    }

    private function shopBtn_clickHandler(event:MouseEvent):void
    {
        changeState.dispatch(GameStates.IN_SHOP);
    }
}
}
