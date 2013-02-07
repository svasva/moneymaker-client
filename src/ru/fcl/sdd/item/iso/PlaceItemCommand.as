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

    override public function execute():void
    {
     
        floor.addChild(iso);
        iso.addEventListener(MouseEvent.CLICK, iso_mouseevent);
      
        iso.render();
    
        floor.render();
    }
    
    private function iso_mouseevent(e:ProxyEvent):void 
    {
      
        clickedSignal.dispatch(e.target as ItemIsoView);
    }
}
}
