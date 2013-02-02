/**
 * User: Jessie
 * Date: 04.12.12
 * Time: 16:01
 */
package ru.fcl.sdd.item.iso
{
import as3isolib.display.IsoSprite;
import as3isolib.display.primitive.IsoBox;
import as3isolib.display.primitive.IsoPrimitive;
import as3isolib.geom.Pt;
import eDpLib.events.ProxyEvent;
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;

import flash.display.Loader;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.geom.Point;
import flash.net.URLRequest;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.pathfind.Node;

public class ItemIsoView extends IsoSprite
{
    public static const NORTH:int = 0;
    public static const EAST:int = 1;
    public static const SOUTH:int = 2;
    public static const WEST:int = 3;

    private var _skinSwf:Loader;
    private var _direction:int;
    private var _key:String;
    private var _catalogKey:String;
    private var _skin:String;
    private var _enterPoint:Point;
    private var _isCorrectEnterPoint:Boolean = false;
    private var _originalDirectionSize:Point;
    private var _clientStack:Vector.<Node>;
    private var _cashMoney:int;
    private var _isoX:int;
    private var _isoY:int;
    private var _isoBox:IsoBox = new IsoBox(); 
    private var _selectFilter:GlowFilter = new GlowFilter(0xFFEF80,1,4,4,2,1);

    public function ItemIsoView():void
    {
        _clientStack = new Vector.<Node>();
        _enterPoint = new Pt();
        _originalDirectionSize = new Point();
        _skinSwf = new Loader();
        _isCorrectEnterPoint = false;
        super();
        this.proxy.addEventListener(MouseEvent.MOUSE_OVER, proxy_mouseOver);
        this.proxy.addEventListener(MouseEvent.MOUSE_OUT, proxy_mouseOut);
    }
    
    private function proxy_mouseOut(e:ProxyEvent):void 
    {
          DisplayObject(this.sprites[0]).filters = [];
    }
    
    private function proxy_mouseOver(e:ProxyEvent):void 
    {
        trace("proxy_mouseOver");
          DisplayObject(this.sprites[0]).filters = [_selectFilter];
          
    }

    /**
     * @return enterPoint - point of face item, in Iso CellSize coords.
     */
    public function get enterPoint():Point
    {
        if (!_isCorrectEnterPoint)
        {
            _isCorrectEnterPoint = true;
            switch (direction)
            {
                case NORTH:
                {
                    _enterPoint.x = Math.floor((x + width / 2) / IsoConfig.CELL_SIZE);
                    _enterPoint.y = y / IsoConfig.CELL_SIZE - 1;
                    break;
                }
                case EAST:
                {
                    _enterPoint.x = (x + width) / IsoConfig.CELL_SIZE;
                    _enterPoint.y = Math.floor((y + length / 2) / IsoConfig.CELL_SIZE);
                    break;
                }
                case SOUTH:
                {
                    _enterPoint.x = Math.floor((x + width / 2) / IsoConfig.CELL_SIZE);
                    _enterPoint.y = (y + length) / IsoConfig.CELL_SIZE;
                    break;
                }
                case WEST:
                {
                    _enterPoint.x = x / IsoConfig.CELL_SIZE - 1;
                    _enterPoint.y = Math.floor((y + length / 2) / IsoConfig.CELL_SIZE);
                    break;
                }
            }
        }
        return _enterPoint;
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
        MovieClip(_skinSwf.content).gotoAndStop(direction + 1);
        this.sprites = [_skinSwf.content];
        this.render();
        this._isoBox.render();
    }

    private function ioErrorHandler(event:IOErrorEvent):void
    {
        trace(event.text);
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

    public function set direction(value:int):void
    {
        if (value != direction)
        {
            _isCorrectEnterPoint = false;
        }
        if (_skinSwf.content)
        {
            MovieClip(_skinSwf.content).gotoAndStop(value + 1);
        }
        for (var i:int = direction; i < value; i++)
        {
            setSize(length,width,height);
        }
        for (var j:int = direction; j > value; j--)
        {
            setSize(length,width,height);
        }
        _direction = value;
    }

    public function get direction():int
    {
        return _direction;
    }

    override public function setSize(width:Number, length:Number, height:Number):void
    {
        _isCorrectEnterPoint = false;
        super.setSize(width, length, height);
    }

    override public function set width(width:Number):void
    {
        _isCorrectEnterPoint = false;
        super.width = width;
    }

    override public function set length(length:Number):void
    {
        _isCorrectEnterPoint = false;
        super.length = length;
    }

    override public function moveTo(x:Number,y:Number,z:Number):void
    {
        _isCorrectEnterPoint = false;
        super.moveTo(x,y,z);
    }

    override public function moveBy(x:Number,y:Number,z:Number):void
    {
        _isCorrectEnterPoint = false;
        super.moveBy(x,y,z);
    }

    public function get clientStack():Vector.<Node>
    {
        return _clientStack;
    }

    public function set clientStack(value:Vector.<Node>
            ):void
    {
        _clientStack = value;
    }

    public function get cashMoney():int
    {
        return _cashMoney;
    }

    public function set cashMoney(value:int):void
    {
        _cashMoney = value;
    }
    
    public function get isoX():int 
    {
        return _isoX;
    }
    
    public function set isoX(value:int):void 
    {
        _isoX = value;
    }
    
    public function get isoY():int 
    {
        return _isoY;
    }
    
    public function set isoY(value:int):void 
    {
        _isoY = value;
    }
    
    public function get isoBox():IsoBox 
    {
        return _isoBox;
    }
    
    public function set isoBox(value:IsoBox):void 
    {
        _isoBox = value;
    }
}
}
