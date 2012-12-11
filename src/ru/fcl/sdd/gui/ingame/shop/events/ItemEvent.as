/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 17:41
 */
package ru.fcl.sdd.gui.ingame.shop.events
{
import flash.events.Event;

import ru.fcl.sdd.item.Item;

public class ItemEvent extends Event
{
    public static const ITEM_CLICKED:String = "item_clicked";
    public var item:Item;

    public function ItemEvent(type:String,item:Item,bubbles:Boolean = false,cancelable:Boolean = false):void
    {
        this.item = item;
        super(type, bubbles,cancelable);
    }

    override public function clone():Event
    {
        return new ItemEvent(this.type,this.item, this.bubbles,this.cancelable);
    }
}
}
