/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 18:53
 */
package ru.fcl.sdd.services.main.parser
{
import org.robotlegs.mvcs.Command;

import ru.fcl.sdd.log.ILogger;

import ru.fcl.sdd.user.items.Item;
import ru.fcl.sdd.user.items.ItemListModel;

public class ParseItemListCommand extends Command
{
    [Inject]
    public var itemListObject:Object;
    [Inject]
    public var itemListModel:ItemListModel;
    [Inject]
    public var logger:ILogger;

    override public function execute():void
    {
        logger.log(this, "parse item list...");
        var itemsArray:Array = itemListObject.response;
        itemsArray.forEach(add2List);
        logger.log(this, "item list parsed.");
    }

    private function add2List(object:Object,index:int, array:Array):void
    {
        var item:Item = new Item();
        item.id = object._id;
        item.size_x = object.size_x;
        item.size_y = object.size_y;
        item.name = object.name;
        itemListModel.set(item.id,item);
    }
}
}
