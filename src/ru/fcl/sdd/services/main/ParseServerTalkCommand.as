/**
 * User: Jessie
 * Date: 12.11.12
 * Time: 16:55
 */
package ru.fcl.sdd.services.main
{
import com.adobe.serialization.json.JSON;
import com.junkbyte.console.Cc;

import org.robotlegs.mvcs.SignalCommand;

public class ParseServerTalkCommand extends SignalCommand
{
    [Inject]
    public var response:String;

    override public function execute():void
    {
        var value:Object = JSON.decode(response);
        Cc.log(value);
    }
}
}
