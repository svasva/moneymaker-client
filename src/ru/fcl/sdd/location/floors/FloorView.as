package ru.fcl.sdd.location.floors 
{
	import as3isolib.core.IsoDisplayObject;
	import as3isolib.data.INode;
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoScene;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import ru.fcl.sdd.location.floors.Nodes.IsoFloor;
    

    
	
	public class FloorView extends IsoDisplayObject
	{	
		public var scene:IsoScene;
		public var view:IsoView;		
			
        public var isoFlor:IsoFloor;
		private const H_FASAD:int = 310;
		private var fasads:Array = [];
		public function FloorView() 
		{
		/*	this.scene = _scene;
			this.view = view;		*/
		//	addEventListener(Event.ADDED_TO_STAGE, init);
			//addEventListener(Event.REMOVED_FROM_STAGE, clear);			
			
		
		}
		
		private function clear():void
		{
			if (isoFlor)
			{
				removeChild(isoFlor);
			}
			
		
		}
	
		public function init(flornumber:int):void
		{
			
			var item:INode = new IsoFloor(view);
                isoFlor = item as IsoFloor;				
			var h:int = 0;
			if (flornumber > 1)
			{
				for ( var  i:int = 1; i < flornumber; i++)
				{
				var node:INode = createFasad();
				(node as IsoSprite).z = h;
				h += H_FASAD;
				addChild(node);
				fasads.push(node);
				}
				
				isoFlor.z = (flornumber-1)*H_FASAD;
				isoFlor.x = -10;
				isoFlor.y = -5;			
			}			
			addChild(isoFlor);
			
		}
		private function createFasad():INode
		{
			var fasad:IsoSprite = new IsoSprite();
			var sp:MovieClip = new fasad_mc();
			fasad.sprites = [sp];
			fasad.x = 1300///2 * 12 * CELL+2 *CELL; 
			fasad.y =2200//4 * 12 * CELL - 4 * CELL;			
			return fasad;
			
		}
		
		
		
		
			
		
	}

}