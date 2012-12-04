/**
 * User: Jessie
 * Date: 20.11.12
 * Time: 15:31
 */
package ru.fcl.sdd.rsl
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.buildapplication.init.GetRoomsCommand_4;


public class WhenRslLoaded extends SignalCommand
{
    override public function execute():void
    {
        commandMap.execute(GetRoomsCommand_4);
    }
}
}
