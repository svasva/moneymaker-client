/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 14:38
 */
package ru.fcl.sdd.gui.ingame.shop
{
import org.osflash.signals.ISignal;
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.item.ShopModel;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.gui.ingame.shop.SendServerBuyItemCommand;
import ru.fcl.sdd.gui.ingame.shop.SendServerBuyItemCommand;
import ru.fcl.sdd.item.AboutItemSignal;

public class BuildShopCommand extends SignalCommand
{
    [Inject]
    public var flashVars:FlashVarsModel;

    override public function execute():void
    {
       
       
        injector.mapSingleton(ShopItemRoomSignal);
        var buyItemSignal:ISignal = new AboutItemSignal();
        injector.mapValue(ISignal, buyItemSignal, "buy_item");
    
        signalCommandMap.mapSignal(buyItemSignal,SendServerBuyItemCommand);

        injector.mapSingleton(ShopView);
        mediatorMap.mapView(ShopView, ShopViewMediator);
        
       
        
        var shop:ShopView = injector.getInstance(ShopView);
        shop.x = flashVars.app_width/2 - shop.width/2;
        shop.y = flashVars.app_height - shop.height;
    }
}
}
