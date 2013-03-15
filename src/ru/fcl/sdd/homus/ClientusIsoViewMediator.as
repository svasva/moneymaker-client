/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:21
 */
package ru.fcl.sdd.homus
{
import com.flashdynamix.motion.Tweensy;
import ru.fcl.sdd.location.floors.FloorItemScene;
import ru.fcl.sdd.location.floors.FloorsList;
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
	
	[Inject]
	public var startServiceSig:StartServiceSignal;
	
//    [Inject]
//    public var operationFailedSignal:OperationFailedSignal;
    [Inject]
    public var sender:ISender;

    [Inject]
    public var mainisoView:MainIsoView;
	
	[Inject]
    public var floorList:FloorsList;
	
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
	private var _isServing:Boolean = false;	

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
		clientusView.addEventListener(HomusEvent.NO_SERVICE, clientusView_noService);
		clientusView.addEventListener(HomusEvent.END_OPERATION, clientusView_endOperation);
        nextStep(true);        
    }
	
	private function clientusView_endOperation(e:HomusEvent):void 
	{
		_isServing  = false;
		completeOperation();
	}
	
	private function clientusView_noService(e:HomusEvent):void 
	{
		_isServing  = false;
		nextStep();
	}

    private function nextStep(isStart:Boolean = false):void
    {
        _inStack = false;
        //проверка на первый шаг
		if (!isStart)
        {
            if(_target)
			{
				for (var i:int = _target.clientStack.length - 1; i >= 0; i--)
				{
					if (_target.clientStack[i] == homusPathGrid.getNode(_path[0].x, _path[0].y))
					{
						_target.clientStack.slice(i, 1);
					}
				}
			}
            homusPathGrid.getNode(_path[0].x, _path[0].y).walkable = true;
            _path.shift();
        }
        var startX:int = clientusView.x / IsoConfig.CELL_SIZE;
        var startY:int = clientusView.y / IsoConfig.CELL_SIZE;

        //ищем банкомат или кассу.
		_target = selectTarget();
		clientusView.target = _target;

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
    /**
     * переход на следующую игровую клетку. 
     * @param	isStart
     */
    private function tryGoToNextCell(isStart:Boolean = false):void
    {
		if (!_path) return;
        if (!isStart && _path)
        {
            //если начали движение берём  первую ячейку пути и закрашиваем.  
			homusPathGrid.getNode(_path[0].x, _path[0].y).walkable = true;
           //удаляем первый элемент массива - первую ячейку. 
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
                    //Если в очереди, то ждём своей очереди. 
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
						 startServiceSig.dispatch(clientusView);
						 sender.send( {command:"startClientService",args:[_target.key,clientusView.key,_currentOperation.id] } )
                        //setTimeout(completeOperation, _targetCatalogItem.serviceSpeed);
						_isServing = true;
                    }
                    else
                    {
                        if (!_isServing)
						{
							
					
							if (!_isEndOfSequence)
							{
								//trace(" case 1 Гипс снимают клиент уезжает");
								 trace("case 1 НАЧАЛО ОБСЛУЖИВАНИЯ");
								_isEndOfSequence = true;
								 startServiceSig.dispatch(clientusView);
								sender.send( {command:"startClientService",args:[_target.key,clientusView.key,_currentOperation.id] } )
                        
								//setTimeout(nextStep, _freeCellWaitTime);
							}
							else
							{
                                setTimeout(removeClientus, 1000);
							}
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
						startServiceSig.dispatch(clientusView);
                        sender.send( {command:"startClientService",args:[_target.key,clientusView.key,_currentOperation.id] } )
                        _isServing = true;
						// setTimeout(completeOperation, _targetCatalogItem.serviceSpeed);
                    }
                    else
                    {
                        if (!_isServing)
						{
							
					
							if (!_isEndOfSequence)
							{
								trace(" case 0 Гипс снимают клиент уезжает");
								_isEndOfSequence = true;
								setTimeout(nextStep, _freeCellWaitTime);
							}
							else
							{
                                setTimeout(removeClientus, 1000);
							}
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
//        _target.cashMoney += _currentOperation.money; //fixme:Перепупырить это в сигнал и ловить в медиаторе айтема.
        nextStep();
    }
    // ищем банкомат или кассу. 
    private function selectTarget():ItemIsoView
    {
        var target:ItemIsoView;
		//проверяем айдишники операций у клиента. 
        if (clientusView.operations.length)
        {
            //берём первую операцию 
			_currentOperation = clientusView.operations.shift();
			
            //итератор предметов пользователя. 
			var iterator:HashMapValIterator = userItems.iterator() as HashMapValIterator;
            var item:Item;
            var itemIsoView:ItemIsoView;
            var avaibleItems:Array = [];
            iterator.reset();

            //перебираем все предметы пользователя в цикле.
			while (iterator.hasNext())
            {
                //излюражение текущего предмета
				itemIsoView = iterator.next() as ItemIsoView;
                
				//ищем в каталоге предметов спецификацию текущего предмета.
				item = itemCatalog.get(itemIsoView.catalogKey) as Item;
				//если предмет найден
                if (item)
                {
                    //смотрим текущие операции над предметами.
					if (item.operations)
                    {
                        //перебираем все операции которые доступны у текущего предмета.
						for (var i:int = 0; i < item.operations.length; i++)
                        {
                            //если текущая операция есть есть у данного предмета
							if (item.operations[i] == _currentOperation.id)
                            {
                                //то добавляем его в массив
								avaibleItems[avaibleItems.length] = {iso: itemIsoView, catalogItem: item};
                            }
                        }
                    }
                }
            }
			//мы составили список предметов с нужными нам операциями. 
            if (avaibleItems.length > 0)
            {//если есть нужные нам предметы
                var moreFreer:int;
                var minTime:int;
                //ищем наименьшее время обслуживания 
				minTime = ItemIsoView(avaibleItems[length - 1].iso).clientStack.length * Item(avaibleItems[length - 1].catalogItem).serviceSpeed;
                for (var i:int = avaibleItems.length - 2; i >= 0; i--)
                {
                    if ((ItemIsoView(avaibleItems[i].iso).clientStack.length * Item(avaibleItems[i].catalogItem).serviceSpeed) < minTime)
                    {
                        minTime = ItemIsoView(avaibleItems[i].iso).clientStack.length * Item(avaibleItems[i].catalogItem).serviceSpeed;
                        moreFreer = i;
                    }
                }
				//выбрали 
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
		
		var scene:FloorItemScene = floorList.get(1) as FloorItemScene;
        scene.removeChild(clientusView);
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
