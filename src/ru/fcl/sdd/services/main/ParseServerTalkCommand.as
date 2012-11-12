/**
 * User: Jessie
 * Date: 12.11.12
 * Time: 16:55
 */
package ru.fcl.sdd.services.main
{

import com.adobe.serialization.json.JSON;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.log.ILogger;

public class ParseServerTalkCommand extends SignalCommand
{
    [Inject]
    public var response:String;
    [Inject]
    public var logger:ILogger;

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
        }
    }
}
}
