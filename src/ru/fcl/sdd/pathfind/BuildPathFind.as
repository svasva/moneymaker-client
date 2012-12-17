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
        injector.mapSingleton(PathGrid);
        var pathGrid:PathGrid = injector.getInstance(PathGrid);
        //fixme: вынести размеры сетки в конфиг.
        pathGrid.init(26,11);
    }
}
}
