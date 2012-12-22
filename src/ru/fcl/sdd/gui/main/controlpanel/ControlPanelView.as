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
    private var _floorDownBtn:SimpleButton;
    private var _floorUpBtn:SimpleButton;
    private var _zoomInBtn:SimpleButton;
    private var _zoomOutBtn:SimpleButton;


    [PostConstruct]
    public function init():void
    {
        _bg = rsl.getCpBarArtInstance;
        this.addChild(_bg);

        _shopBtn = new SimpleButton( getAsset("ButtonShopUpArt"),getAsset("ButtonShopOverArt"),getAsset("ButtonShopDownArt"),getAsset("ButtonShopDownArt"));
        _shopBtn.y = 43;
        this.addChild(_shopBtn);

        _floorDownBtn = new SimpleButton( getAsset("ButtonDownUpArt"),getAsset("ButtonDownOverArt"),getAsset("ButtonDownDownArt"),getAsset("ButtonDownDownArt"));
        _floorDownBtn.x = 47;
        _floorDownBtn.y = 146;
        this.addChild(_floorDownBtn);

        _floorUpBtn = new SimpleButton( getAsset("ButtonUpUpArt"),getAsset("ButtonUpOverArt"),getAsset("ButtonUpDownArt"),getAsset("ButtonUpDownArt"));
        _floorUpBtn.y = 102;
        this.addChild(_floorUpBtn);

        _zoomInBtn = new SimpleButton( getAsset("ButtonIncUpArt"),getAsset("ButtonIncOverArt"),getAsset("ButtonIncDownArt"),getAsset("ButtonIncDownArt"));
        _zoomInBtn.x = 160;
        _zoomInBtn.y = 180;
        this.addChild(_zoomInBtn);

        _zoomOutBtn = new SimpleButton( getAsset("ButtonDecUpArt"),getAsset("ButtonDecOverArt"),getAsset("ButtonDecDownArt"),getAsset("ButtonDecDownArt"));
        _zoomOutBtn.x = 160;
        _zoomOutBtn.y = 202;
        this.addChild(_zoomOutBtn);
    }

    private function getAsset(clazz:String):*
    {
        return rsl.getAsset("gui.main.controlpanel."+clazz);
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

    public function get floorDownBtn():SimpleButton
    {
        return _floorDownBtn;
    }

    public function set floorDownBtn(value:SimpleButton):void
    {
        _floorDownBtn = value;
    }

    public function get floorUpBtn():SimpleButton
    {
        return _floorUpBtn;
    }

    public function set floorUpBtn(value:SimpleButton):void
    {
        _floorUpBtn = value;
    }

    public function get zoomInBtn():SimpleButton
    {
        return _zoomInBtn;
    }

    public function set zoomInBtn(value:SimpleButton):void
    {
        _zoomInBtn = value;
    }

    public function get zoomOutBtn():SimpleButton
    {
        return _zoomOutBtn;
    }

    public function set zoomOutBtn(value:SimpleButton):void
    {
        _zoomOutBtn = value;
    }
}
}
