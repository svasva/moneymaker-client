/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 14:37
 */
package ru.fcl.sdd.gui.ingame.shop
{
import flash.display.DisplayObject;
import flash.display.Sprite;

import ru.fcl.sdd.rsl.GuiRsl;

public class ShopView extends Sprite
{
    [Inject]
    public var rsl:GuiRsl;
    private var bg:DisplayObject;

    [PostConstruct]
    public function init():void
    {
        bg = getAsset("BackgroundArt");
        this.addChild(bg);
    }

    private function getAsset(value:String):DisplayObject
    {
        return rsl.getAsset("gui.ingame.shop."+value);
    }
}
}
