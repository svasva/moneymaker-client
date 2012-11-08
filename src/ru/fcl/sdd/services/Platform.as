/**
 * User: Jessie
 * Date: 08.11.12
 * Time: 12:50
 */
package ru.fcl.sdd.services
{
public class Platform
{
    public static const VKONTAKTE:Platform = new Platform("vkontakte");

    private var _value:String;

    public function Platform(value:String)
    {
    }

    public function toString():String
    {
        return _value;
    }
}
}
