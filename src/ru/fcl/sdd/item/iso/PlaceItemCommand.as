/**
 * User: Jessie
 * Date: 26.11.12
 * Time: 12:57
 */
package ru.fcl.sdd.item.iso
{

import as3isolib.display.scene.IsoScene;
import eDpLib.events.ProxyEvent;
import flash.events.MouseEvent;
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.item.ItemCatalog;
import ru.fcl.sdd.item.ItemStatus;
import ru.fcl.sdd.location.floors.FloorItemScene;
import ru.fcl.sdd.location.floors.FloorsList;
import ru.fcl.sdd.location.floors.Nodes.IsoRoom;
import ru.fcl.sdd.location.room.Room;
import ru.fcl.sdd.location.room.UserRoomList;
import ru.fcl.sdd.location.room.XmlRoomModel;
import ru.fcl.sdd.scenes.MainIsoView;
import ru.fcl.sdd.states.GameStates;
import ru.fcl.sdd.states.IStateHolder;


import ru.fcl.sdd.item.iso.ItemIsoView;



public class PlaceItemCommand extends SignalCommand
{
    [Inject]
    public var iso:ItemIsoView;
   /* [Inject]
    public var floor:Floor1Scene;*/
    [Inject]
    public var mainIsoView:MainIsoView
    [Inject]
    public var userRoomList:UserRoomList;
   [Inject]
    public var floorList:FloorsList;
    
     [Inject]
    public var clickedSignal:ItemClickedSignal;
    
    [Inject]
    public var gameState:IStateHolder;
	
	 [Inject]
        public var itemCatalog:ItemCatalog;
	  [Inject]
     public var xmlRoomModel:XmlRoomModel;

    override public function execute():void
    {
     
        iso.onClickFun = iso_mouseevent;
        
          mainIsoView.currentFloor.addChild(iso.giveMoneyIso);
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
		var floor:int;
		if (iso.catalogKey)
		{
			var item:Item = itemCatalog.get(iso.catalogKey) as Item;
			var room:Room =  userRoomList.get(item.room_id) as Room;
      
		 floor = xmlRoomModel.floorByOrder(room.order);
		}
		else
			floor = mainIsoView.currentFloorNumber;
		var floorScene:FloorItemScene =  floorList.get(floor) as FloorItemScene;
	   
	//   var isoroom:IsoRoom = floorScene.Floor.isoFlor.findByCoord(iso.x / IsoConfig.CELL_SIZE, iso.y / IsoConfig.CELL_SIZE) as IsoRoom;
		//iso.x-= isoroom.x;
	//	iso.y -= isoroom.y;
	   
	 //  isoroom.objects_layer.addChild (iso.takeMoneyIso);
	 
	 //   isoroom.objects_layer.addChild (iso.giveMoneyIso);
	
		// isoroom.objects_layer.addChild (iso);
		floorScene.addChild(iso.takeMoneyIso);
		floorScene.addChild(iso.giveMoneyIso);
		floorScene.addChild(iso);
        
        if(gameState.currentState == GameStates.VIEW)
        iso.addEventListener(MouseEvent.CLICK, iso_mouseevent);      
        
        iso.render();
        iso.giveMoneyIso.render();
        iso.takeMoneyIso.render();
       floorScene.render();
    }
    
    private function iso_mouseevent(e:ProxyEvent):void 
    {
      
        clickedSignal.dispatch(e.target as ItemIsoView);
    }
}
}
