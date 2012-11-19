/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 17:11
 */
package ru.fcl.sdd.buildapplication
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.config.PlatformModel;
import ru.fcl.sdd.user.UserItemListModel;
import ru.fcl.sdd.user.UserRoomListModel;
import ru.fcl.sdd.user.UserDataModel;
import ru.fcl.sdd.item.ItemListModel;

public class MapModelsCommand_0 extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(FlashVarsModel);
        injector.mapSingleton(UserDataModel);
        injector.mapSingleton(UserRoomListModel);
        injector.mapSingleton(UserItemListModel);
        injector.mapSingleton(PlatformModel);
        injector.mapSingleton(ItemListModel);
    }
}
}
