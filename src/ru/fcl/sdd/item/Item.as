/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 12:36
 */
package ru.fcl.sdd.item
{
import flash.geom.Point;

public class Item
{
    private var _id:String;
    private var _name: String;
    private var _item_type: String;
    private var _money_cost: String;
    private var _coins_cost: String;
    private var _sell_cost:String;
    private var _size:Point;
    private var _position:Point;
    private var _reputation_bonus:String;
    private var _room_id:String;
    private var _catalog_id:String;
    private var _enterPoint:Point;
    private var _rotation:int;

    public function get id():String
    {
        return _id;
    }

    public function set id(value:String):void
    {
        _id = value;
    }

    public function get name():String
    {
        return _name;
    }

    public function set name(value:String):void
    {
        _name = value;
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

    public function get size():Point
    {
        return _size;
    }

    public function set size(value:Point):void
    {
        _size = value;
    }

    public function get position():Point
    {
        return _position;
    }

    public function set position(value:Point):void
    {
        _position = value;
    }

    public function get catalog_id():String
    {
        return _catalog_id;
    }

    public function set catalog_id(value:String):void
    {
        _catalog_id = value;
    }

    public function get enterPoint():Point
    {
        return _enterPoint;
    }

    public function set enterPoint(value:Point):void
    {
        _enterPoint = value;
    }

    public function get rotation():int
    {
        return _rotation;
    }

    public function set rotation(value:int):void
    {
        _rotation = value;
    }
}
}
