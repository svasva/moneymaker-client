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
import ru.fcl.sdd.states.ChangeStateSignal;
import ru.fcl.sdd.states.GameStates;

public class ShopViewMediator extends Mediator
{
    [Inject]
    public var shopView:ShopView;
    [Inject]
    public var hideShop:ChangeStateSignal;
    [Inject]
    public var itemCatalog:ItemCatalog;
    private var _collectChunker:CollectChunker;

    [PostConstruct]
    public function init():void
    {

    }

    override public function onRegister():void
    {
        _collectChunker = new CollectChunker(itemCatalog, 6);
        shopView.closeButton.addEventListener(MouseEvent.CLICK, closeClickHandler);
        shopView.prevItemsBtn.addEventListener(MouseEvent.CLICK, prevItemsClickHandler);
        shopView.nextItemsBtn.addEventListener(MouseEvent.CLICK, nextItemsClickHandler);
        _collectChunker.reset();
        shopView.items = _collectChunker.next();
        checkItemsBtnVisible();
    }

    override public function onRemove():void
    {
        shopView.closeButton.removeEventListener(MouseEvent.CLICK, closeClickHandler);
        shopView.prevItemsBtn.removeEventListener(MouseEvent.CLICK, prevItemsClickHandler);
        shopView.nextItemsBtn.removeEventListener(MouseEvent.CLICK, nextItemsClickHandler);
    }

    private function closeClickHandler(event:MouseEvent):void
    {
        hideShop.dispatch(GameStates.STATE_OUT);
    }

    private function prevItemsClickHandler(event:MouseEvent):void
    {
        shopView.items = _collectChunker.prev();
        checkItemsBtnVisible();
    }

    private function nextItemsClickHandler(event:MouseEvent):void
    {
        shopView.items = _collectChunker.next();
        checkItemsBtnVisible();
    }

    private function checkItemsBtnVisible():void
    {
        shopView.prevItemsBtn.visible = _collectChunker.hasPrev();
        shopView.nextItemsBtn.visible = _collectChunker.hasNext();
    }
}
}