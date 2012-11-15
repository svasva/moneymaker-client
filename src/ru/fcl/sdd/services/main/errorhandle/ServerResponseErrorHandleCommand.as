/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 15:56
 */
package ru.fcl.sdd.services.main.errorhandle
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.services.main.listen.CallHashMap;

public class ServerResponseErrorHandleCommand extends SignalCommand
{
    [Inject]
    public var response:Object;

    [Inject]
    public var callHashMap:CallHashMap;

    override public function execute():void
    {
        if(callHashMap.get(response.requestId+"_error"))
        {
            commandMap.execute(Class(callHashMap.get(response.requestId+"_error")),response);
        }else
        {
            commandMap.execute(UnknownErrorResponseHandleCommand,response);
        }
    }
}
}
