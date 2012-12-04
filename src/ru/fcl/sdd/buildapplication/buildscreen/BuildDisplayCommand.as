/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 13:15
 */
package ru.fcl.sdd.buildapplication.buildscreen
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.gui.BuildGuiCommand;

public class BuildDisplayCommand extends SignalCommand
{
    override public function execute():void
    {
        commandMap.execute(BuildGuiCommand);
        commandMap.execute(AddViewsCommand);
    }
}
}
