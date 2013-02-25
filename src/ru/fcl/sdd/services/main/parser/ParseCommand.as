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

public class ParseCommand extends SignalCommand
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
        if (response.substr(0, 1) == "{")
        {
            var decodedObject:Object = com.adobe.serialization.json.JSON.decode(response);
            logger.log(this, "decode value: " + decodedObject);

            if (decodedObject.response)
            {
                if (decodedObject.response.error)
                {
                    errorResponseSignal.dispatch(decodedObject);
                }
                else if (callHashMap.get((decodedObject.requestId)))
                {
                    trace("decodedObject.requestId "+decodedObject.requestId);   
					commandMap.execute(Class(callHashMap.get(decodedObject.requestId)), decodedObject);
                }
            }
            if ((int(decodedObject.requestId)) >= 0)
            {
                // trace("!!!decodedObject.requestId!!!!! "+decodedObject.requestId);   
				callHashMap.remove(callHashMap.get(decodedObject.requestId));
                callHashMap.remove(callHashMap.get(decodedObject.requestId + "_error"));
				commandMap.execute(ParseItemStateCommand, decodedObject);
            }
        }
        else
        {
            logger.error(this, response);
        }
    }
}
}
