/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:21
 */
package ru.fcl.sdd.homus
{
import com.flashdynamix.motion.Tweensy;

import fl.motion.easing.Linear;

import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.item.ItemIsoView;
import ru.fcl.sdd.item.UserItemList;
import ru.fcl.sdd.pathfind.AStar;
import ru.fcl.sdd.pathfind.PathGrid;
import ru.fcl.sdd.location.floors.Floor1Scene;

public class ClientusIsoViewMediator extends Mediator
{
    [Inject]
    public var pathGrid:PathGrid;
    [Inject]
    public var userItems:UserItemList;
    [Inject]
    public var clientusView:ClientusIsoView;
    [Inject]
    public var floor:Floor1Scene;

    private var path:Array;
    private var _state:int;
    private var aStar:AStar;
    private var item:ItemIsoView;
    private var _directionAtEnd:int;


    override public function onRegister():void
    {
        aStar = new AStar();
        clientusView.x = 14 * IsoConfig.CELL_SIZE;
        pathGrid.setStartNode(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE);
        item = userItems.get(clientusView.needItemId) as ItemIsoView;
        pathGrid.setEndNode(item.enterPoint.x, item.enterPoint.y);
        findPath();
        checkDirections();
        startWalk();
    }

    protected function findPath():void
    {
        if (aStar.findPath(pathGrid))
        {
            path = aStar.path;
        }
    }

    private function startWalk():void
    {
        _state = ClientusIsoView.START;
        clientusView.setDirection(path[0].direction,_state);
        Tweensy.to(clientusView, {x: path[1].x * IsoConfig.CELL_SIZE, y: path[1].y * IsoConfig.CELL_SIZE}, 0.5, Linear.easeNone, 0, null,goToCell);
        path.shift();

    }

    private function goToCell():void
    {
        if (path.length > 2)
        {
            _state = ClientusIsoView.WALK;
            Tweensy.to(clientusView, {x: path[1].x * IsoConfig.CELL_SIZE, y: path[1].y * IsoConfig.CELL_SIZE}, 0.5, Linear.easeNone, 0, null,goToCell);
            clientusView.setDirection(path[0].direction,_state);
            path.shift();

        }else
        if(path.length>1)
        {
            _state = ClientusIsoView.STOP;
            clientusView.setDirection(path[0].direction,_state);
            Tweensy.to(clientusView, {x: path[1].x * IsoConfig.CELL_SIZE, y: path[1].y * IsoConfig.CELL_SIZE}, 0.5, Linear.easeNone, 0, null,goToCell);
            path.shift();
        }else
        if(path.length==1)
        {
            _state = ClientusIsoView.STOPPED;
            clientusView.setDirection(_directionAtEnd,_state);
        }
        floor.render();
    }


    private function checkDirections():void
    {
        for (var i:int = 0; i < path.length-1; i++)
        {
                if(path[i].x<path[i+1].x)
                {
                    path[i].direction = ClientusIsoView.EAST;
                }else
                if(path[i].x>path[i+1].x)
                {
                    path[i].direction = ClientusIsoView.WEST;
                }else
                if(path[i].y<path[i+1].y)
                {
                    path[i].direction = ClientusIsoView.SOUTH;
                }else
                if(path[i].y>path[i+1].y)
                {
                    path[i].direction = ClientusIsoView.NORTH;
                }
        }
        switch (item.direction)
        {
            case ItemIsoView.NORTH:
            {
                _directionAtEnd = ClientusIsoView.SOUTH;
                break;
            }
            case ItemIsoView.SOUTH:
            {
                _directionAtEnd = ClientusIsoView.NORTH;
                break;
            }
            case ItemIsoView.WEST:
            {
                _directionAtEnd = ClientusIsoView.EAST;
                break;
            }
            case ItemIsoView.EAST:
            {
                _directionAtEnd = ClientusIsoView.WEST;
                break;
            }
        }
    }




}
}
