/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 17:59
 */
package ru.fcl.sdd.location.floors
{
import de.polygonal.ds.HashMapValIterator;

import org.osflash.signals.ISignal;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.item.ItemIsoView;
import ru.fcl.sdd.item.PlaceItemCommand;
import ru.fcl.sdd.item.ActiveUserItemList;
import ru.fcl.sdd.pathfind.PlacePathGridItemCommand;

public class CreateFloorsCommand extends SignalCommand
{
    [Inject]
    public var userItems:ActiveUserItemList;

    override public function execute():void
    {
        injector.mapSingleton(Floor1Scene);

        var mainIsoScene:Floor1Scene = injector.getInstance(Floor1Scene);
        commandMap.execute(ChangeFloorCommand,1);
        var iterator:HashMapValIterator = userItems.iterator() as HashMapValIterator;
        iterator.reset();

        while(iterator.hasNext())
        {
            var item:ItemIsoView = iterator.next() as ItemIsoView;
            commandMap.execute(PlaceItemCommand,item);
            commandMap.execute(PlacePathGridItemCommand,item);
        }

    }
}
}
