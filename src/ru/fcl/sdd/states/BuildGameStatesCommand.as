/**
 * User: Jessie
 * Date: 07.12.12
 * Time: 17:22
 */
package ru.fcl.sdd.states
{
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.gui.ingame.shop.InvestSelectedSignal;
import ru.fcl.sdd.gui.ingame.shop.MarketingSelectedSignal;
import ru.fcl.sdd.gui.ingame.shop.ShopSelectedSignal;
import ru.fcl.sdd.gui.main.controlpanel.ShowTutorialSignal;

public class BuildGameStatesCommand extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingletonOf(IStateHolder,StateModel);
        injector.mapSingleton(ChangeStateSignal);
        injector.mapSingleton(ShopSelectedSignal);
        injector.mapSingleton(MarketingSelectedSignal);
        injector.mapSingleton(InvestSelectedSignal);
        injector.mapSingleton(ShowTutorialSignal);
        
        signalCommandMap.mapSignalClass(ChangeStateSignal,ChangeStateCommand);
    }
}
}
