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

import org.osflash.signals.ISignal;

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

    [PostConstruct]
    public function init():void
    {
        _bg = getAsset("BackgroundArt");
        this.addChild(_bg);

        _closeButton = new SimpleButton(getAsset("ButtonCloseUpArt"),getAsset("ButtonCloseOverArt"),getAsset("ButtonCloseDownArt"),getAsset("ButtonCloseUpArt"));
        _closeButton.x = 722;
        _closeButton.y = 54;
        this.addChild(_closeButton);
    }

    private function getAsset(value:String):DisplayObject
    {
        return rsl.getAsset("gui.ingame.shop."+value);
    }

    public function get closeButton():SimpleButton
    {
        return _closeButton;
    }

    public function set closeButton(value:SimpleButton):void
    {
        _closeButton = value;
    }
}
}
