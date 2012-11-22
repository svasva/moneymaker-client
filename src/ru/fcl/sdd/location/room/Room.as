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
}
}
