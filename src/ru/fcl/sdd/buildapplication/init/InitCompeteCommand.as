/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 17:24
 */
package ru.fcl.sdd.buildapplication.init
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.buildapplication.SendServerStartApplicationCommand;
import ru.fcl.sdd.buildapplication.buildscreen.BuildDisplayCommand;

import ru.fcl.sdd.log.ILogger;

public class InitCompeteCommand extends SignalCommand
{
    [Inject]
    public var logger:ILogger;

    override public function execute():void
    {
        logger.log(this,"application init complete.");
        commandMap.execute(BuildDisplayCommand);

    }
}
}
