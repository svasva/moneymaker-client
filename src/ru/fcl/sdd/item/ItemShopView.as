/**
 * User: Jessie
 * Date: 30.11.12
 * Time: 13:56
 */
package ru.fcl.sdd.item
{
import flash.display.DisplayObject;

import org.aswing.AssetBackground;

import org.aswing.JPanel;

import ru.fcl.sdd.rsl.GuiRsl;

public class ItemShopView extends JPanel
{
    [Inject]
    public var rsl:GuiRsl;
    private var _bg:DisplayObject;


    [PostConstruct]
    public function init():void
    {
        _bg = getAsset("ItemPlaceArt");
        this.setBackgroundDecorator(new AssetBackground(_bg));
    }

    public function getAsset(value:String):DisplayObject
    {
        return rsl.getAsset("gui.ingame.shop."+value);
    }
}
}
