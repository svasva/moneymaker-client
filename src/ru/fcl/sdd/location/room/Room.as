/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 14:05
 */
package ru.fcl.sdd.location.room
{
import flash.geom.Point;

public class Room
{
    private var _offset:Point;
    private var _size:Point;
    private var _id:String;
    private var _type:int;
    private var _name:String;
    private var _catalogId:String;
    private var _room_type_id:String;
    private var _decription:String;
    private var _coins_cost:int;
    private var _money_cost:int;
    private var _icon_url:String;
    


    public function get offset():Point
    {
        return _offset;
    }

    public function set offset(value:Point):void
    {
        _offset = value;
    }

    public function get size():Point
    {
        return _size;
    }

    public function set size(value:Point):void
    {
        _size = value;
    }

    public function get id():String
    {
        return _id;
    }

    public function set id(value:String):void
    {
        _id = value;
    }

    public function get type():int
    {
        return _type;
    }

    public function set type(value:int):void
    {
        _type = value;
    }

    public function get name():String
    {
        return _name;
    }

    public function set name(value:String):void
    {
        _name = value;
    }

    public function get catalogId():String
    {
        return _catalogId;
    }

    public function set catalogId(value:String):void
    {
        _catalogId = value;
    }
    
    public function get room_type_id():String 
    {
        return _room_type_id;
    }
    
    public function set room_type_id(value:String):void 
    {
        _room_type_id = value;
    }
    
    public function get decription():String 
    {
        return _decription;
    }
    
    public function set decription(value:String):void 
    {
        _decription = value;
    }
    
    public function get coins_cost():int 
    {
        return _coins_cost;
    }
    
    public function set coins_cost(value:int):void 
    {
        _coins_cost = value;
    }
    
    public function get money_cost():int 
    {
        return _money_cost;
    }
    
    public function set money_cost(value:int):void 
    {
        _money_cost = value;
    }
    
    public function get icon_url():String 
    {
        return _icon_url;
    }
    
    public function set icon_url(value:String):void 
    {
        _icon_url = value;
    }
}
}
