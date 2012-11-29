/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 14:38
 */
package ru.fcl.sdd.gui.ingame.shop
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;

public class BuildShopCommand extends SignalCommand
{
    [Inject]
    public var flashVars:FlashVarsModel;

    override public function execute():void
    {
        injector.mapSingleton(ShopView);
        mediatorMap.mapView(ShopView,ShopViewMediator);
        var shop:ShopView = injector.getInstance(ShopView);
        shop.x = flashVars.app_width/2 - shop.width/2;
        shop.y = flashVars.app_height - shop.height;
    }
}
}
