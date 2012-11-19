/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 17:23
 */
package ru.fcl.sdd.services.main.parser
{
import org.robotlegs.mvcs.Command;

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
    }
}
}
