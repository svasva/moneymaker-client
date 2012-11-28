/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 14:30
 */
package ru.fcl.sdd.gui.main.controlpanel
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.gui.ingame.InGameGuiView;
import ru.fcl.sdd.gui.ingame.shop.ShopView;

public class ShowHideShopCommand extends SignalCommand
{
    [Inject]
    public var shopView:ShopView;

    [Inject]
    public var inGameGuiView:InGameGuiView;

    override public function execute():void
    {
        if (!shopView.stage)
        {
            inGameGuiView.addChild(shopView);
        } else
        {
            inGameGuiView.removeChild(shopView);
        }

    }
}
}
