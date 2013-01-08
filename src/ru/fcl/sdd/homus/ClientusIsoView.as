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
    private var _operations:Array;
    private var _skinSwf:Loader;
    private var _skin:String;
    private var _currentFrame:int = 1;

    public static const NORTH:int = 1;
    public static const EAST:int = 2;
    public static const SOUTH:int = 3;
    public static const WEST:int = 4;

    public static const WALK:int = 0;
    public static const STOP:int = 1;


    public function ClientusIsoView()
    {
        _operations = [];
        _skinSwf = new Loader();
        skin = "./art/Man02Animations.swf";
        super();
    }

    [PostConstruct]
    public function init():void
    {

    }


    public function setDirection(direction:int, state:int):void
    {
        this._direction = direction;
        this._state = state;
        if (_skinSwf.content)
        {
            if (_state < 1)
            {
                if (MovieClip(_skinSwf.content).currentFrame < 5)
                {
                    _currentFrame = MovieClip(MovieClip(_skinSwf.content).getChildAt(0)).currentFrame;
                    trace(_currentFrame);
                }
                MovieClip(_skinSwf.content).gotoAndStop(_direction);
                if (_currentFrame < 24)
                {
                    MovieClip(MovieClip(_skinSwf.content).getChildAt(0)).gotoAndPlay(_currentFrame + 1);
                }
                else
                {
                    MovieClip(MovieClip(_skinSwf.content).getChildAt(0)).gotoAndPlay(1);
                }
            }
            else
            {
                MovieClip(_skinSwf.content).gotoAndStop(_direction + 4);
            }
        }
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
        setDirection(_direction, _state);
        this.render();
    }

    private function ioErrorHandler(event:IOErrorEvent):void
    {
        trace(event.text);
    }

    public function get operations():Array
    {
        return _operations;
    }

    public function set operations(value:Array):void
    {
        _operations = value;
    }

    public function get key():String
    {
        return _key;
    }

    public function set key(value:String):void
    {
        _key = value;
    }

    public function get skin():String
    {
        return _skin;
    }
}
}
