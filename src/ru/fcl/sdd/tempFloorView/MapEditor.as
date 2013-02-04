package ru.fcl.sdd.tempFloorView 
{

	import as3isolib.display.IsoSprite;
	import com.bit101.components.PushButton;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.geom.Pt;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.display.primitive.IsoBox;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import ru.controllers.Uni_controller;
	import ru.controllers.Uni_event;
	
    import ru.Nodes.IsoFloor;

	/**
	/**
	 * ...
	 * @author 
	 */
	public class MapEditor extends Sprite
	{
		private var viewPort:IsoView;
		private var scene:IsoScene;
		
		private var grid:IsoGrid;
		[Embed(source = "../../bin/assert/BetonMap.xml",  mimeType = "application/octet-stream")] private const HMap1:Class;
		[Embed(source = "../../bin/assert/Operation_hall.xml", mimeType = "application/octet-stream")] private var  OPERATION_HALL:Class;
		[Embed(source = "../../bin/assert/Director.xml" , mimeType = "application/octet-stream")] private var DIRECTOR:Class;
		[Embed(source = "../../bin/assert/Room5.xml" , mimeType = "application/octet-stream")] private var ROOM5:Class;
		[Embed(source = "../../bin/assert/Room6.xml" , mimeType = "application/octet-stream")] private var ROOM6:Class;
		[Embed(source = "../../bin/assert/Room7.xml" , mimeType = "application/octet-stream")] private var ROOM7:Class;
		[Embed(source = "../../bin/assert/Room8.xml" , mimeType = "application/octet-stream")] private var ROOM8:Class;
		private const COL:int = 10;
		private const ROW:int = 10;
		private const CELL:int = 50;
		private  var layer:MapLayer;
	
		public function MapEditor() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, clear);
		}
		
		private function clear(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onRender);
			//removeChild(layer);
			scene.removeAllChildren();
			removeChild(viewPort);
			
		}
		
		private var panPt:Pt;
		private function onStartPan(e:MouseEvent):void
		{
			panPt = new Pt(stage.mouseX, stage.mouseY);
			viewPort.removeEventListener(MouseEvent.MOUSE_DOWN, onStartPan);
			viewPort.addEventListener(MouseEvent.MOUSE_MOVE, onPan, false, 0, true);
			viewPort.addEventListener(MouseEvent.MOUSE_UP, onStopPan, false, 0, true);
			
		}
		private function onPan(e:MouseEvent):void
		{
				viewPort.panBy(panPt.x - stage.mouseX, panPt.y - stage.mouseY);

			panPt.x = stage.mouseX;
			panPt.y = stage.mouseY;
		}
		private function onStopPan(e:MouseEvent):void
		{
			viewPort.removeEventListener(MouseEvent.MOUSE_MOVE, onPan);
			viewPort.removeEventListener(MouseEvent.MOUSE_UP, onStopPan);

			viewPort.addEventListener(MouseEvent.MOUSE_DOWN, onStartPan, false, 0, true);
		}
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		//	addChild(View);
			viewPort = new IsoView();
			viewPort.setSize(1024, 768);
			viewPort.centerOnPt(new Pt(5 * CELL, 5 * CELL, 0), true);
		
						
			
			addChild(viewPort);
			scene = new IsoScene();
			viewPort.addScene(scene);
			grid = new IsoGrid();
			grid.setGridSize(COL, ROW, 1);
			grid.cellSize = CELL;
		//	scene.addChild(grid);
			addEventListener(Event.ENTER_FRAME, onRender, false, 0, true);
			addEventListener(MouseEvent.MOUSE_WHEEL, onZoom);
			viewPort.addEventListener(MouseEvent.MOUSE_DOWN, onStartPan, false, 0, true);
		
			
			trace("MapLayer");
		//	addChild(Bg);
			layer = new MapLayer(scene,viewPort);
		  
			scene.addChild(layer);
			buildMap(HMap1);
			
			var btn:PushButton = new PushButton(this, 900, 200, "Operation Room", onPlaceRoom);
			btn.name = "oper_hall";
			addChild(btn);
			var btn2:PushButton = new PushButton(this, 900, 250, "Director", onPlaceRoom);
			btn2.name = "director";
			addChild(btn2);
			
			var btn3:PushButton = new PushButton(this, 900, 300, "Room5", onPlaceRoom);
			btn3.name = "room5";
			addChild(btn3);
			var btn4:PushButton = new PushButton(this, 900, 350, "Room6", onPlaceRoom);
			btn4.name = "room6";
			addChild(btn4);
			var btn5:PushButton = new PushButton(this, 900, 400, "Room7", onPlaceRoom);
			btn5.name = "room7";
			addChild(btn5);
			var btn6:PushButton = new PushButton(this, 900, 450, "Room8", onPlaceRoom);
			btn6.name = "room8";
			addChild(btn6);
		}
		
		private function onPlaceRoom(e:MouseEvent):void
		{
			var event:Uni_event = new Uni_event(IsoFloor.PLACE_ROOM);
			
			var bytes:ByteArray;
			
		//	var xml:XML = new XML(bytes.readUTFBytes(bytes.length));
			
			switch(e.target.name)
			{
				case "oper_hall":
					bytes = new OPERATION_HALL();				
				break;
				case "director":
					bytes = new DIRECTOR();				
				break;
				case "room5":
					bytes = new ROOM5();				
				break;
				case "room6":
					bytes = new ROOM6();				
				break;
				case "room7":
					bytes = new ROOM7();				
				break;
				case "room8":
					bytes = new ROOM8();				
				break;
			}
				
			var xml:XML = new XML(bytes.readUTFBytes(bytes.length));
			event.arg = xml.floors.rooms;
			Uni_controller.getInstance().dispatchEvent(event);
		}
		
		private var zoomValue:Number = 1;
		private function onZoom(e:MouseEvent):void
		{
			if(e.delta > 0)
			zoomValue +=  0.10;

			if(e.delta < 0)
			zoomValue -=  0.10;

			zoomValue = Math.min(Math.max(zoomValue, 0.2), 1);
			viewPort.currentZoom = zoomValue;
		}
		
		private function buildMap(map:Class):void
		{
			layer.loadMap(map);
			
		}
		private function onRender(e:Event):void
		{
			scene.render(true);
			//scene.children
			
		}
		
		
		
	}

}