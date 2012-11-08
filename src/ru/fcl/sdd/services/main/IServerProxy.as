/**
 * Created with IntelliJ IDEA.
 * User: questa_4
 * Date: 07.11.12
 * Time: 19:34
 * To change this template use File | Settings | File Templates.
 */
package ru.fcl.sdd.services.main
{
import com.adobe.serialization.json.JSON;

public interface IServerProxy
{
    function get connected():Boolean;
    function connect(url:String, protocol:String):void;
    function sendData(data:JSON):void;
}
}
