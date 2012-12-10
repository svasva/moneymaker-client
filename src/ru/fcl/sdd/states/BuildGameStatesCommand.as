/**
 * User: Jessie
 * Date: 07.12.12
 * Time: 17:22
 */
package ru.fcl.sdd.states
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildGameStatesCommand extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingletonOf(IStateHolder,StateModel);
        injector.mapSingleton(ChangeStateSignal);
        signalCommandMap.mapSignalClass(ChangeStateSignal,ChangeStateCommand);
    }
}
}
