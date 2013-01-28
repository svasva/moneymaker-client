/**
 * User: Jessie
 * Date: 09.11.12
 * Time: 13:35
 */
package ru.fcl.sdd.services.main
{
import com.adobe.serialization.json.JSON;

import ru.fcl.sdd.buildapplication.WhenStartApplicationServerResponseCommand;
import ru.fcl.sdd.services.main.listen.CallHashMap;

public class Sender implements ISender
{
    [Inject]
    public var serverProxy:IServerProxy;
    [Inject]
    public var callHashMap:CallHashMap;

    public function send(value:Object,responseHandleCommand:Class=null,errorHandlerCommandClass:Class=null):void
    {
        var key:String = callHashMap.addResponseHandler(responseHandleCommand);
        value.requestId = key;
        serverProxy.sendData(com.adobe.serialization.json.JSON.encode(value));
    }

}
}
