/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 15:07
 */
package ru.fcl.sdd.gui.ingame.shop
{
import flash.events.MouseEvent;

import org.osflash.signals.ISignal;
import org.robotlegs.mvcs.Mediator;

public class ShopViewMediator extends Mediator
{
    [Inject]
    public var shopView:ShopView;
    [Inject(name="show_shop")]
    public var hideShop:ISignal;

    override public function onRegister():void
    {
        shopView.closeButton.addEventListener(MouseEvent.CLICK, clickHandler);
    }

    override public function onRemove():void
    {
        shopView.closeButton.removeEventListener(MouseEvent.CLICK, clickHandler);
    }


    private function clickHandler(event:MouseEvent):void
    {
        //todo: Разобраться, почему диспатчится 2 раза.
        hideShop.dispatch()
    }
}
}