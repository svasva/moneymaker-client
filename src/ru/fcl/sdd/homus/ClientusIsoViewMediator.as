/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:21
 */
package ru.fcl.sdd.homus
{
import com.flashdynamix.motion.Tweensy;

import de.polygonal.ds.HashMapValIterator;

import eDpLib.events.ProxyEvent;

import fl.motion.easing.Linear;

import flash.display.DisplayObject;

import flash.display.MovieClip;

import flash.events.MouseEvent;

import flash.events.TimerEvent;
import flash.filters.GlowFilter;

import flash.utils.Timer;

import flash.utils.setTimeout;

import org.aswing.event.ModelEvent;

import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.item.ActiveUserItemList;
import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.item.ItemCatalog;
import ru.fcl.sdd.item.ItemIsoView;
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
    public var userItems:ActiveUserItemList;
    [Inject]
    public var itemCatalog:ItemCatalog;
    [Inject]
    public var clientusView:ClientusIsoView;
    [Inject]
    public var floor:Floor1Scene;
    [Inject]
    public var outOfScheduleSignal:OutOfScheduleSignal

    private var path:Array;
    private var aStar:AStar;
    private var target:ItemIsoView;
    private var _freeCellWaitTime:int;
    private var _freeCellWaitTryCount:int;
    private var endX:int;
    private var endY:int;
    private var targetCatalogItem:Item;
    private var currentOperation:ClientOperation;
    private var clientWaitTimer:Timer;
    private var inStack:Boolean = false;
    private var _isOutOfSchedule:Boolean = false;
    private var _isEndOfSequence:Boolean = false;
    private var selectFilter:GlowFilter = new GlowFilter(0xFFEF80,1,4,4,2,1);


    override public function onRegister():void
    {
        _freeCellWaitTime = Math.random() * 2000 + 1000;
        Tweensy.refreshType = Tweensy.FRAME;
        Tweensy.secondsPerFrame = 1 / 24;
        aStar = new AStar();
        clientWaitTimer = new Timer(clientusView.maxWaiTime);
        clientWaitTimer.addEventListener(TimerEvent.TIMER_COMPLETE, clientWaitTimer_timerCompleteHandler);
        clientWaitTimer.start();
        clientusView.x = 13 * IsoConfig.CELL_SIZE;
        clientusView.y = 1 * IsoConfig.CELL_SIZE;
        clientusView.addEventListener(MouseEvent.MOUSE_OVER, clientusView_mouseOverHandler);
        clientusView.addEventListener(MouseEvent.MOUSE_OUT, clientusView_mouseOutHandler);
        nextStep(true);
    }

    private function nextStep(isStart:Boolean = false):void
    {
        inStack = false;
        if (!isStart)
        {
            for (var i:int = target.clientStack.length - 1; i >= 0; i--)
            {
                if (target.clientStack[i] == homusPathGrid.getNode(path[0].x, path[0].y))
                {
                    target.clientStack.slice(i, 1);
                }
            }
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
            endX = IsoConfig.START_CLIENTUS_CELL_X - 2;
            endY = IsoConfig.START_CLIENTUS_CELL_Y;
        }
        path = findPath(startX, startY, endX, endY);
        if(!path)
        {
            endX = IsoConfig.START_CLIENTUS_CELL_X - 2;
            endY = IsoConfig.START_CLIENTUS_CELL_Y;
            path = findPath(startX, startY, endX, endY);//fixme: чел не может пройти к объекту.
        }
//        if (path.length == 1)
//        {
//            homusPathGrid.getNode(path[0].x, path[0].y).walkable = false;
//            setTimeout(nextStep,);
//        }
//        else
//        {
        tryGoToNextCell(isStart);
//        }
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
            clientusView.setDirection(clientusView.currentDirection, state); //todo: make direction is correct.
            if (target)
            {
                for (var i:int = target.clientStack.length - 1; i >= 0; i--)
                {
                    if (homusPathGrid.getNode(path[0].x, path[0].y) == target.clientStack[i])
                    {
                        inStack = true;
                    }
                }
            }

            switch (inStack)
            {
                case false:
                {
                    if (_freeCellWaitTryCount > 0)
                    {
                        setTimeout(tryGoToNextCell, _freeCellWaitTime, true);
                        _freeCellWaitTryCount--;
                    }
                    else
                    {
                        itemPathGrid.getNode(path[1].x, path[1].y).walkable = false;
                        path = findPath(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE, endX, endY);
                        itemPathGrid.getNode(path[1].x, path[1].y).walkable = true;
                        _freeCellWaitTryCount = 4;
                        tryGoToNextCell(true);
                    }
                    break;
                }
                case true:
                {
                    setTimeout(tryGoToNextCell, _freeCellWaitTime, true);
                }
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
                    if (target)
                    {
                        target.clientStack.push(homusPathGrid.getNode(path[0].x, path[0].y));
                    }

                    if (clientusView.operations.length)
                    {
                        setTimeout(completeOperation, targetCatalogItem.serviceSpeed);
                    }
                    else
                    {
                        if (!_isEndOfSequence)
                        {
                            _isEndOfSequence = true;
                            setTimeout(nextStep, targetCatalogItem.serviceSpeed);
                        }
                        else
                        {
//                            if (!_isOutOfSchedule)
//                            {
//                                setTimeout(removeClientus, targetCatalogItem.serviceSpeed);
//                            }
//                            else
//                            {
                                setTimeout(removeClientus, 1000);
//                            }
                        }
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

    private function completeOperation():void
    {
        target.cashMoney += currentOperation.money;
        nextStep();
    }

    private function selectTarget():ItemIsoView
    {
        var target:ItemIsoView;
        if (clientusView.operations.length)
        {
            currentOperation = clientusView.operations.shift();
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
                            if (item.operations[i] == currentOperation.id)
                            {
                                avaibleItems[avaibleItems.length] = {iso: itemIsoView, catalogItem: item};
                            }
                        }
                    }
                }
            }
            if (avaibleItems.length > 0)
            {
                var moreFreer:int;
                var minTime:int;
                minTime = ItemIsoView(avaibleItems[length - 1].iso).clientStack.length * Item(avaibleItems[length - 1].catalogItem).serviceSpeed;
                for (var i:int = avaibleItems.length - 2; i >= 0; i--)
                {
                    if ((ItemIsoView(avaibleItems[i].iso).clientStack.length * Item(avaibleItems[i].catalogItem).serviceSpeed) < minTime)
                    {
                        minTime = ItemIsoView(avaibleItems[i].iso).clientStack.length * Item(avaibleItems[i].catalogItem).serviceSpeed;
                        moreFreer = i;
                    }
                }
                target = avaibleItems[moreFreer].iso;
                targetCatalogItem = avaibleItems[moreFreer].catalogItem;
            }
            else
            {
                target = null;
            }
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
        if (target)
        {
            for (var i:int = target.clientStack.length - 1; i >= 0; i--)
            {
                if (target.clientStack[i] == homusPathGrid.getNode(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE))
                {
                    target.clientStack.slice(i, 1);
                }
            }
        }
        path.shift();
        floor.removeChild(clientusView);
        if (_isOutOfSchedule)
        {
            outOfScheduleSignal.dispatch();
        }
    }

    private function clientWaitTimer_timerCompleteHandler(event:TimerEvent):void
    {
        var position:int = 10;
        if (target)
        {
            while (clientusView.operations.length != 0)
            {
                clientusView.operations.shift();
                _isOutOfSchedule = true;
            }
            if(inStack)
            {
                for (var i:int = 0; i < target.clientStack.length; i++)
                {
                    if(target.clientStack[i]==homusPathGrid.getNode(clientusView.x/IsoConfig.CELL_SIZE,clientusView.y/IsoConfig.CELL_SIZE))
                    {
                        position = i;
                    }
                }
            }
            if (position > 2)
            {
                nextStep(); //todo: В следующий раз отправить на сервер, что клиент уходит раньше срока.
            }
        }
    }

    private function clientusView_mouseOverHandler(event:ProxyEvent):void
    {
        DisplayObject(clientusView.sprites[0]).filters = [selectFilter];
    }

    private function clientusView_mouseOutHandler(event:ProxyEvent):void
    {
        DisplayObject(clientusView.sprites[0]).filters = [];
    }
}
}
