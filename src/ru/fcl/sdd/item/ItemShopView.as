/**
 * User: Jessie
 * Date: 30.11.12
 * Time: 13:56
 */
package ru.fcl.sdd.item
{
import flash.display.DisplayObject;
import flash.display.Loader;

import org.aswing.AssetBackground;

import org.aswing.JPanel;

import ru.fcl.sdd.rsl.GuiRsl;

public class ItemShopView extends JPanel
{
    [Inject]
    public var rsl:GuiRsl;
    private var _bg:DisplayObject;
    private var _iconSwf:Loader;
    private var _iconUrl:String;


    [PostConstruct]
    public function init():void
    {
        _bg = getAsset("ItemPlaceArt");
        this.setBackgroundDecorator(new AssetBackground(_bg));
        this.width = _bg.width;
        this.height = _bg.height;
    }

    public function getAsset(value:String):DisplayObject
    {
        return rsl.getAsset("gui.ingame.shop."+value);
    }

    public function get iconSwf():Loader
    {
        return _iconSwf;
    }

    public function set iconSwf(value:Loader):void
    {
        _iconSwf = value;
    }

    public function get iconUrl():String
    {
        return _iconUrl;
    }

    public function set iconUrl(value:String):void
    {
        _iconUrl = value;
    }
}
}
