package ru.fcl.sdd.tempFloorView.Nodes 
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
    import ru.fcl.sdd.tempFloorView.GroundCreator;
    import ru.fcl.sdd.tempFloorView.ObjectCreator;
    import ru.fcl.sdd.tempFloorView.WallCreator;
	import ru.fcl.sdd.tempFloorView.WindowCreator;


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
			addChild(window_layer);
			
			addChild(object_layer);
			addChild(wall_layer);
			addChild(corridor_object_alyer);
		//	addEventListener(Event.ADDED_TO_STAGE, init);
		//	addEventListener(Event.RENDER, _render);
			addEventListener(Event.REMOVED_FROM_STAGE, clear);
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
		private function onPickup(e:ProxyEvent):void
		{
           
			trace("11111111111111111");
		/*	dragObject = e.target as IsoDisplayObject;
		  e.stopPropagation();
           dragPt = view.localToIso(new Pt(mainContainer.stage.mouseX, mainContainer.stage.mouseY));
           dragPt.x -= dragObject.x;
           dragPt.y -= dragObject.y;
		   trace(mainContainer.stage.getObjectsUnderPoint(new Point(mainContainer.stage.mouseX,mainContainer.stage.mouseY)));*/
		   

         //  dragObject.removeEventListener(MouseEvent.MOUSE_DOWN, onPickup);

        //   dragObject.addEventListener(MouseEvent.MOUSE_UP, onDrop, false, 0, true);
          /* addEventListener(MouseEvent.MOUSE_UP, onDrop, false, 0, true);
           addEventListener(MouseEvent.MOUSE_MOVE, onMoveObject, false, 0, true);*/
		}
		
		private function onDrop(e:Event):void
		{
           dragObject.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
           removeEventListener(MouseEvent.MOUSE_UP, onDrop);
           removeEventListener(MouseEvent.MOUSE_MOVE, onMoveObject);

           dragObject.addEventListener(MouseEvent.MOUSE_DOWN, onPickup);
		}
		private function onMoveObject(e:ProxyEvent):void
		{
           var pt:Pt = view.localToIso(new Pt(mainContainer.stage.mouseX,mainContainer.stage.mouseY));

           dragObject.moveTo(pt.x - dragPt.x, pt.y - dragPt.y, dragObject.z);
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