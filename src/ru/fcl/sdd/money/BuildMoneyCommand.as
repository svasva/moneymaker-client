/**
 * User: Jessie
 * Date: 14.12.12
 * Time: 13:23
 */
package ru.fcl.sdd.money
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.money.RealMoneyUpdateSignal;

public class BuildMoneyCommand extends SignalCommand
{
    /**
     * This command executing in MapModels stage. Please, don't place non-mapmodel code here.
     */
    override public function execute():void
    {
        injector.mapSingleton(GameMoneyUpdateSignal);
        injector.mapSingletonOf(IMoney,GameMoney,"game_money");

        injector.mapSingleton(RealMoneyUpdateSignal);
        injector.mapSingletonOf(IMoney,RealMoney,"real_money");
    }
}
}
