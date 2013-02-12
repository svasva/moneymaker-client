/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 17:59
 */
package ru.fcl.sdd.location.floors
{
import de.polygonal.ds.HashMapValIterator;
import eDpLib.events.ProxyEvent;
import flash.events.MouseEvent;
import ru.fcl.sdd.item.iso.ItemClickedHndCommand;
import ru.fcl.sdd.item.iso.ItemClickedSignal;
import ru.fcl.sdd.item.SellItemCommand;
import ru.fcl.sdd.item.SellItemSignal;
import ru.fcl.sdd.location.room.RoomModel;
import ru.fcl.sdd.tempFloorView.MapLayer;

import org.osflash.signals.ISignal;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.item.iso.ItemIsoView;
import ru.fcl.sdd.item.iso.PlaceItemCommand;
import ru.fcl.sdd.item.ActiveUserItemList;
import ru.fcl.sdd.pathfind.PlacePathGridItemCommand;

public class CreateFloorsCommand extends SignalCommand
{
    [Inject]
    public var userItems:ActiveUserItemList;
    
    [Inject] 
    public var roomMdl:RoomModel;

    override public function execute():void
    {
        injector.mapSingleton(ItemClickedSignal);
        signalCommandMap.mapSignalClass(ItemClickedSignal,ItemClickedHndCommand);
        signalCommandMap.mapSignalClass(SellItemSignal,SellItemCommand);
        
        injector.mapSingleton(Floor1Scene);
        injector.mapSingleton(FloorItemScene);
        injector.mapSingleton(MapLayer);

        var mainIsoScene:Floor1Scene = injector.getInstance(Floor1Scene);
      //  var itemFoor:FloorItemScene = injector.getInstance.(FloorItemScene);
        
        commandMap.execute(ChangeFloorCommand,1);
        var iterator:HashMapValIterator = userItems.iterator() as HashMapValIterator;
        iterator.reset();
        
      //  mainIsoScene.addEventListener(MouseEvent.CLICK, mainIsoScene_click);
        
         commandMap.execute(PlaceDefaultRoomCommand,1);

        while(iterator.hasNext())
        {
            var item:ItemIsoView = iterator.next() as ItemIsoView;
            commandMap.execute(PlaceItemCommand,item);
            commandMap.execute(PlacePathGridItemCommand,item);
        }

    }
    
    private function mainIsoScene_click(e:ProxyEvent):void 
    {
        trace("mainIsoScene");
        roomMdl.selectedItemId = null;
        roomMdl.selectedItem = null;
    }
}
}
