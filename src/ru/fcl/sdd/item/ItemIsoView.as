/**
 * User: Jessie
 * Date: 04.12.12
 * Time: 16:01
 */
package ru.fcl.sdd.item
{
import as3isolib.display.IsoSprite;

import flash.display.Loader;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

public class ItemIsoView  extends IsoSprite
{
    private var _skinSwf:Loader;
    private var _rotationIso:int;
    private var _key:String;
    private var _catalogKey:String;

    public function ItemIsoView():void
    {
        _skinSwf = new Loader();
        super();
    }

    public function get key():String
    {
        return _key;
    }

    public function set key(value:String):void
    {
        _key = value;
    }

    public function get catalogKey():String
    {
        return _catalogKey;
    }

    public function set catalogKey(value:String):void
    {
        _catalogKey = value;
    }


    /**
     * Load skin from url.
     * @param value - skin swf url.
     */
    public function set skin(value:String):void
    {
        //TODO:грузить скины руками, по мере необходимости.
        if (value)
        {
            _skinSwf.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            _skinSwf.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            _skinSwf.load(new URLRequest(value));
        }
    }

    private function completeHandler(event:Event):void
    {
        MovieClip(_skinSwf.content).gotoAndStop(rotationIso + 1);
        this.sprites = [_skinSwf.content];
        this.render();
    }

    private function ioErrorHandler(event:IOErrorEvent):void
    {
        trace(event.text);
    }

    public function set rotationIso(value:int):void
    {
        if (_skinSwf.content)
        {
            MovieClip(_skinSwf.content).gotoAndStop(value + 1);

            if (rotationIso > value)
            {
                for (var i:int = _rotationIso; i < value; i++)
                {
                    this.setSize(this.length, this.width, this.height);
                }
            }else
            {
                for (var j:int = _rotationIso; j > value; j--)
                {
                    this.setSize(this.length, this.width, this.height);
                }
            }
        }
        _rotationIso = value;
    }

    public function get skinSwf():Loader
    {
        return _skinSwf;
    }

    public function set skinSwf(value:Loader):void
    {
        _skinSwf = value;
    }


    public function get rotationIso():int
    {
        return _rotationIso;
    }

}
}
