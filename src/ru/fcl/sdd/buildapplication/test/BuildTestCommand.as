/**
 * Created with IntelliJ IDEA.
 * User: questa_4
 * Date: 07.11.12
 * Time: 19:27
 * To change this template use File | Settings | File Templates.
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
