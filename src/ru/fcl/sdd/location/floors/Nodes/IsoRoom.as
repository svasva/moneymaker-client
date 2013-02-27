package ru.fcl.sdd.location.floors.Nodes 
{
	import as3isolib.core.IsoDisplayObject;
	import as3isolib.data.INode;
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.geom.Pt;
	import eDpLib.events.ProxyEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ru.fcl.sdd.location.floors.creators.DoorCreator;
	import ru.fcl.sdd.location.floors.creators.GroundCreator;
	import ru.fcl.sdd.location.floors.creators.ObjectCreator;
	import ru.fcl.sdd.location.floors.creators.WallCreator;
	import ru.fcl.sdd.location.floors.creators.WindowCreator;

   


	/**
	 * ...
	 * @author Timonin
	 */
	public class IsoRoom extends IsoDisplayObject 
	{
		
		private var vobjects:Vector.<INode>;
		private var back_layer:IsoSprite = new IsoSprite();
		private var wall_layer:IsoSprite =  new IsoSprite();
		private var object_layer:IsoSprite =  new IsoSprite();
		private var ground_layer:IsoSprite =  new IsoSprite();
		private var corridor_object_alyer:IsoSprite = new IsoSprite();
		private var window_layer:IsoSprite = new IsoSprite();
		private var door_layer:IsoSprite = new IsoSprite();
		private var cor_door_layer:IsoSprite = new IsoSprite();
		protected var grid:IsoGrid = new IsoGrid();
		
		protected const CELL:int = 50;
		protected var view:IsoView;
		protected var room_id:int;
        
        
		public function IsoRoom(view:IsoView):void 
		{
			super();
            vobjects = new Vector.<INode>
			this.view = view;
			
			grid.setGridSize(CELL, CELL, 1);
			grid.cellSize = CELL;
			
			
			//addChild(grid);
			addChild(ground_layer);
			addChild(back_layer);
			addChild(door_layer);
			addChild(window_layer);
			
			addChild(object_layer);
			addChild(wall_layer);
			addChild(cor_door_layer);
			addChild(corridor_object_alyer);
		//	addEventListener(Event.ADDED_TO_STAGE, init);
		//	addEventListener(Event.RENDER, _render);
			addEventListener(Event.REMOVED_FROM_STAGE, clear);
		}
		
		public function get objects_layer():IsoSprite
		{
			return object_layer;
		}
		
		private function clear(e:Event):void
		{
			removeChild(ground_layer);
			removeChild(wall_layer);
			removeChild(object_layer);
			removeChild(back_layer);
			removeChild(window_layer);
			
		}
		
		private var dragObject:IsoDisplayObject;
		private var dragPt:Pt;
		
		public function set Room_id(id:int):void
		{
			 room_id = id;
		}
		public function get Room_id():int
		{
			return room_id;
		}
	
		public function loadGround(ground:XMLList):void
		{
			for each (var item:XML in ground.item)
			{
				//var item:Room = new Room();
				var factory:GroundCreator = new GroundCreator();
			
				var node:INode = factory.createGround(item.@sid);
				//addChild(node);
				(node as IsoSprite).x = item.@x * CELL;
				(node as IsoSprite).y = item.@y  * CELL;
				ground_layer.addChild(node);
				(node as IsoSprite).render();				
			}
		}
		
		public function loadWindow(windows:XMLList):void
		{
			
			for each (var item:XML in windows.item)
			{
				//var item:Room = new Room();
				var factory:WindowCreator = new WindowCreator();
				trace (item.@sid);
				var node:INode = factory.createWindow(item.@sid);
				//addChild(node);
				(node as IsoSprite).x = item.@x * CELL;
				(node as IsoSprite).y = item.@y  * CELL;
				window_layer.addChild(node);
				(node as IsoSprite).render();
							
			}
			
		}
		public function loadDoor(doors:XMLList):void
		{
			
			for each (var item:XML in doors.item)
			{
				//var item:Room = new Room();
				var factory:DoorCreator = new DoorCreator();
				trace (item.@sid);
				var node:INode = factory.createDoor(item.@sid);
				//addChild(node);
				(node as IsoSprite).x = item.@x * CELL;
				(node as IsoSprite).y = item.@y  * CELL;
				if (item.@corridor && item.@corridor == "true")
					cor_door_layer.addChild(node);
				else				
					door_layer.addChild(node);
				(node as IsoSprite).render();
							
			}
			
		}
		
		public function loadWall(walls:XMLList):void
		{
			
			for each (var item:XML in walls.item)
			{
				//var item:Room = new Room();
				var factory:WallCreator = new WallCreator();
				trace (item.@sid);
				var node:INode = factory.createWall(item.@sid);
				//addChild(node);
				(node as IsoSprite).x = item.@x * CELL;
				(node as IsoSprite).y = item.@y  * CELL;
				if (item.@back && item.@back == "true")
					back_layer.addChild(node);
				else				
					wall_layer.addChild(node);
				(node as IsoSprite).render();				
			}
			
		}
				
		public function loadObject(objects:XMLList):void
		{
			
			for each (var item:XML in objects.item)
			{
				//var item:Room = new Room();
				var factory:ObjectCreator = new ObjectCreator();
				trace (item.@sid);
				var node:INode = factory.createObject(item.@sid);
				//addChild(node);
				(node as IsoSprite).x = item.@x * CELL;
				(node as IsoSprite).y = item.@y  * CELL;
			//	(node as IsoSprite).z = 50;
				(node as IsoSprite).render();
				if (item.@corridor && item.@corridor == "true")
					corridor_object_alyer.addChild(node);
				else				
					object_layer.addChild(node);
				
				vobjects.push(node);				
			//	(node as IsoSprite).proxy.addEventListener(MouseEvent.MOUSE_DOWN, onPickup);
			}
			
		}
		
	}		
		
	
		
	

}