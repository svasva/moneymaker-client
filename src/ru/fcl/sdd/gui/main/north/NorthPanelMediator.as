/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.north
{
import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.money.GameMoneyUpdateSignal;
import ru.fcl.sdd.money.IMoney;

public class NorthPanelMediator extends Mediator
{
    [Inject]
    public var view:NorthPanelView;
    [Inject]
    public var gameMoneyUpdate:GameMoneyUpdateSignal;
    [Inject(name="game_money")]
    public var gameMoneyModel:IMoney;
    [Inject(name="real_money")]
    public var realMoneyModel:IMoney;

    override public function onRegister():void
    {
        gameMoneyUpdate.add(setGameMoney);
        setGameMoney();
    }

    private function setGameMoney():void
    {
        view.gameMoney = gameMoneyModel.count;
    }
}
}
