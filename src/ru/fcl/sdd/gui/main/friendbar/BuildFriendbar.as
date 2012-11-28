/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:39
 */
package ru.fcl.sdd.gui.main.friendbar
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildFriendbar extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(FriendBarView);
        mediatorMap.mapView(FriendBarView,FriendBarMediator);
    }
}
}
