/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 14:38
 */
package ru.fcl.sdd.gui.ingame.shop
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildShopCommand extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(ShopView);
        mediatorMap.mapView(ShopView,ShopViewMediator);
    }
}
}
