/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:21
 */
package ru.fcl.sdd.homus
{
import flash.utils.setTimeout;

import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.item.ItemIsoView;
import ru.fcl.sdd.item.UserItemList;
import ru.fcl.sdd.pathfind.AStar;
import ru.fcl.sdd.pathfind.PathGrid;
import ru.fcl.sdd.scenes.FloorScene;

public class ClientusIsoViewMediator extends Mediator
{
    [Inject]
    public var pathGrid:PathGrid;
    [Inject]
    public var userItems:UserItemList;
    [Inject]
    public var clientusView:ClientusIsoView;
    [Inject]
    public var floor:FloorScene;
    private var path:Array;
    private var _direction:int;
    private var _state:int;

    override public function onRegister():void
    {
        clientusView.x = 14 * IsoConfig.CELL_SIZE;
        pathGrid.setStartNode(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE);
        var item:ItemIsoView = userItems.get(clientusView.needItemId) as ItemIsoView;
        pathGrid.setEndNode(item.enterPoint.x, item.enterPoint.y);
        findPath();
    }

    protected function findPath():void
    {
        var astar:AStar = new AStar();

        if (astar.findPath(pathGrid))
        {
            path = astar.path;
        }

        gotoCell();
    }

    private function gotoCell():void
    {
        clientusView.x = path[0].x * IsoConfig.CELL_SIZE;
        clientusView.y = path[0].y * IsoConfig.CELL_SIZE;
        if (path.length - 1)
        {
            path.shift();
            setTimeout(gotoCell, 200);
        }
        floor.render();
    }



}
}
