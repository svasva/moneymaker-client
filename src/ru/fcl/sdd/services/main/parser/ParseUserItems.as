/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 13:45
 */
package ru.fcl.sdd.services.main.parser
{

import de.polygonal.ds.Array2;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.item.ItemCatalog;

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
        var item:Item = new Item();
        item.id = object._id;
        item.catalog_id = object.item_id;
        item.room_id = object.room_id;
        item.rotation = object.rotation;
        item.position = Item(itemCatalog.get(item.catalog_id)).position;
        item.enterPoint = Item(itemCatalog.get(item.catalog_id)).enterPoint;
        item.matrix = Item(itemCatalog.get(item.catalog_id)).matrix;
        //todo: Решить что делать с такими огромными матрицами (надо как-то увеличивать сетку).
        //todo: Если реально сделать межкомнатные стены толщиной 100 пикселей, то сделать так.
    }
}
}
