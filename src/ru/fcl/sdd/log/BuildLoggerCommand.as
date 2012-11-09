/**
 * User: Jessie
 * Date: 09.11.12
 * Time: 12:16
 */
package ru.fcl.sdd.log
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildLoggerCommand extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingletonOf(ILogger, Logger);
    }
}
}
