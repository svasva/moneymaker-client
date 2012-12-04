/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 17:23
 */
package ru.fcl.sdd.services.main.parser.test
{
import flash.geom.Point;

import org.robotlegs.mvcs.Command;

import ru.fcl.sdd.item.UserItemList;
import ru.fcl.sdd.location.room.Room;

import ru.fcl.sdd.location.room.UserRoomList;

import ru.fcl.sdd.user.UserDataModel;

public class ParseUserDataEmulationCommand extends Command
{
    [Inject]
    public var userData:UserDataModel;
    [Inject]
    public var userObject:Object;
    [Inject]
    public var userRoomList:UserRoomList;

    [Inject]
    public var userItemList:UserItemList;


    override public function execute():void
    {
        userData.bank_name = userObject.response.bank_name;
        userRoomList.set("0",new Room("0",0,new Point(10,10), new Point(12,20)));
    }
}
}
