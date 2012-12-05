/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 14:37
 */
package ru.fcl.sdd.gui.ingame.shop
{
import flash.display.DisplayObject;
import flash.display.SimpleButton;

import org.aswing.AssetBackground;

import org.aswing.GridLayout;

import org.aswing.JPanel;
import org.aswing.geom.IntDimension;
import org.aswing.plaf.EmptyLayoutUIResourse;

import org.osflash.signals.ISignal;

import ru.fcl.sdd.item.ItemShopView;

import ru.fcl.sdd.rsl.GuiRsl;

public class ShopView extends JPanel
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
        this.setLayout(new EmptyLayoutUIResourse());
        _bg = getAsset("BackgroundArt");
        this.setBackgroundDecorator(new AssetBackground(_bg));
        this.width = _bg.width;
        this.height = _bg.height;
        _closeButton = new SimpleButton(getAsset("ButtonCloseUpArt"),getAsset("ButtonCloseOverArt"),getAsset("ButtonCloseDownArt"),getAsset("ButtonCloseUpArt"));
        _closeButton.x = 722;
        _closeButton.y = 54;
        this.addChild(_closeButton);
        _itemsJPanel = new JPanel();
        var layout0:GridLayout = new GridLayout(2,3,0,0);
        layout0.setHgap(50);
        layout0.setVgap(20);
        _itemsJPanel.setLayout(layout0);
        _itemsJPanel.setSize(new IntDimension(670, 560));
        _itemsJPanel.x = 35;
        _itemsJPanel.y = 140;
        this.append(_itemsJPanel);
    }

    internal function set items(value:Array):void
    {
        _itemsJPanel.removeAll();
        for (var i:int = 0; i < value.length; i++)
        {
            var item:ItemShopView = new ItemShopView();
            item = value[i] as ItemShopView;
            _itemsJPanel.append(value[i] as ItemShopView);
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
}
}
