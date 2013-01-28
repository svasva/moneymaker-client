/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 17:23
 */
package ru.fcl.sdd.services.main.parser
{
import org.robotlegs.mvcs.Command;
import ru.fcl.sdd.tools.PrintJSON;

import ru.fcl.sdd.user.UserDataModel;

public class ParseUserDataCommand extends Command
{
    [Inject]
    public var userData:UserDataModel;
    [Inject]
    public var userObject:Object;


    override public function execute():void
    {
        userData.bank_name = userObject.response.bank_name;

       
        
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
        commandMap.execute(ParseReputationCommand, reputation);
        
        var exp:Object = { exp:   userObject.response.experience,
                           nextLv:userObject.response.nextlevel,
                           levelNuber:userObject.response.levelnumber};
                           
         commandMap.execute(ParseExperienceCommand,exp);
       
        
        
    }
}
}
