/**
 * User: Jessie
 * Date: 12.11.12
 * Time: 13:06
 */
package ru.fcl.sdd.config
{
public class FlashVarsModel
{
    public static const LOCAL_TOKEN:String = "50ac98221685ffc102000004";
    public static const LOCAL_SOCKET_URL:String = "ws://192.168.1.242:9999/socket/0/0/websocket";
    public static const LOCAL_GREETING:String = "Greeting, dear developer.";
    public static const LOCAL_SOCIAL_NET:String = SocialNet.LOCAL;
    private var _token:String;
    private var _socketUrl:String;
    private var _greeting:String;
    private var _social:String;

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

    public function get social():String
    {
        return _social;
    }

    public function set social(value:String):void
    {
        _social = value;
    }
}
}
