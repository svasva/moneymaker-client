/**
 * User: Jessie
 * Date: 20.11.12
 * Time: 12:38
 */
package ru.fcl.sdd.rsl
{
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.SecurityDomain;

import org.osflash.signals.ISignal;

import ru.fcl.sdd.log.ILogger;

public class GuiRsl
{
    protected var _loadedContent:Loader;
    protected var _url:String;
    protected var _isReady:Boolean = false;
    [Inject(name="rsl_loaded")]
    public var rslLoadedSignal:ISignal;
    private var rsl:Object;
    [Inject]
    public var logger:ILogger;
    private const NS:String = "ru.fcl.sdd.";

    public function loadRsl(url:String):void
    {
        _url = url;
        _loadedContent = new Loader();
        var context:LoaderContext=new LoaderContext(false, new ApplicationDomain( ApplicationDomain.currentDomain ), SecurityDomain.currentDomain);
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

    public function getAsset(clazz:String):*
    {
        var ClassDefinition:Class = _loadedContent.contentLoaderInfo.applicationDomain.getDefinition(NS+clazz) as Class;
        return  new ClassDefinition();
    }

    private function loader_errorHandler(event:Event):void
    {
        _isReady = false;
        logger.error(this, "error loading rsl from url: " + _url);
    }

    public function get isReady():Boolean
    {
        return _isReady;
    }

    public function get getUpBarArtInstance():Sprite
    {
        var ClassDefinition:Class = _loadedContent.contentLoaderInfo.applicationDomain.getDefinition("ru.fcl.sdd.panels.BarArt") as Class;
        return  new ClassDefinition();
    }

    public function get getCpBarArtInstance():Sprite
    {
        var ClassDefinition:Class = _loadedContent.contentLoaderInfo.applicationDomain.getDefinition("ru.fcl.sdd.gui.MainPanel.Background") as Class;
        return  new ClassDefinition();
    }

    public function get getFriendBarBarArtInstance():Sprite
    {
        var ClassDefinition:Class = _loadedContent.contentLoaderInfo.applicationDomain.getDefinition("ru.fcl.sdd.gui.FriendBarGuiMokcup") as Class;
        return  new ClassDefinition();
    }

}
}
