/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 15:50
 */
package ru.fcl.sdd.services.main
{
import org.robotlegs.mvcs.Command;

import ru.fcl.sdd.log.ILogger;

public class WhenSocketServerAuthorizedCommand extends Command
{
    [Inject]
    public var userObject:Object;
    [Inject]
    public var logger:ILogger;

    override public function execute():void
    {
        logger.log(this,"socket server authorization completed.");
    }
}
}
