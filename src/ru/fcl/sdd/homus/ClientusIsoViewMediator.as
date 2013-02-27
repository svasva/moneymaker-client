/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:21
 */
package ru.fcl.sdd.homus
{
import com.flashdynamix.motion.Tweensy;
import ru.fcl.sdd.location.floors.FloorItemScene;
import ru.fcl.sdd.pathfind.FloorPathGridItemList;
import ru.fcl.sdd.scenes.MainIsoView;
import ru.fcl.sdd.services.main.ISender;

import de.polygonal.ds.HashMapValIterator;

import eDpLib.events.ProxyEvent;

import fl.motion.easing.Linear;

import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.filters.GlowFilter;
import flash.utils.Timer;
import flash.utils.setTimeout;

import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.item.ActiveUserItemList;
import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.item.ItemCatalog;
import ru.fcl.sdd.item.iso.ItemIsoView;

import ru.fcl.sdd.pathfind.AStar;
import ru.fcl.sdd.pathfind.HomusPathGrid;
import ru.fcl.sdd.pathfind.ItemsPathGrid;

public class ClientusIsoViewMediator extends Mediator
{
    [Inject]
    public var pathGrids:FloorPathGridItemList;
    [Inject]
    public var homusPathGrid:HomusPathGrid;
    [Inject]
    public var userItems:ActiveUserItemList;
    [Inject]
    public var itemCatalog:ItemCatalog;
    [Inject]
    public var clientusView:ClientusIsoView;
   
    [Inject]
    public var outOfScheduleSignal:OutOfScheduleSignal;

    [Inject]
    public var homusMouseOutSignal:HomusMouseOutSignal;
    [Inject]
    public var homusMouseOverSignal:HomusMouseOverSignal;

    [Inject]
    public var operationSuccessSignal:OperationSuccessSignal;
//    [Inject]
//    public var operationFailedSignal:OperationFailedSignal;
    [Inject]
    public var sender:ISender;

 [Inject]
    public var mainisoView:MainIsoView;
	
    private var _path:Array;
    private var _aStar:AStar;
    private var _target:ItemIsoView;
    private var _freeCellWaitTime:int;
    private var _freeCellWaitTryCount:int;
    private var _endX:int;
    private var _endY:int;
    private var _targetCatalogItem:Item;
    private var _currentOperation:ClientOperation;
    private var _inStack:Boolean = false;
    private var _isOutOfSchedule:Boolean = false;
    private var _isEndOfSequence:Boolean = false;
    private var _selectFilter:GlowFilter = new GlowFilter(0xFFEF80, 1, 4, 4, 2, 1);
	private var itemPathGrid:ItemsPathGrid;




    override public function onRegister():void
    {
		itemPathGrid =  pathGrids.get(1) as ItemsPathGrid;
        _freeCellWaitTime = Math.random() * 2000 + 1000;
        Tweensy.refreshType = Tweensy.FRAME;
        Tweensy.secondsPerFrame = 1 / 24;
        _aStar = new AStar();
        clientusView.leaveTimer.addEventListener(TimerEvent.TIMER_COMPLETE, clientWaitTimer_timerCompleteHandler);
        clientusView.startTimer();
        clientusView.x = 13 * IsoConfig.CELL_SIZE;
        clientusView.y = 1 * IsoConfig.CELL_SIZE;
        clientusView.addEventListener(MouseEvent.MOUSE_OVER, clientusView_mouseOverHandler);
        clientusView.addEventListener(MouseEvent.MOUSE_OUT, clientusView_mouseOutHandler);
        nextStep(true);
        
        
    }

    private function nextStep(isStart:Boolean = false):void
    {
        _inStack = false;
        if (!isStart)
        {
            for (var i:int = _target.clientStack.length - 1; i >= 0; i--)
            {
                if (_target.clientStack[i] == homusPathGrid.getNode(_path[0].x, _path[0].y))
                {
                    _target.clientStack.slice(i, 1);
                }
            }
            homusPathGrid.getNode(_path[0].x, _path[0].y).walkable = true;
            _path.shift();
        }
        var startX:int = clientusView.x / IsoConfig.CELL_SIZE;
        var startY:int = clientusView.y / IsoConfig.CELL_SIZE;

        _target = selectTarget();

        if (_target)
        {
            _endX = _target.enterPoint.x;
            _endY = _target.enterPoint.y;
        }
        else
        {
            _endX = IsoConfig.START_CLIENTUS_CELL_X - 2;
            _endY = IsoConfig.START_CLIENTUS_CELL_Y;
        }

        _path = findPath(startX, startY, _endX, _endY);
        if(!_path)
        {
            _endX = IsoConfig.START_CLIENTUS_CELL_X - 2;
            _endY = IsoConfig.START_CLIENTUS_CELL_Y;
            _path = findPath(startX, startY, _endX, _endY);
        }
        tryGoToNextCell(isStart);
    }

    private function tryGoToNextCell(isStart:Boolean = false):void
    {
        if (!isStart && _path)
        {
             homusPathGrid.getNode(_path[0].x, _path[0].y).walkable = true;
            _path.shift();
        }
        if ((_path[1]) && (!homusPathGrid.getNode(_path[1].x, _path[1].y).walkable))
        {
            state = ClientusIsoView.STOP;
            clientusView.setDirection(clientusView.currentDirection, state); //todo: make direction is correct.
            if (_target)
            {
                for (var i:int = _target.clientStack.length - 1; i >= 0; i--)
                {
                    if (homusPathGrid.getNode(_path[0].x, _path[0].y) == _target.clientStack[i])
                    {
                        _inStack = true;
                    }
                }
            }

            switch (_inStack)
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
                        itemPathGrid.getNode(_path[1].x, _path[1].y).walkable = false;
                        _path = findPath(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE, _endX, _endY);
                        itemPathGrid.getNode(_path[1].x, _path[1].y).walkable = true;
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
            switch (_path.length)
            {
                case 1:
                {
                    state = ClientusIsoView.STOP;
                    direction = checkDirection(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE, clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE);
                    clientusView.setDirection(direction, state);
                    if (_target)
                    {
                        _target.clientStack.push(homusPathGrid.getNode(_path[0].x, _path[0].y));
                    }

                    if (clientusView.operations.length)
                    {
                         trace("НАЧАЛО ОБСЛУЖИВАНИЯ");
                      sender.send( {command:"startClientService",args:[_target.key,clientusView.key,_currentOperation.id] } )
                        setTimeout(completeOperation, _targetCatalogItem.serviceSpeed);
                    }
                    else
                    {
                        if (!_isEndOfSequence)
                        {
                            _isEndOfSequence = true;
                            setTimeout(nextStep, _targetCatalogItem.serviceSpeed);
                        }
                        else
                        {
                                setTimeout(removeClientus, 1000);
                        }
                    }
                    break;
                }
                case 0: //walk to some place/item
                {
//                    state = ClientusIsoView.STOP;
//                    direction = checkDirection(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE, clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE);
//                    clientusView.setDirection(direction, state);
                    if (_target)
                    {
                        _target.clientStack.push(homusPathGrid.getNode(clientusView.x/IsoConfig.CELL_SIZE, clientusView.y/IsoConfig.CELL_SIZE));
                    }

                    if (clientusView.operations.length)
                    {
                         trace("НАЧАЛО ОБСЛУЖИВАНИЯ");
                        sender.send( {command:"startClientService",args:[_target.key,clientusView.key,_currentOperation.id] } )
                        setTimeout(completeOperation, _targetCatalogItem.serviceSpeed);
                    }
                    else
                    {
                        if (!_isEndOfSequence)
                        {
                            _isEndOfSequence = true;
                            setTimeout(nextStep, _targetCatalogItem.serviceSpeed);
                        }
                        else
                        {
                                setTimeout(removeClientus, 1000);
                        }
                    }
                    break;
                }
                default :
                {
                    homusPathGrid.getNode(_path[1].x, _path[1].y).walkable = false;
                    direction = checkDirection(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE, _path[1].x, _path[1].y);
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
        operationSuccessSignal.dispatch(clientusView);
        _target.cashMoney += _currentOperation.money; //fixme:Перепупырить это в сигнал и ловить в медиаторе айтема.
        nextStep();
    }

    private function selectTarget():ItemIsoView
    {
        var target:ItemIsoView;
        if (clientusView.operations.length)
        {
            _currentOperation = clientusView.operations.shift();
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
                            if (item.operations[i] == _currentOperation.id)
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
                _targetCatalogItem = avaibleItems[moreFreer].catalogItem;
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
        _aStar.findPath(itemPathGrid);
        _path = _aStar.path;
        return _path;
    }

    private function goToCell():void
    {
        Tweensy.to(clientusView, {x: _path[1].x * IsoConfig.CELL_SIZE, y: _path[1].y * IsoConfig.CELL_SIZE}, 0.5, Linear.easeNone, 0, null, tryGoToNextCell);
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
        else if ((_target) && (nodeFromX == nodeToX) && (nodeFromY == nodeToY))
        {
            switch (_target.direction)
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
        else if ((!_target) && (nodeFromX == nodeToX) && (nodeFromY == nodeToY))
        {
            return ClientusIsoView.NORTH;
        }
        return null;
    }

    private function removeClientus():void
    {
        homusPathGrid.getNode(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE).walkable = true;
        if (_target)
        {
            for (var i:int = _target.clientStack.length - 1; i >= 0; i--)
            {
                if (_target.clientStack[i] == homusPathGrid.getNode(clientusView.x / IsoConfig.CELL_SIZE, clientusView.y / IsoConfig.CELL_SIZE))
                {
                    _target.clientStack.slice(i, 1);
                }
            }
        }
        _path.shift();
        mainisoView.currentFloor.removeChild(clientusView);
        if (_isOutOfSchedule)
        {
            outOfScheduleSignal.dispatch();
        }
    }

    private function clientWaitTimer_timerCompleteHandler(event:TimerEvent):void
    {
        var position:int = 10;
        if (_target)
        {
            while (clientusView.operations.length != 0)
            {
                clientusView.operations.shift();
                _isOutOfSchedule = true;
            }
            if(_inStack)
            {
                for (var i:int = 0; i < _target.clientStack.length; i++)
                {
                    if(_target.clientStack[i]==homusPathGrid.getNode(clientusView.x/IsoConfig.CELL_SIZE,clientusView.y/IsoConfig.CELL_SIZE))
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
        DisplayObject(clientusView.sprites[0]).filters = [_selectFilter];
        homusMouseOverSignal.dispatch(clientusView);
    }

    private function clientusView_mouseOutHandler(event:ProxyEvent):void
    {
        DisplayObject(clientusView.sprites[0]).filters = [];
        homusMouseOutSignal.dispatch();
    }
}
}
