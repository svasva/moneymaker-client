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

import ru.fcl.gui.CollectChunker;

import ru.fcl.sdd.item.ItemCatalog;

public class ShopViewMediator extends Mediator
{
    [Inject]
    public var shopView:ShopView;
    [Inject(name="show_shop")]
    public var hideShop:ISignal;
    [Inject]
    public var itemCatalog:ItemCatalog;
    private var _collectChunker:CollectChunker;

    [PostConstruct]
    public function init():void
    {
        _collectChunker = new CollectChunker(itemCatalog,6);
    }

    override public function onRegister():void
    {
        shopView.closeButton.addEventListener(MouseEvent.CLICK, clickHandler);
        _collectChunker.reset();
        shopView.items = _collectChunker.next();
    }

    override public function onRemove():void
    {
        shopView.closeButton.removeEventListener(MouseEvent.CLICK, clickHandler);
    }


    private function clickHandler(event:MouseEvent):void
    {
        hideShop.dispatch()
    }
}
}