/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 13:45
 */
package ru.fcl.sdd.services.main.parser
{

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.item.ItemCatalog;
import ru.fcl.sdd.item.ItemIsoView;
import ru.fcl.sdd.item.UserItemList;

public class ParseUserItems extends SignalCommand
{
    [Inject]
    public var items:Array;
    [Inject]
    public var itemCatalog:ItemCatalog;
    [Inject]
    public var userItems:UserItemList;


    override public function execute():void
    {
        items.forEach(parseItems);
    }

    private function parseItems(object:Object,index:int, array:Array):void
    {
        var catalogItem:Item = Item(itemCatalog.get(object.item_id));
        var item:ItemIsoView = new ItemIsoView();
        item.key = object._id;
        item.catalogKey = object.item_id;
        item.rotationIso= object.rotationIso;
        item.x = object.x*IsoConfig.CELL_SIZE;
        item.y = object.y*IsoConfig.CELL_SIZE;
        item.width = catalogItem.isoWidth;
        item.length = catalogItem.isoLength;
        item.height = catalogItem.isoHeight;
        item.skin = catalogItem.skinUrl;

        userItems.set(item.key, item);
//        commandMap.execute(PlaceItemCommand,item);
    }
}
}
