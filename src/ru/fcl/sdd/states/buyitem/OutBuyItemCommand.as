/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 12:21
 */
package ru.fcl.sdd.states.buyitem
{
import flash.events.MouseEvent;
import flash.ui.Mouse;
import ru.fcl.sdd.location.room.RoomModel;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.item.iso.ItemIsoView;

public class OutBuyItemCommand extends SignalCommand
{
    [Inject(name="item_for_move")]
    public var item:ItemIsoView;
    
    [Inject] 
     public var roomMdl:RoomModel;

    override public function execute():void
    {
        Mouse.show();
        
        item.addEventListener(MouseEvent.CLICK, item.onClickFun);
        
        mediatorMap.removeMediatorByView(item);
        mediatorMap.unmapView(item);
        
    }
}
}
