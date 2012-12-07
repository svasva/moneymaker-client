/**
 * User: Jessie
 * Date: 07.12.12
 * Time: 17:34
 */
package ru.fcl.sdd.gamestate
{
public class EnumBase
{
    private var value:String;

    public function EnumBase(value:String):void
    {
        this.value = value;
    }

    public function toString():String
    {
        return value;
    }
}
}
