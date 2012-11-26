/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 13:45
 */
package ru.fcl.sdd.services.main.parser
{

import mx.core.ClassFactory;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.IsoConfig;

import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.item.ItemCatalog;
import ru.fcl.sdd.item.PlaceItemCommand;

public class ParseUserItems extends SignalCommand
{
    [Inject]
    public var items:Array;

    [Inject]
    public var itemCatalog:ItemCatalog;


    override public function execute():void
    {
        items.forEach(parseItems);
    }

    private function parseItems(object:Object,index:int, array:Array):void
    {
        var item:Item = ClassFactory(itemCatalog.get(object.item_id)).newInstance() as Item;
        item.key = object._id;
        item.catalog_id = object.item_id;
        item.room_id = object.room_id;
        item.rotation = object.rotation;
        item.x = object.x*IsoConfig.CELL_SIZE;
        item.y = object.y*IsoConfig.CELL_SIZE;
        commandMap.execute(PlaceItemCommand,item);
    }
}
}
