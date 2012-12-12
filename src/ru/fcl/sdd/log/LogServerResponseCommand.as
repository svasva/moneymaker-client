/**
 * User: Jessie
 * Date: 12.12.12
 * Time: 17:12
 */
package ru.fcl.sdd.log
{

import org.robotlegs.mvcs.SignalCommand;

public class LogServerResponseCommand extends SignalCommand
{
    [Inject]
    public var response:Object;
    [Inject]
    public var logger:ILogger;
    override public function execute():void
    {
        logger.log(this, response.response);
    }
}
}
