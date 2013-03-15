/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 14:54
 */
package ru.fcl.sdd.gui
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.gui.info.BuildInfoViewCommand;

import ru.fcl.sdd.gui.ingame.BuildInGameGuiCommand;

import ru.fcl.sdd.gui.main.BuildMainGUICommand;

public class BuildGuiCommand extends SignalCommand
{
    override public function execute():void
    {
        commandMap.execute(BuildMainGUICommand);
        commandMap.execute(BuildInGameGuiCommand);
        commandMap.execute(BuildInfoViewCommand);
		
    }
}
}
