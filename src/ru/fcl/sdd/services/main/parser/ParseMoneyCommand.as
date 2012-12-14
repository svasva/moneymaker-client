/**
 * User: Jessie
 * Date: 14.12.12
 * Time: 13:44
 */
package ru.fcl.sdd.services.main.parser
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.money.IMoney;

public class ParseMoneyCommand extends SignalCommand
{
    [Inject(name="game_money")]
    public var gameMoney:IMoney;
    [Inject(name="real_money")]
    public var realMoney:IMoney;
    [Inject]
    public var moneyRaw:Object;

    override public function execute():void
    {
        gameMoney.count = moneyRaw.gameMoney as int;
        realMoney.count = moneyRaw.realMoney as int;
    }
}
}
