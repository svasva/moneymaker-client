/**
 * User: Jessie
 * Date: 07.11.12
 * Time: 19:27
 */
package ru.fcl.sdd.buildapplication.test
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.services.main.ConnectSocketServerCommand;

public class BuildTestCommand extends SignalCommand
{
    override public function execute():void
    {
        commandMap.execute(ConnectSocketServerCommand);
    }
}
}
