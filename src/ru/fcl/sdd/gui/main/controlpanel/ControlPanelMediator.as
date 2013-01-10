/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.controlpanel
{
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;

import org.osflash.signals.ISignal;

import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.scenes.MainIsoView;
import ru.fcl.sdd.services.main.ISender;

import ru.fcl.sdd.states.ChangeStateSignal;
import ru.fcl.sdd.states.GameStates;

public class ControlPanelMediator extends Mediator
{
    [Inject]
    public var view:ControlPanelView;
    [Inject]
    public var changeState:ChangeStateSignal;

    [Inject(name="zoom_in")]
    public var zoomIn:ISignal;
    [Inject(name="zoom_out")]
    public var zoomOut:ISignal;
    [Inject]
    public var mainIsoView:MainIsoView;
    [Inject]
    public var sender:ISender;

    [Inject(name="change_floor")]
    public var floorChange:ISignal;

    override public function onRegister():void
    {
        view.shopBtn.addEventListener(MouseEvent.CLICK, shopBtn_clickHandler);
        view.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        view.floorDownBtn.addEventListener(MouseEvent.CLICK, floorDownBtn_clickHandler);
        view.floorUpBtn.addEventListener(MouseEvent.CLICK, floorUpBtn_clickHandler);
        view.zoomInBtn.addEventListener(MouseEvent.CLICK, zoomIn_clickHandler);
        view.zoomOutBtn.addEventListener(MouseEvent.CLICK, zoomOut_clickHandler);
		view.configBtn.addEventListener(MouseEvent.CLICK, config_clickHandler);
		view.fullscreenBtn.addEventListener(MouseEvent.CLICK, fullscreen_clickHandler);
		view.statisticBtn.addEventListener(MouseEvent.CLICK, statistic_clickHandler);
		view.mapBtn.addEventListener(MouseEvent.CLICK, map_clickHandler);
		view.missionBtn.addEventListener(MouseEvent.CLICK, mission_clickHandler);
		view.postBtn.addEventListener(MouseEvent.CLICK, post_clickHandler);
		view.rateBtn.addEventListener(MouseEvent.CLICK, rate_clickHandler);
    }

    override public function onRemove():void
    {
        view.shopBtn.removeEventListener(MouseEvent.CLICK, shopBtn_clickHandler);
        view.floorDownBtn.removeEventListener(MouseEvent.CLICK, floorDownBtn_clickHandler);
        view.floorUpBtn.removeEventListener(MouseEvent.CLICK, floorUpBtn_clickHandler);
        view.zoomInBtn.removeEventListener(MouseEvent.CLICK, zoomIn_clickHandler);
        view.zoomOutBtn.removeEventListener(MouseEvent.CLICK, zoomOut_clickHandler);
		view.configBtn.removeEventListener(MouseEvent.CLICK, config_clickHandler);
		view.fullscreenBtn.removeEventListener(MouseEvent.CLICK, fullscreen_clickHandler);
		view.statisticBtn.removeEventListener(MouseEvent.CLICK, statistic_clickHandler);
		view.mapBtn.removeEventListener(MouseEvent.CLICK, map_clickHandler);
		view.missionBtn.removeEventListener(MouseEvent.CLICK, mission_clickHandler);
		view.postBtn.removeEventListener(MouseEvent.CLICK, post_clickHandler);
		view.rateBtn.removeEventListener(MouseEvent.CLICK, rate_clickHandler);
    }

    private function shopBtn_clickHandler(event:MouseEvent):void
    {
        changeState.dispatch(GameStates.IN_SHOP);
    }


    private function floorUpBtn_clickHandler(event:MouseEvent):void
    {
        if (mainIsoView.currentFloorNumber < 4)
        {
            floorChange.dispatch(mainIsoView.currentFloorNumber + 1);
        }
    }

    private function floorDownBtn_clickHandler(event:MouseEvent):void
    {
        if (mainIsoView.currentFloorNumber > 0)
        {
            floorChange.dispatch(mainIsoView.currentFloorNumber - 1);
        }
    }

    private function zoomIn_clickHandler(event:MouseEvent):void
    {
        zoomIn.dispatch();
    }

    private function zoomOut_clickHandler(event:MouseEvent):void
    {
        zoomOut.dispatch();
    }

    private function keyDownHandler(event:KeyboardEvent):void
    {
        if (event.keyCode == Keyboard.ENTER)
        {
            sender.send({command: "resetGame"});
        }
    }
	
	private function config_clickHandler(event:MouseEvent):void
	{
	}
	
	private function statistic_clickHandler(event:MouseEvent):void
	{
	}
	
	private function map_clickHandler(event:MouseEvent):void
	{
	}
	
	private function mission_clickHandler(event:MouseEvent):void
	{
	}
	
	private function post_clickHandler(event:MouseEvent):void
	{
	}
	
	private function rate_clickHandler(event:MouseEvent):void
	{
	}
	
	private function fullscreen_clickHandler(event:MouseEvent):void
	{
	}
}
}
