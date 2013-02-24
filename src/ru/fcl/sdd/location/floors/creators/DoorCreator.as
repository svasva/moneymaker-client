package ru.fcl.sdd.location.floors.creators 
{
	import as3isolib.data.INode;
	import as3isolib.display.IsoSprite;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Timonin
	 */
	public class DoorCreator 
	{
		
		private const DOOR_MAIN:int = 1;
		private const DOOR:int = 2;
		private const DOOR2:int = 3;
		
		public function DoorCreator() 
		{
			
		}
		
		public function createDoor(id:int):INode
		{
			var target:MovieClip;
			var node:IsoSprite = new IsoSprite();
			switch(id)
			
			{
				case DOOR_MAIN:
				target = new main_door_mc();	
				break;
				case DOOR:
				target = new door_mc();	
				break;
				case DOOR2:
				target = new door2_mc();	
				break;
				
				
			}
			target.mouseEnabled = false;
			node.sprites = [target];
			
			return node;
		}
		
	}

}