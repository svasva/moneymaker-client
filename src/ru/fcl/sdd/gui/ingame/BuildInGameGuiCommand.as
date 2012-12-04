/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 14:50
 */
package ru.fcl.sdd.gui.ingame
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.gui.ingame.shop.BuildShopCommand;

public class BuildInGameGuiCommand extends SignalCommand
{
    [Inject]
    public var flashVars:FlashVarsModel;

    override public function execute():void
    {
        injector.mapSingleton(InGameGuiView);
        commandMap.execute(BuildShopCommand);
    }
}
}
