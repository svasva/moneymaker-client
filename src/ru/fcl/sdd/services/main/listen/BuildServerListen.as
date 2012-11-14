/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 14:20
 */
package ru.fcl.sdd.services.main.listen
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildServerListen extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(CallHashMap);
    }
}
}
