/**
 * User: Jessie
 * Date: 12.11.12
 * Time: 16:55
 */
package ru.fcl.sdd.services.main.parser
{

import com.adobe.serialization.json.JSON;

import org.osflash.signals.ISignal;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.main.listen.CallHashMap;

public class BaseParserCommand extends SignalCommand
{
    [Inject]
    public var response:String;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var callHashMap:CallHashMap;
    [Inject(name="error_response_signal")]
    public var errorResponseSignal:ISignal;

    override public function execute():void
    {
        var slicedString:String = response.slice(2, response.length - 2);

        while (slicedString.indexOf("\\") != -1)
        {
            slicedString = slicedString.replace("\\", "");
        }

        if (slicedString.substr(0, 1) == "{")
        {
            var decodedObject:Object = JSON.decode(slicedString);
            logger.log(this, "decode value: " + decodedObject);

            if (decodedObject.response.error)
            {
                errorResponseSignal.dispatch(decodedObject);
            } else
            if (callHashMap.get(decodedObject.requestId))
            {
                commandMap.execute(Class(callHashMap.get(decodedObject.requestId)), decodedObject);
            }
        }
    }
}
}
