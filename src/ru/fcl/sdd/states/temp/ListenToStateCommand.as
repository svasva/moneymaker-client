/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 13:29
 */
package ru.fcl.sdd.states.temp
{
import ru.fcl.sdd.states.temp.StateCommand;

public class ListenToStateCommand extends StateCommand
{
        override public function execute():void
        {
            signalCommandMap.mapSignal(stateNews.entered, onEnterCommandClass);
            signalCommandMap.mapSignal(stateNews.exited, onExitCommandClass);
        }
}
}
