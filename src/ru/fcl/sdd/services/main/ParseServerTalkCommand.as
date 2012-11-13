/**
 * User: Jessie
 * Date: 12.11.12
 * Time: 16:55
 */
package ru.fcl.sdd.services.main
{

import avmplus.getQualifiedClassName;

import com.adobe.serialization.json.JSON;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.main.listen.CallHashMap;

public class ParseServerTalkCommand extends SignalCommand
{
    [Inject]
    public var response:String;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var callHashMap:CallHashMap;

    override public function execute():void
    {
        var slicedString:String = response.slice(2, response.length - 2);

        while(slicedString.indexOf("\\")!=-1)
        {
            slicedString = slicedString.replace("\\", "");
        }

        if (slicedString.substr(0, 1) == "{")
        {
            var decodedObject:Object = JSON.decode(slicedString);
            logger.log(this, "decode value: " + decodedObject);

            if(callHashMap.get(decodedObject.requestId))
            {
                var o:Object=getQualifiedClassName(callHashMap.get(decodedObject.requestId));
                commandMap.execute(Class(callHashMap.get(decodedObject.requestId)),decodedObject);
            }
        }
    }
}
}
