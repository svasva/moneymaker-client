/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 16:50
 */
package ru.fcl.sdd.buildapplication.init
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.services.main.ConnectSocketServerCommand;

public class InitialiseServerCommand_1 extends SignalCommand
{
    override public function execute():void
    {
        commandMap.execute(ConnectSocketServerCommand);
    }
}
}
