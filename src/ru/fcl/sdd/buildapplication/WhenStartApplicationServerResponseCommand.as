/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 16:38
 */
package ru.fcl.sdd.buildapplication
{
import mx.core.FlexGlobals;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.SDD;
import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.main.ISender;
import ru.fcl.sdd.services.main.listen.CallHashMap;
import ru.fcl.sdd.states.ChangeStateSignal;
import ru.fcl.sdd.states.GameStates;

public class WhenStartApplicationServerResponseCommand extends SignalCommand
{
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var sender:ISender;
    [Inject]
    public var callHashMap:CallHashMap;
//    [Inject]
//    public var response:Object;
    [Inject]
    public var stateChange:ChangeStateSignal;

    override public function execute():void
    {
        logger.log(this, "Server star application response success. Starting app.");
//        if (response.response.success)
//        {
            SDD(FlexGlobals.topLevelApplication).dispatchInitComplete();
            stateChange.dispatch(GameStates.VIEW);
//        }
    }
}
}
