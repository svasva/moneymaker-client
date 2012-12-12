/**
 * User: Jessie
 * Date: 11.12.12
 * Time: 11:52
 */
package ru.fcl.sdd.gui.ingame.shop
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.services.main.ISender;

public class SendServerBuyItemCommand extends SignalCommand
{
    [Inject]
    public var sender:ISender;
    [Inject]
    public var item:Item;
    override public function execute():void
    {
        sender.send({command:"buyContent",args:[/*item_id:*/item.key,/*currency:*/"coins"]},BuyItemCommand);
    }
}
}
