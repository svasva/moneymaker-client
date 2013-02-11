/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 17:23
 */
package ru.fcl.sdd.services.main.parser
{
import org.robotlegs.mvcs.Command;
import ru.fcl.sdd.location.room.UserRoomList;
import ru.fcl.sdd.scenes.MainIsoView;
import ru.fcl.sdd.tempFloorView.FloorManager;
import ru.fcl.sdd.tempFloorView.MapLayer;
import ru.fcl.sdd.tools.PrintJSON;
import ru.fcl.sdd.userdata.reputation.IReputation;

import ru.fcl.sdd.user.UserDataModel;

public class ParseUserDataCommand extends Command
{
    [Inject]
    public var userData:UserDataModel;
    [Inject]
    public var userObject:Object;
    
      [Inject]
      public var repMdl:IReputation;
      



    override public function execute():void
    {
        userData.bank_name = userObject.response.bank_name;

     //   trace("ParseUserDataCommand");
     //   PrintJSON.deepTrace(userObject.response.items);
        var rooms:Array = userObject.response.rooms;
        if(!rooms)
        {
            rooms = [];
        }
        commandMap.execute(ParseUserRooms,rooms);

        var items:Array = userObject.response.items;
        if(!items)
        {
            items = [];
        }
        commandMap.execute(ParseUserItems,items);

        var money:Object = {gameMoney:userObject.response.coins,realMoney:userObject.response.money};
        commandMap.execute(ParseMoneyCommand, money);
        
       
        var capacity:int = userObject.response.capacity;
        commandMap.execute(ParseCapasityCommand, capacity);
        
      
        var reputation:Object = {reputation:userObject.response.reputation, minReputation:userObject.response.min_rep};
        repMdl.countValue = userObject.response.reputation;
        repMdl.min_rep = userObject.response.min_rep;
        
        commandMap.execute(ParseReputationCommand, reputation);
        
        var exp:Object = { exp:   userObject.response.experience,
                           nextLv:userObject.response.nextlevel,
                           levelNuber:userObject.response.levelnumber};
                           
         commandMap.execute(ParseExperienceCommand, exp);
         
         
       /* var len:int = userRoomList.toArray().length -2;
        
         	var xml:XML; 
          
          //  xml  = FloorManager.get_Instance().Next();
            
        
        for (var i:int = 0; i <len ; i++) 
        {
             xml  = FloorManager.get_Instance().Next();
            layer.isoFlor.loadRooms(xml.floors.item[mainIsoView.currentFloorNumber].rooms);
        }
        */
        
    }
}
}
