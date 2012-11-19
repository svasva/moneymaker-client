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
}
}
