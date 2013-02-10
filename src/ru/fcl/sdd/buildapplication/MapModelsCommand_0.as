/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 17:11
 */
package ru.fcl.sdd.buildapplication
{
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.gui.ingame.shop.BuyRoomToServerCommandSignal;
import ru.fcl.sdd.gui.ingame.shop.ForPurshRoomIdUpdatedSignal;
import ru.fcl.sdd.gui.ingame.shop.OveredShopItemUpdatedSignal;
import ru.fcl.sdd.gui.ingame.shop.SelectedShopItemUpdatedSignal;
import ru.fcl.sdd.gui.ingame.shop.ShopModelCategoryUpdatedSignal;
import ru.fcl.sdd.gui.ingame.shop.ShopModelTabUpdatedSignal;
import ru.fcl.sdd.item.AdvertsCatalog;
import ru.fcl.sdd.item.MarketingCatalog;
import ru.fcl.sdd.item.SellItemSignal;
import ru.fcl.sdd.item.ShopModel;
import ru.fcl.sdd.location.room.RoomModel;
import ru.fcl.sdd.location.room.SelectedItemUpdated;
import ru.fcl.sdd.rsl.BuildRslCommand;
import ru.fcl.sdd.services.shared.SharedGameDataService;
import ru.fcl.sdd.userdata.capacity.BuildCapacityCommand;
import ru.fcl.sdd.userdata.experience.BuildExperienceCommand;
import ru.fcl.sdd.userdata.reputation.BuildReputationCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.config.PlatformModel;
import ru.fcl.sdd.item.ActiveUserItemList;
import ru.fcl.sdd.item.ItemCatalog;
import ru.fcl.sdd.location.room.RoomCatalog;
import ru.fcl.sdd.location.room.UserRoomList;
import ru.fcl.sdd.money.BuildMoneyCommand;
import ru.fcl.sdd.user.UserDataModel;

public class MapModelsCommand_0 extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(FlashVarsModel);
        injector.mapSingleton(UserDataModel);
        injector.mapSingleton(UserRoomList);
        injector.mapSingleton(RoomCatalog);
        
        injector.mapSingleton(ForPurshRoomIdUpdatedSignal);
        injector.mapSingleton(SelectedShopItemUpdatedSignal);
        injector.mapSingleton(OveredShopItemUpdatedSignal);
        injector.mapSingleton(ShopModelCategoryUpdatedSignal);
        injector.mapSingleton(ShopModelTabUpdatedSignal);
        injector.mapSingleton(BuyRoomToServerCommandSignal);
        injector.mapSingleton(SelectedItemUpdated); 
        injector.mapSingleton(SellItemSignal); 
      
       
        injector.mapSingleton(ShopModel);
        injector.mapSingleton(RoomModel)
       
        injector.mapSingleton(ActiveUserItemList);
        injector.mapSingleton(PlatformModel);
        injector.mapSingleton(ItemCatalog);
        injector.mapSingleton(AdvertsCatalog);
        injector.mapSingleton(MarketingCatalog);
        
        commandMap.execute(BuildMoneyCommand);
        commandMap.execute(BuildCapacityCommand);
        commandMap.execute(BuildReputationCommand);
        commandMap.execute(BuildExperienceCommand);
    }
}
}
