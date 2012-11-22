/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 13:45
 */
package ru.fcl.sdd.services.main.parser
{
import org.robotlegs.mvcs.SignalCommand;

public class ParseUserItems extends SignalCommand
{
    [Inject]
    public var items:Array;

    override public function execute():void
    {
        items.forEach(parseRooms);
    }

    private function parseRooms(object:Object,index:int, array:Array):void
    {

    }
}
}
