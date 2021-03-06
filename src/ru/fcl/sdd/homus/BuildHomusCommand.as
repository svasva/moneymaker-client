/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:01
 */
package ru.fcl.sdd.homus
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.gui.info.ShowAddReputationInfoCommand;

public class BuildHomusCommand extends SignalCommand
{
    override public function execute():void
    {
//        var operationMoney:ISignal = new AboutInt();
//        injector.mapValue(ISignal,operationMoney,"operation_money");
//        signalCommandMap.mapSignal(operationMoney,CompleteOperationCommitChangesCommand);
//        injector.mapSingleton(ClientusList);
        injector.mapSingleton(HomusMouseOverSignal);
        injector.mapSingleton(HomusMouseOutSignal);
        injector.mapSingleton(OperationFailedSignal);
        injector.mapSingleton(OperationSuccessSignal);
		injector.mapSingleton(StartServiceSignal);
		
        signalCommandMap.mapSignalClass(OperationSuccessSignal,ShowAddReputationInfoCommand);
        signalCommandMap.mapSignalClass(StartServiceSignal, StartServiceCommand);
		
        injector.mapSingleton(OutOfScheduleSignal);
        signalCommandMap.mapSignalClass(OutOfScheduleSignal,SendServerOutOfScheduleCommand);
        injector.mapClass(ClientusIsoView,ClientusIsoView);
        mediatorMap.mapView(ClientusIsoView,ClientusIsoViewMediator);
    }
}
}
