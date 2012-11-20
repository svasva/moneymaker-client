/**
 * User: Jessie
 * Date: 20.11.12
 * Time: 15:14
 */
package ru.fcl.sdd.rsl
{
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

public class RslLoader implements IRslLoader
{
    protected var _loadedContent:Vector.<Loader>;
    protected var _url:String;
    protected var swfNameStack:Vector.<String>;
    protected var _isReady:Boolean = false;

    public function loadRsl(url:String, swfNameStack:Vector.<String>):void
    {
        _url = url;
        _loadedContent = new Vector.<Loader>();
        this.swfNameStack = swfNameStack;

        if (_url.lastIndexOf("/") != _url.length - 1)
        {
            _url += "/";
        }
        loadPartRsl(swfNameStack.pop());
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
        }
    }
}
}
