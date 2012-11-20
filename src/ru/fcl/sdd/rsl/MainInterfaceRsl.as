/**
 * User: Jessie
 * Date: 20.11.12
 * Time: 12:38
 */
package ru.fcl.sdd.rsl
{
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

import org.osflash.signals.ISignal;

import ru.fcl.sdd.log.ILogger;

public class MainInterfaceRsl implements IRsl,IRslLoader
{
    protected var _loadedContent:Loader;
    protected var _url:String;
    protected var _isReady:Boolean = false;
    [Inject(name="rsl_loaded")]
    public var rslLoadedSignal:ISignal;

    [Inject]
    public var logger:ILogger;

    public function loadRsl(url:String):void
    {
        _url = url;
        _loadedContent = new Loader();
        _loadedContent.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
        _loadedContent.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
        _loadedContent.load(new URLRequest(url));
    }

    private function loader_completeHandler(event:Event):void
    {
        _isReady = true;
        logger.log(this, "rsl now is loaded from url: " + _url);
        rslLoadedSignal.dispatch();
    }

    private function loader_errorHandler(event:Event):void
    {
        _isReady = false
        logger.error(this, "error loading rsl from url: " + _url);
    }

    public function get isReady():Boolean
    {
        return _isReady;
    }

    public function get buttonGoldDownArtInstance():Sprite
    {
        return null;
    }

    public function get buttonGoldOverArtInstance():Sprite
    {
        return null;
    }

    public function get buttonGoldUpArtInstance():Sprite
    {
        return null;
    }

    public function get buttonLvlDownArtInstance():Sprite
    {
        return null;
    }

    public function get buttonLvlOverArtInstance():Sprite
    {
        return null;
    }

    public function get buttonLvlUpArtInstance():Sprite
    {
        return null;
    }

    public function get buttonMoneyDownArtInstance():Sprite
    {
        return null;
    }

    public function get buttonMoneyOverArtInstance():Sprite
    {
        return null;
    }

    public function get buttonMoneyUpArtInstance():Sprite
    {
        return null;
    }

    public function get buttonReputationDownArtInstance():Sprite
    {
        return null;
    }

    public function get buttonReputationOverArtInstance():Sprite
    {
        return null;
    }

    public function get buttonReputationUpArtInstance():Sprite
    {
        return null;
    }

    public function get reputation1ArtInstance():Sprite
    {
        return null;
    }

    public function get reputation2ArtInstance():Sprite
    {
        return null;
    }

    public function get reputation3ArtInstance():Sprite
    {
        return null;
    }

    public function get reputation4ArtInstance():Sprite
    {
        return null;
    }

    public function get barArtInstance():Sprite
    {
        return null;
    }

}
}
