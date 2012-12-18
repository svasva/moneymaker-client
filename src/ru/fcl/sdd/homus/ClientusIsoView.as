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
    private var _key:String;
    private var _needItemId:String;
    private var _path:Array;
    private var _skinSwf:Loader;
    private var _skin:String;

    public static const START_R_UP:int = 1;
    public static const START_R_DOWN:int = 2;
    public static const START_L_DOWN:int = 3;
    public static const START_L_UP:int = 4;
    public static const WALK_R_UP:int = 5;
    public static const WALK_R_DOWN:int = 6;
    public static const WALK_L_DOWN:int = 7;
    public static const WALK_L_UP:int = 8;
    public static const STOP_R_UP:int = 9;
    public static const STOP_R_DOWN:int = 10;
    public static const STOP_L_DOWN:int = 11;
    public static const STOP_L_UP:int = 12;

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

    public function set direction(value:int):void
    {
        if (_skinSwf.content)
        {
            MovieClip(_skinSwf.content).gotoAndStop(value + 1);
        }
        _direction = value;
//        render();
    }


    private function completeHandler(event:Event):void
    {
        this.sprites = [_skinSwf.content];
        this.direction = direction;
        this.render();
    }

    private function ioErrorHandler(event:IOErrorEvent):void
    {
        trace(event.text);
    }

    public function get skinSwf():Loader
    {
        return _skinSwf;
    }

    public function set skinSwf(value:Loader):void
    {
        _skinSwf = value;
    }

    public function get direction():int
    {
        return _direction;
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
