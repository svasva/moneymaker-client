/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 12:21
 */
package ru.fcl.sdd.states.buyitem
{
import flash.ui.Mouse;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.item.ItemIsoView;

public class EnterBuyItemCommand extends SignalCommand
{
    [Inject(name="item_for_move")]
    public var item:ItemIsoView;

    override public function execute():void
    {
        Mouse.hide();
    }
}
}
