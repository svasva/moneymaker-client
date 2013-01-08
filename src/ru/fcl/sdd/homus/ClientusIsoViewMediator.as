/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:21
 */
package ru.fcl.sdd.homus
{
import com.flashdynamix.motion.Tweensy;

import de.polygonal.ds.HashMapValIterator;

import fl.motion.easing.Linear;

import flash.utils.setTimeout;

import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.item.ItemCatalog;
import ru.fcl.sdd.item.ItemIsoView;
import ru.fcl.sdd.item.UserItemList;
import ru.fcl.sdd.location.floors.Floor1Scene;
import ru.fcl.sdd.pathfind.AStar;
import ru.fcl.sdd.pathfind.HomusPathGrid;
import ru.fcl.sdd.pathfind.ItemsPathGrid;

public class ClientusIsoViewMediator extends Mediator
{
    [Inject]
    public var itemPathGrid:ItemsPathGrid;
    [Inject]
    public var homusPathGrid:HomusPathGrid;
    [Inject]
    public var userItems:UserItemList;
    [Inject]
    public var itemCatalog:ItemCatalog;
    [Inject]
    public var clientusView:ClientusIsoView;
    [Inject]
    public var floor:Floor1Scene;

    private var path:Array;
    private var aStar:AStar;
    private var target:ItemIsoView;
    private var _freeCellWaitTime:int;
    private var _freeCellWaitTryCount:int;
    private var endX:int;
    private var endY:int;

    override public function onRegister():void
    {
        _freeCellWaitTime = Math.random() * 2000 + 1000;
        Tweensy.refreshType = Tweensy.FRAME;
        Tweensy.secondsPerFrame = 1 / 24;
        aStar = new AStar();
        clientusView.x = 13 * IsoConfig.CELL_SIZE;
        clientusView.y = 1 * IsoConfig.CELL_SIZE;
        nextStep(true);
    }

    private function nextStep(isStart:Boolean = false):void
    {
        if (!isStart)
        {
            homusPathGrid.getNode(path[0].x, path[0].y).walkable = true;
            path.shift();
        }
        var startX:int = clientusView.x / IsoConfig.CELL_SIZE;
        var startY:int = clientusView.y / IsoConfig.CELL_SIZE;

        target = selectTarget();

        if (target)
        {
            endX = target.enterPoint.x;
            endY = target.enterPoint.y;
        }
        else
        {
            endX = IsoConfig.START_CLIENTUS_CELL_X;
            endY = IsoConfig.START_CLIENTUS_CELL_Y;
        }
        path = findPath(startX, startY, endX, endY);
        if (path.length == 1)
        {
            setTimeout(nextStep, 3000);
        }
        else
        {
            tryGoToNextCell(isStart);
        }
    }

    private function tryGoToNextCell(isStart:Boolean = false):void
    {
        if (!isStart)
        {
            homusPathGrid.getNode(path[0].x, path[0].y).walkable = true;
            path.shift();
        }
        if ((path[1]) && (!homusPathGrid.getNode(path[1].x, path[1].y).walkable))
        {
            state = ClientusIsoView.STOP;
            clientusView.setDirection(clientusView.currentDirection, state);
            if (_freeCellWaitTryCount >0)
            {
                setTimeout(tryGoToNextCell, _freeCellWaitTime,true);
                _freeCellWaitTryCount--;
            }
            else
            {
                itemPathGrid.getNode(path[1].x, path[1].y).walkable=false;
                path = findPath(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE, endX, endY);
                itemPathGrid.getNode(path[1].x, path[1].y).walkable=true;
                _freeCellWaitTryCount = 4;
                tryGoToNextCell(true);
            }
        }
        else
        {
            var direction:int;
            var state:int;
            switch (path.length)
            {
                case 1:
                {
                    state = ClientusIsoView.STOP;
                    direction = checkDirection(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE, clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE);
                    clientusView.setDirection(direction, state);
                    if (clientusView.operations.length)
                    {
                        setTimeout(nextStep, 3000);
                    }
                    else
                    {
                        setTimeout(removeClientus, 1000);
                    }
                    break;
                }
                default :
                {
                    homusPathGrid.getNode(path[1].x, path[1].y).walkable = false;
                    direction = checkDirection(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE, path[1].x, path[1].y);
                    state = ClientusIsoView.WALK;
                    clientusView.setDirection(direction, state);
                    goToCell();
                    break;
                }
            }
        }
    }

    private function selectTarget():ItemIsoView
    {
        var target:ItemIsoView;
        if (clientusView.operations.length)
        {
            var operation:String = clientusView.operations.shift();
            var iterator:HashMapValIterator = userItems.iterator() as HashMapValIterator;
            var item:Item;
            var itemIsoView:ItemIsoView;
            var avaibleItems:Array = [];
            iterator.reset();
            while (iterator.hasNext())
            {
                itemIsoView = iterator.next() as ItemIsoView;
                item = itemCatalog.get(itemIsoView.catalogKey) as Item;
                if (item)
                {
                    if (item.operations)
                    {
                        for (var i:int = 0; i < item.operations.length; i++)
                        {
                            if (item.operations[i] == operation)
                            {
                                avaibleItems[avaibleItems.length] = itemIsoView;
                            }
                        }
                    }
                }
            }
            target = avaibleItems.pop() as ItemIsoView;
        }
        else
        {
            target = null;
        }
        return target;
    }

    protected function findPath(startNodeX:int, startNodeY:int, endNodeX:int, endNodeY:int):Array
    {
        itemPathGrid.setStartNode(startNodeX, startNodeY);
        itemPathGrid.setEndNode(endNodeX, endNodeY);
        aStar.findPath(itemPathGrid);
        path = aStar.path;
        return path;
    }

    private function goToCell():void
    {
        Tweensy.to(clientusView, {x: path[1].x * IsoConfig.CELL_SIZE, y: path[1].y * IsoConfig.CELL_SIZE}, 0.5, Linear.easeNone, 0, null, tryGoToNextCell);
    }

    private function checkDirection(nodeFromX:int, nodeFromY:int, nodeToX:int, nodeToY:int):int
    {
        if (nodeFromX > nodeToX)
        {
            return ClientusIsoView.WEST;
        }
        else if (nodeFromX < nodeToX)
        {
            return ClientusIsoView.EAST;
        }
        else if (nodeFromY > nodeToY)
        {
            return ClientusIsoView.NORTH;
        }
        else if (nodeFromY < nodeToY)
        {
            return ClientusIsoView.SOUTH;
        }
        else if ((target) && (nodeFromX == nodeToX) && (nodeFromY == nodeToY))
        {
            switch (target.direction)
            {
                case ItemIsoView.EAST:
                {
                    return ClientusIsoView.WEST;
                    break;
                }
                case ItemIsoView.WEST:
                {
                    return ClientusIsoView.EAST;
                    break;
                }
                case ItemIsoView.SOUTH:
                {
                    return ClientusIsoView.NORTH;
                    break;
                }
                case ItemIsoView.NORTH:
                {
                    return ClientusIsoView.SOUTH;
                    break;
                }
            }
        }
        else if ((!target) && (nodeFromX == nodeToX) && (nodeFromY == nodeToY))
        {
            return ClientusIsoView.NORTH;
        }
        return null;
    }

    private function removeClientus():void
    {
        homusPathGrid.getNode(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE).walkable = true;
        path.shift();
        floor.removeChild(clientusView);
    }
}
}
