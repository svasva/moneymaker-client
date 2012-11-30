/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 12:36
 */
package ru.fcl.sdd.item
{
import as3isolib.display.IsoSprite;

import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.System;
import flash.utils.setTimeout;

public class Item extends IsoSprite
{
    private var _key:String;
    private var _item_name:String;
    private var _item_type:String;
    private var _money_cost:String;
    private var _coins_cost:String;
    private var _sell_cost:String;
    private var _reputation_bonus:String;
    private var _room_id:String;
    private var _catalog_id:String;
    private var _rotation:int;
    private var _skinSwf:Loader;
    private var _skinUrl:String;


    public function get skinUrl():String
    {
        return _skinUrl;
    }

    private var temp:MovieClip;

    public function set skinUrl(value:String):void
    {
        if (value)
        {
            _skinUrl = value;
            _skinSwf = new Loader();
            _skinSwf.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            _skinSwf.load(new URLRequest(value));
        }
    }

    private function completeHandler(event:Event):void
    {
        this.sprites = [_skinSwf.content];
        this.render();
        rotation = rotation;
        //todo:Убрать тест поворота айтема.
        rotate();
    }

    private function rotate():void
    {
        setTimeout(rotate, 3000);
        if (3 == rotation)
        {
            rotation = 0;
        } else
        {
            rotation++;
        }
    }

    public function get key():String
    {
        return _key;
    }

    public function set key(value:String):void
    {
        _key = value;
    }

    public function get item_name():String
    {
        return _item_name;
    }

    public function set item_name(value:String):void
    {
        _item_name = value;
    }

    public function get item_type():String
    {
        return _item_type;
    }

    public function set item_type(value:String):void
    {
        _item_type = value;
    }

    public function get money_cost():String
    {
        return _money_cost;
    }

    public function set money_cost(value:String):void
    {
        _money_cost = value;
    }

    public function get coins_cost():String
    {
        return _coins_cost;
    }

    public function set coins_cost(value:String):void
    {
        _coins_cost = value;
    }

    public function get sell_cost():String
    {
        return _sell_cost;
    }

    public function set sell_cost(value:String):void
    {
        _sell_cost = value;
    }

    public function get reputation_bonus():String
    {
        return _reputation_bonus;
    }

    public function set reputation_bonus(value:String):void
    {
        _reputation_bonus = value;
    }


    public function get room_id():String
    {
        return _room_id;
    }

    public function set room_id(value:String):void
    {
        _room_id = value;
    }

    public function get catalog_id():String
    {
        return _catalog_id;
    }

    public function set catalog_id(value:String):void
    {
        _catalog_id = value;
    }


    public function get rotation():int
    {
        return _rotation;
    }

    public function set rotation(value:int):void
    {
        _rotation = value;
        if (_skinSwf.content)
        {
            MovieClip(_skinSwf.content).gotoAndStop(value + 1);
            for (var i:int = 0; i < value; i++)
            {
                this.setSize(this.length, this.width, this.height);
            }
        }
    }
}
}
