/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 19:34
 */
package ru.fcl.sdd.gui.ingame.shop
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.states.ChangeStateSignal;
import ru.fcl.sdd.states.GameStates;

public class BuyItemCommand extends SignalCommand
{
    [Inject]
    public var item:Item;
    [Inject]
    public var changeState:ChangeStateSignal;

    override public function execute():void
    {
        Закончил здесь, //todo:добавить iso айтем в хэшмэпу, заинжектить его, сменить на него курсор, начать двигать.
        changeState.dispatch(GameStates.MOVE_ITEM);
    }
}
}
