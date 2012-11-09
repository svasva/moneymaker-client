/**
 * Created with IntelliJ IDEA.
 * User: questa_4
 * Date: 07.11.12
 * Time: 14:16
 * To change this template use File | Settings | File Templates.
 */
package ru.fcl.sdd
{
import ru.fcl.sdd.log.BuildLoggerCommand;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.services.main.BuildMainServicesCommand;
import ru.fcl.sdd.services.main.test.PrepareTestServerSendCommand;
import ru.fcl.sdd.test.BuildDebugConsoleCommand;


public class BuildApplicationCommand extends SignalCommand
{
    override public function execute():void
    {
        commandMap.execute(BuildDebugConsoleCommand);
        commandMap.execute(BuildLoggerCommand);

        commandMap.execute(BuildMainServicesCommand);

        commandMap.execute(PrepareTestServerSendCommand);

    }
}
}
