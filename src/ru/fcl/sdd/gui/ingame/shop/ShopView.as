/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 14:37
 */
package ru.fcl.sdd.gui.ingame.shop
{
import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

import org.aswing.AssetBackground;
import org.aswing.GridLayout;
import org.aswing.JPanel;
import org.aswing.geom.IntDimension;
import org.aswing.plaf.EmptyLayoutUIResourse;

import ru.fcl.sdd.gui.ingame.shop.events.ItemEvent;
import ru.fcl.sdd.item.Item;

import ru.fcl.sdd.item.ItemShopView;
import ru.fcl.sdd.rsl.GuiRsl;

public class ShopView extends JPanel
{
    [Inject]
    public var rsl:GuiRsl;
    private var _bg:DisplayObject;
    private var _closeButton:SimpleButton;
    private var _helpButton:SimpleButton;
    private var _itemsJPanel:JPanel;
    private var _prevItemsBtn:SimpleButton;
    private var _nextItemsBtn:SimpleButton;

    [PostConstruct]
    public function init():void
    {
        this.setLayout(new EmptyLayoutUIResourse());
        _bg = getAsset("BackgroundArt");
        this.setBackgroundDecorator(new AssetBackground(_bg));
        this.width = _bg.width;
        this.height = _bg.height;
        _closeButton = new SimpleButton(getAsset("ButtonCloseUpArt"),getAsset("ButtonCloseOverArt"),getAsset("ButtonCloseDownArt"),getAsset("ButtonCloseUpArt"));
        _closeButton.x = 722;
        _closeButton.y = 54;
        this.addChild(_closeButton);

        _prevItemsBtn =new SimpleButton(getAsset("LeftArrowBtnBigUpArt"),getAsset("LeftArrowBtnBigOverArt"),getAsset("LeftArrowBtnBigDownArt"),getAsset("LeftArrowBtnBigDownArt"));
        _prevItemsBtn.x = 13;
        _prevItemsBtn.y = 390;
        this.addChild(_prevItemsBtn);

        _itemsJPanel = new JPanel();
        var layout0:GridLayout = new GridLayout(2,3,29,16);
        _itemsJPanel.setLayout(layout0);
        _itemsJPanel.setSize(new IntDimension(637, 526));
        _itemsJPanel.x = 60;
        _itemsJPanel.y = 166;
        this.append(_itemsJPanel);

        _nextItemsBtn = new SimpleButton(getAsset("RightArrowBtnBigUpArt"),getAsset("RightArrowBtnBigOverArt"),getAsset("RightArrowBtnBigDownArt"),getAsset("RightArrowBtnBigDownArt"));
        _nextItemsBtn.x = 711;
        _nextItemsBtn.y = 390;
        this.addChild(_nextItemsBtn);
    }

    internal function set items(value:Array):void
    {
        while(_itemsJPanel.getComponentCount())
        {
            (_itemsJPanel.getComponent(0)).removeEventListener(MouseEvent.CLICK, itemClickHandler);
            _itemsJPanel.removeAt(0);
        }
        for (var i:int = 0; i < value.length; i++)
        {
            var item:Item = value[i] as Item;
            item.addEventListener(MouseEvent.CLICK, itemClickHandler);
            item.buttonMode = true;
            item.useHandCursor = true;
            _itemsJPanel.append(value[i] as Item);
        }
        _itemsJPanel.validate();
    }

    private function getAsset(value:String):DisplayObject
    {
        return rsl.getAsset("gui.ingame.shop."+value);
    }

    internal function get closeButton():SimpleButton
    {
        return _closeButton;
    }

    internal function set closeButton(value:SimpleButton):void
    {
        _closeButton = value;
    }

    public function get prevItemsBtn():SimpleButton
    {
        return _prevItemsBtn;
    }

    public function set prevItemsBtn(value:SimpleButton):void
    {
        _prevItemsBtn = value;
    }

    public function get nextItemsBtn():SimpleButton
    {
        return _nextItemsBtn;
    }

    public function set nextItemsBtn(value:SimpleButton):void
    {
        _nextItemsBtn = value;
    }

    private function itemClickHandler(event:MouseEvent):void
    {
        this.dispatchEvent(new ItemEvent(ItemEvent.ITEM_CLICKED,event.currentTarget as Item));
    }
}
}
