/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 12:21
 */
package ru.fcl.sdd.states.shop
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.gui.ingame.InGameGuiView;
import ru.fcl.sdd.gui.ingame.shop.ShopView;


public class OutShopCommand extends SignalCommand
{
    [Inject]
    public var shopView:ShopView;
    [Inject]
    public var inGameGuiView:InGameGuiView;

    override public function execute():void
    {
        inGameGuiView.removeChild(shopView);
    }
}
}
