/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.controlpanel
{
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.ISignal;

import org.robotlegs.mvcs.Mediator;

public class ControlPanelMediator extends Mediator
{
    [Inject]
    public var view:ControlPanelView;
    [Inject(name="show_shop")]
    public var showShop:ISignal;

    override public function onRegister():void
    {
        view.shopBtn.addEventListener(MouseEvent.CLICK, shopBtn_clickHandler);
    }

    private function shopBtn_clickHandler(event:MouseEvent):void
    {
        showShop.dispatch();
    }
}
}
