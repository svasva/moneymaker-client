/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 12:21
 */
package ru.fcl.sdd.states.buyitem
{
import flash.ui.Mouse;
import ru.fcl.sdd.location.room.RoomModel;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.item.iso.ItemIsoView;
import ru.fcl.sdd.item.iso.ItemIsoViewMoveMediator;
import ru.fcl.sdd.item.iso.PlaceItemCommand;
import ru.fcl.sdd.states.iso.EnterIsoViewCommand;

public class EnterBuyItemCommand extends SignalCommand
{
    [Inject(name="item_for_move")]
    public var item:ItemIsoView;
    
     [Inject] 
     public var roomMdl:RoomModel;

    override public function execute():void
    {
        Mouse.hide();
        roomMdl.buyingItem = item;
        
        mediatorMap.mapView(item, ItemIsoViewMoveMediator);
        commandMap.execute(PlaceItemCommand,item);
        mediatorMap.createMediator(item);
    }
}
}
