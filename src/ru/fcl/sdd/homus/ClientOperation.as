/**
 * User: Jessie
 * Date: 15.01.13
 * Time: 15:28
 */
package ru.fcl.sdd.homus
{
public class ClientOperation
{
    private var _id:String;
    private var _money:int;

    public function get id():String
    {
        return _id;
    }

    public function set id(value:String):void
    {
        _id = value;
    }

    public function get money():int
    {
        return _money;
    }

    public function set money(value:int):void
    {
        _money = value;
    }
}
}
