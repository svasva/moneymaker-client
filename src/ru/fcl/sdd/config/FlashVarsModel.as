/**
 * User: Jessie
 * Date: 12.11.12
 * Time: 13:06
 */
package ru.fcl.sdd.config
{
public class FlashVarsModel
{
    public static const LOCAL_TOKEN:String = "50a23e8a1685ff833600000b";
    public static const LOCAL_SOCKET_URL:String = "ws://10.0.0.102:9999/socket/0/0/websocket";
    private var _token:String;
    private var _socketUrl:String;
    private var _greeting:String;

    public function get token():String
    {
        return _token;
    }

    public function set token(value:String):void
    {
        _token = value;
    }

    public function get socketUrl():String
    {
        return _socketUrl;
    }

    public function set socketUrl(value:String):void
    {
        _socketUrl = value;
    }

    public function get greeting():String
    {
        return _greeting;
    }

    public function set greeting(value:String):void
    {
        _greeting = value;
    }
}
}
