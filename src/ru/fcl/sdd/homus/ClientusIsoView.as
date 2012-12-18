/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 12:05
 */
package ru.fcl.sdd.homus
{
import as3isolib.display.IsoSprite;

import flash.display.Loader;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

public class ClientusIsoView extends IsoSprite
{
    private var _skinSwf:Loader;
    private var _rotationIso:int;
    private var _key:String;
    private var _needItemId:String;
    private var _skin:String;
    private var _path:Array;

    public function ClientusIsoView()
    {

        _skinSwf = new Loader();
        skin = "./art/Man02Animations.swf";
        super();
    }

    [PostConstruct]
    public function init():void
    {
        setSize(100, 100, 100);
    }
    /**
     * Load skin from url.
     * @param value - skin swf url.
     */
    public function set skin(value:String):void
    {
        //TODO:грузить скины руками, по мере необходимости.
        _skin = value;
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
            }
            else
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

    public function get needItemId():String
    {
        return _needItemId;
    }

    public function set needItemId(value:String):void
    {
        _needItemId = value;
    }

    public function get key():String
    {
        return _key;
    }

    public function set key(value:String):void
    {
        _key = value;
    }
}
}
