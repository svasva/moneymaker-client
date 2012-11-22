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
import ru.fcl.sdd.item.ItemListModel;
import ru.fcl.sdd.location.FloorsListModel;
import ru.fcl.sdd.location.room.RoomListModel;
import ru.fcl.sdd.user.UserDataModel;
import ru.fcl.sdd.item.UserItemListModel;
import ru.fcl.sdd.location.room.UserRoomListModel;

public class MapModelsCommand_0 extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(FlashVarsModel);
        injector.mapSingleton(UserDataModel);
        injector.mapSingleton(UserRoomListModel);
        injector.mapSingleton(RoomListModel);
        injector.mapSingleton(FloorsListModel);
        injector.mapSingleton(UserItemListModel);
        injector.mapSingleton(PlatformModel);
        injector.mapSingleton(ItemListModel);
    }
}
}
