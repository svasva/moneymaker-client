/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.panels.controlpanel
{
import flash.display.SimpleButton;
import flash.display.Sprite;

import ru.fcl.sdd.rsl.MainInterfaceRsl;

public class ControlPanelView extends Sprite
{
    [Inject(name="main_interface_rsl_loader")]
    public var rsl:MainInterfaceRsl;


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
        return rsl.getAsset("MainPanel."+clazz);
    }

    private function draw():void
    {

    }
}
}
