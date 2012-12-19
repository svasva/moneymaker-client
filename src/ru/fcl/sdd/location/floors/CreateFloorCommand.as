/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 17:59
 */
package ru.fcl.sdd.location.floors
{
import de.polygonal.ds.HashMapValIterator;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.item.ItemIsoView;
import ru.fcl.sdd.item.PlaceItemCommand;
import ru.fcl.sdd.item.UserItemList;
import ru.fcl.sdd.pathfind.PlacePathGridItemCommand;
import ru.fcl.sdd.scenes.FloorScene;

public class CreateFloorCommand extends SignalCommand
{
    [Inject]
    public var userItems:UserItemList;
    [Inject]
    public var floorScene:FloorScene;

    override public function execute():void
    {

        var iterator:HashMapValIterator = userItems.iterator() as HashMapValIterator;
        iterator.reset();
        while(iterator.hasNext())
        {
            var item:ItemIsoView = iterator.next() as ItemIsoView;
            //todo:проверить айтем на соответствие этажу.
            commandMap.execute(PlaceItemCommand,item);
            commandMap.execute(PlacePathGridItemCommand,item);
        }

    }
}
}
