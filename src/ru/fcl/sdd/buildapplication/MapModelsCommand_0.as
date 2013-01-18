/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 17:11
 */
package ru.fcl.sdd.buildapplication
{
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.services.shared.SharedGameDataService;
import ru.fcl.sdd.userdata.capacity.BuildCapacityCommand;

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
        injector.mapSingleton(ActiveUserItemList);
        injector.mapSingleton(PlatformModel);
        injector.mapSingleton(ItemCatalog);
        commandMap.execute(BuildMoneyCommand);
        commandMap.execute(BuildCapacityCommand);
    }
}
}
