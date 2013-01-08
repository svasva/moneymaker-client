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

import flash.events.Event;
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
import ru.fcl.sdd.pathfind.Node;

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
    private var isNextFrame:Boolean = false;
    private var prevNode:Node;


    override public function onRegister():void
    {
        Tweensy.refreshType = Tweensy.FRAME;
        Tweensy.secondsPerFrame = 1/24;
        aStar = new AStar();
        clientusView.x = 13 * IsoConfig.CELL_SIZE;
        clientusView.y = 1 * IsoConfig.CELL_SIZE;
        nextStep();
    }

    private function nextStep():void
    {
        var startX:int = clientusView.x / IsoConfig.CELL_SIZE;
        var startY:int = clientusView.y / IsoConfig.CELL_SIZE;
        var endX:int;
        var endY:int;
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
        path.shift();
        if (path.length == 0)
        {
            setTimeout(nextStep, 3000);
        }
        else
        {
            tryGoToNextCell();
        }
    }

    private function tryGoToNextCell():void
    {

//
//        if((path[0])&&(!homusPathGrid.getNode(path[0].x, path[0].y).walkable))
//        {
//            setTimeout(tryGoToNextCell,1000);
//        } else
        {
            var direction:int;
            var state:int;
                switch (path.length)
                {
                    case 0:
                    {
                        state = ClientusIsoView.STOP;
                        direction = checkDirection(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE, clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE);
                        setDirection(state, direction, true);
                        break;
                    }
                    default :
                    {
                        if (prevNode)
                        {
                            homusPathGrid.getNode(prevNode.x, prevNode.y).walkable = true;
                        }
                        direction = checkDirection(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE, path[0].x, path[0].y);
                        state = ClientusIsoView.WALK;
                        setDirection(state, direction);
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
            var operation = clientusView.operations.shift();
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
//            path = null;
        return path;
    }

    private function setDirection(state:int, direction:int, endPath:Boolean = false):void
    {
//        floor.render();
        clientusView.setDirection(direction, state);
        if (!endPath)
        {
//            clientusView.addEventListener(Event.ENTER_FRAME, setDirectionCompleteHandler);
//            setDirectionCompleteHandler(null);
            goToCell();
        }
        else
        {
            if (clientusView.operations.length)
            {
                setTimeout(nextStep, 3000);
            }
            else
            {
                setTimeout(removeClientus, 1000);
            }
        }
    }

    private function goToCell():void
    {
        if (prevNode)
        {
            prevNode.x = clientusView.x / IsoConfig.CELL_SIZE;
            prevNode.y = clientusView.y / IsoConfig.CELL_SIZE;
        }
        else
        {
            prevNode = new Node(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE);
        }
        homusPathGrid.getNode(prevNode.x, prevNode.y).walkable = false;
        Tweensy.to(clientusView, {x: path[0].x * IsoConfig.CELL_SIZE, y: path[0].y * IsoConfig.CELL_SIZE}, 0.5, Linear.easeNone, 0, null, tryGoToNextCell);
        path.shift();
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
        floor.removeChild(clientusView);
    }

}
}
