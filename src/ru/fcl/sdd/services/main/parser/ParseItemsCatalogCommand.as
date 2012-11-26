/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 18:53
 */
package ru.fcl.sdd.services.main.parser
{
import de.polygonal.ds.Array2;

import flash.geom.Point;

import org.robotlegs.mvcs.Command;

import ru.fcl.sdd.log.ILogger;

import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.item.ItemCatalog;

public class ParseItemsCatalogCommand extends Command
{
    [Inject]
    public var itemListObject:Object;
    [Inject]
    public var itemListModel:ItemCatalog;
    [Inject]
    public var logger:ILogger;

    override public function execute():void
    {
        logger.log(this, "parse item list...");
        var itemsArray:Array = itemListObject.response;
        itemsArray.forEach(parseItem);
        logger.log(this, "item list parsed.");
    }

    private function parseItem(object:Object, index:int, array:Array):void
    {
        var item:Item = new Item();
        item.matrix = new Array2(object.size_x,object.size_y);
        item.id = object._id;
        item.size = new Point(object.size_x, object.size_y);
        item.name = object.name;
        item.enterPoint = object.enter_point;
        itemListModel.set(item.id, item);

        for (var iy:int = 0; iy < item.size.y; iy++)
        {
            for (var ix:int = 0; ix < item.size.x; ix++)
            {
                item.matrix.set(ix,iy,item);
            }
        }
    }
}
}
