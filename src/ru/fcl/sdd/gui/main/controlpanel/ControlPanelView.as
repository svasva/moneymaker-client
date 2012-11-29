/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.controlpanel
{
import flash.display.SimpleButton;
import flash.display.Sprite;

import ru.fcl.sdd.rsl.GuiRsl;

public class ControlPanelView extends Sprite
{
    [Inject]
    public var rsl:GuiRsl;


    private var _bg:Sprite;
    private var _shopBtn:SimpleButton;


    [PostConstruct]
    public function init():void
    {
        _bg = rsl.getCpBarArtInstance;
        this.addChild(_bg);

        _shopBtn = new SimpleButton( getAsset("ButtonShopUpArt"),getAsset("ButtonShopOverArt"),getAsset("ButtonShopDownArt"),getAsset("ButtonShopDownArt"));
        _shopBtn.y = 43;
        this.addChild(_shopBtn);
    }

    private function getAsset(clazz:String):*
    {
        return rsl.getAsset("gui.MainPanel."+clazz);
    }

    private function draw():void
    {

    }

    public function get shopBtn():SimpleButton
    {
        return _shopBtn;
    }

    public function set shopBtn(value:SimpleButton):void
    {
        _shopBtn = value;
    }
}
}
