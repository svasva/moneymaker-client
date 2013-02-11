/**
 * User: Jessie
 * Date: 12.12.12
 * Time: 11:31
 */
package ru.fcl.sdd.pathfind
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildPathFind extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(HomusPathGrid);
        var humansPathGrid:HomusPathGrid = injector.getInstance(HomusPathGrid);
        humansPathGrid.init(26,11);

        injector.mapSingleton(ItemsPathGrid);
        var itemsPathGrid:ItemsPathGrid = injector.getInstance(ItemsPathGrid);
        //fixme: вынести размеры сетки в конфиг.
        itemsPathGrid.init(26,44);
    }
}
}
