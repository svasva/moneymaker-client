/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 14:37
 */
package ru.fcl.sdd.gui.ingame.shop
{
import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.display.Sprite;

import org.aswing.GridLayout;

import org.aswing.JPanel;
import org.aswing.geom.IntDimension;

import org.osflash.signals.ISignal;

import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.item.ItemShopView;

import ru.fcl.sdd.rsl.GuiRsl;

public class ShopView extends Sprite
{
    [Inject]
    public var rsl:GuiRsl;
    [Inject(name="show_shop")]
    public var closeShop:ISignal;
    private var _bg:DisplayObject;
    private var _closeButton:SimpleButton;
    private var _helpButton:SimpleButton;
    private var _itemsJPanel:JPanel;

    [PostConstruct]
    public function init():void
    {
        _bg = getAsset("BackgroundArt");
        this.addChild(_bg);

        _closeButton = new SimpleButton(getAsset("ButtonCloseUpArt"),getAsset("ButtonCloseOverArt"),getAsset("ButtonCloseDownArt"),getAsset("ButtonCloseUpArt"));
        _closeButton.x = 722;
        _closeButton.y = 54;
        this.addChild(_closeButton);
        _itemsJPanel = new JPanel();
        var layout0:GridLayout = new GridLayout();
        layout0.setRows(2);
        layout0.setColumns(3);
        layout0.setHgap(50);
        layout0.setVgap(50);
        _itemsJPanel.setLayout(layout0);
        _itemsJPanel.setSize(new IntDimension(470, 379));
        this.addChild(_itemsJPanel);
    }

    internal function set items(value:Vector.<ItemShopView>):void
    {
        _itemsJPanel.removeAll();
        for (var i:int = 0; i < value.length; i++)
        {
            var item:ItemShopView = value[i];

        }
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
}
}
