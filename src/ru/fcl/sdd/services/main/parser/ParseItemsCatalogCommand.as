/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 18:53
 */
package ru.fcl.sdd.services.main.parser
{
import mx.core.ClassFactory;

import org.robotlegs.mvcs.Command;

import ru.fcl.sdd.config.FlashVarsModel;

import ru.fcl.sdd.config.IsoConfig;

import ru.fcl.sdd.log.ILogger;

import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.item.ItemCatalog;
import ru.fcl.sdd.rsl.GuiRsl;

public class ParseItemsCatalogCommand extends Command
{
    [Inject]
    public var itemListObject:Object;
    [Inject]
    public var itemListModel:ItemCatalog;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var flashVars:FlashVarsModel;
    [Inject]
    public var rsl:GuiRsl;

    override public function execute():void
    {
        logger.log(this, "parse item list...");
        var itemsArray:Array = itemListObject.response;
        itemsArray.forEach(parseItem);
        logger.log(this, "item list parsed.");
    }

    private function parseItem(object:Object, index:int, array:Array):void
    {
        //todo:Запилить здесь высоту айтемов. Пока 100
        var contentUrl:String = flashVars.content_url+object.swf_url;
        var item:Item = new Item();
        item.key = object._id;
        item.skinUrl=contentUrl;
        item.width=object.size_x*IsoConfig.CELL_SIZE;
        item.length=object.size_y*IsoConfig.CELL_SIZE;
        item.item_name=object.name;
        item.height=100;

        itemListModel.set(item.key, item);
    }
}
}
