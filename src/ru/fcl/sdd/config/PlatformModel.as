/**
 * User: Jessie
 * Date: 08.11.12
 * Time: 12:50
 */
package ru.fcl.sdd.config
{
public class PlatformModel
{
    public static const VKONTAKTE:PlatformModel = new PlatformModel("vkontakte");
    public static const LOCAL:PlatformModel = new PlatformModel("local");

    private var _value:String;

    public function PlatformModel(value:String)
    {
    }

    public function toString():String
    {
        return _value;
    }
}
}
