/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 18:53
 */
package ru.fcl.sdd.services.main.parser
{
import mx.core.ClassFactory;

import org.robotlegs.mvcs.Command;

import ru.fcl.sdd.IsoConfig;

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
        var itemClassFactory:ClassFactory = new ClassFactory(Item);
        //todo:Запилить здесь высоту айтемов. Пока 100
        itemClassFactory.properties = {key:object._id,width:object.size_x*IsoConfig.CELL_SIZE,length:object.size_y*IsoConfig.CELL_SIZE,item_name:object.name,height:100};

        itemListModel.set(object._id, itemClassFactory);
    }
}
}
