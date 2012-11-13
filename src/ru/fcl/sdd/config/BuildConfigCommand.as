/**
 * User: Jessie
 * Date: 12.11.12
 * Time: 13:07
 */
package ru.fcl.sdd.config
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;

public class BuildConfigCommand extends SignalCommand
{
    override public function execute():void
    {
        commandMap.execute(ParseFlashVarsCommand);
    }
}
}
