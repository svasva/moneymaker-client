/**
 * User: Jessie
 * Date: 26.11.12
 * Time: 13:00
 */
package ru.fcl.sdd.item
{
import flash.geom.Point;

public interface IPlaceable
{
    function set position(value:Point):void;
    function get position():Point;
    function set size(value:Point):void;
    function get size():Point;
    function set rotation(value:int):void;
    function get rotation():int;
}
}
