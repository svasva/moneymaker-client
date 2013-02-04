package ru.fcl.sdd.tempFloorView 
{
	import as3isolib.core.IsoDisplayObject;
	import as3isolib.data.INode;
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoScene;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.ByteArray;
    import ru.fcl.sdd.tempFloorView.Nodes.IsoFloor;

    
	
	public class MapLayer extends IsoDisplayObject
	{	
		public var scene:IsoScene;
		public var view:IsoView;		
			
        public var isoFlor:IsoFloor;
	
		public function MapLayer() 
		{
		/*	this.scene = _scene;
			this.view = view;		*/
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, clear);			
			
		
		}
		private function clear(e:Event):void
		{
			
		
		}
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		
		}
		
		
		public function loadMap(map:Class):void
		{
			var bytes:ByteArray = new map;
			var xml:XML = new XML(bytes.readUTFBytes(bytes.length));
			var bg_design:MovieClip = new floor_back_mc();
			var Bg:IsoSprite = new IsoSprite();
			Bg.sprites = [bg_design];
			addChild(Bg);
			
			for each (var floor:XML in xml..floors.item)
			{
				var item:INode = new IsoFloor(view);
                  isoFlor = item as IsoFloor;
				addChild(item);
				(item as IsoFloor).loadHall(floor.halls);
				(item as IsoFloor).loadRooms(floor.rooms);
				
			}
		
			
		}
	
	}

}