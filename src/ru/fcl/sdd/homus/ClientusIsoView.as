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

    private var _direction:int;
    private var _state:int;
    private var _key:String;
    private var _needItemId:String;
    private var _path:Array;
    private var _skinSwf:Loader;
    private var _skin:String;

    public static const NORTH:int = 1;
    public static const EAST:int = 2;
    public static const SOUTH:int = 3;
    public static const WEST:int = 4;

    public static const START:int = 0;
    public static const WALK:int = 1;
    public static const STOP:int = 2;
    public static const STOPPED:int = 3;

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


    public function setDirection(direction:int,state:int):void
    {
        this._direction = direction;
        this._state = state;
        MovieClip(_skinSwf.content).gotoAndStop(_state*4+_direction);
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
        this.sprites = [_skinSwf.content];
        setDirection(_direction,_state);
        this.render();
    }

    private function ioErrorHandler(event:IOErrorEvent):void
    {
        trace(event.text);
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
