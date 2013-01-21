/**
 * User: Jessie
 * Date: 12.12.12
 * Time: 17:16
 */
package ru.fcl.sdd.item
{
import org.osflash.signals.ISignal;
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.item.iso.AboutIsoItemSignal;

import ru.fcl.sdd.item.iso.PlaceMovedItemCommand;

public class BuildItemsCommand extends SignalCommand
{
    override public function execute():void
    {
        var placeMovedItem:ISignal = new AboutIsoItemSignal();
        injector.mapValue(ISignal,placeMovedItem,"place_moved_item");
        signalCommandMap.mapSignal(placeMovedItem,PlaceMovedItemCommand);

    }
}
}
