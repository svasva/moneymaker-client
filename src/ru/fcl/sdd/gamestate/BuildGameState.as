/**
 * User: Jessie
 * Date: 07.12.12
 * Time: 17:22
 */
package ru.fcl.sdd.gamestate
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildGameState extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingletonOf(IStateSwitcher,CurrentStateModel);
    }
}
}
