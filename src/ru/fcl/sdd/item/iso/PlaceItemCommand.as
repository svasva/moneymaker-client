/**
 * User: Jessie
 * Date: 26.11.12
 * Time: 12:57
 */
package ru.fcl.sdd.item.iso
{

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

    override public function execute():void
    {
     
        floor.addChild(iso);
       // map.isoFlor.addChild(iso);
       // map.addChild();
       
      
        iso.render();
    
        floor.render();
    }
}
}
