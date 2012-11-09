/**
 * User: Jessie
 * Date: 09.11.12
 * Time: 13:35
 */
package ru.fcl.sdd.services.main
{
import com.adobe.serialization.json.JSON;

public class Sender implements ISender
{
    [Inject]
    public var serverProxy:IServerProxy;

    public function send(value:Object):void
    {
           serverProxy.sendData(JSON.encode(value));
    }

}
}
