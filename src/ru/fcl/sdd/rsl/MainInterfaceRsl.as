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
import flash.net.URLRequest;

import org.osflash.signals.ISignal;

public class MainInterfaceRsl implements IRsl,IRslLoader
{
    protected var _loadedContent:Vector.<Loader>;
    protected var _url:String;
    protected var swfNameStack:Vector.<String>;
    protected var _isReady:Boolean = false;
    [Inject(name="rsl_loaded")]
    public var rslLoadedSignal:ISignal;

    public function loadRsl(url:String):void
    {
        _url = url;
        _loadedContent = new Vector.<Loader>();

    }

    private function loadPartRsl(swfName:String):void
    {
        _loadedContent[swfName] = new Loader();
        _loadedContent[swfName].contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
        _loadedContent[swfName].load(new URLRequest(_url + swfName));
    }

    private function loader_completeHandler(event:Event):void
    {
        if (swfNameStack.length)
        {
            loadPartRsl(swfNameStack.pop());
        } else
        {
            _isReady = true;
            rslLoadedSignal.dispatch();
        }
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
