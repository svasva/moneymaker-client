/**
 * User: Jessie
 * Date: 26.11.12
 * Time: 12:57
 */
package ru.fcl.sdd.item.iso
{

import eDpLib.events.ProxyEvent;
import flash.events.MouseEvent;
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.item.ItemStatus;
import ru.fcl.sdd.states.GameStates;
import ru.fcl.sdd.states.IStateHolder;
import ru.fcl.sdd.tempFloorView.MapLayer;

import ru.fcl.sdd.item.iso.ItemIsoView;

import ru.fcl.sdd.location.floors.Floor1Scene;

public class PlaceItemCommand extends SignalCommand
{
    [Inject]
    public var iso:ItemIsoView;
    [Inject]
    public var floor:Floor1Scene;
    [Inject] 
    public var map:MapLayer;
    
     [Inject]
    public var clickedSignal:ItemClickedSignal;
    
    [Inject]
    public var gameState:IStateHolder;

    override public function execute():void
    {
     
        iso.onClickFun = iso_mouseevent;
        
         floor.addChild(iso.giveMoneyIso);
            iso.giveMoneyIso.render();
            iso.giveMoneyIso.x = iso.x;
            iso.giveMoneyIso.y = iso.y;
            iso.giveMoneyIso.z = iso.height;
          
          
            iso.takeMoneyIso.x = iso.x;
            iso.takeMoneyIso.y = iso.y;
            iso.takeMoneyIso.z = iso.height;
            
            iso.giveMoney.visible = false;
            iso.takeMoney.visible = false;
            if (iso.status == ItemStatus.EMPTY)
                iso.giveMoney.visible = true;
           else if (iso.status == ItemStatus.FULL)
                 iso.takeMoney.visible = true;
                 
        floor.addChild(iso.takeMoneyIso);
        floor.addChild(iso.giveMoneyIso);
        floor.addChild(iso);
        
        if(gameState.currentState == GameStates.VIEW)
        iso.addEventListener(MouseEvent.CLICK, iso_mouseevent);      
        
        iso.render();
        iso.giveMoneyIso.render();
        iso.takeMoneyIso.render();
        floor.render();
    }
    
    private function iso_mouseevent(e:ProxyEvent):void 
    {
      
        clickedSignal.dispatch(e.target as ItemIsoView);
    }
}
}
