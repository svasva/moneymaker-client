/**
 * User: Jessie
 * Date: 23.12.12
 * Time: 14:54
 */
package ru.fcl.sdd.homus
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.money.IMoney;

public class CompleteOperationCommitChangesCommand extends  SignalCommand
{
    [Inject(name="game_money")]
    public var gameMoney:IMoney;
    [Inject]
    public var moneyDelta:int;

    override public function execute():void
    {
        gameMoney.count+=moneyDelta;
    }
}
}
