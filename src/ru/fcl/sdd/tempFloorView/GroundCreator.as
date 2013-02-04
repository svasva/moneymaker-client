package ru.fcl.sdd.tempFloorView 
{
	import as3isolib.data.INode;
	import as3isolib.display.IsoSprite;
	import flash.display.MovieClip;

	/**
	 * ...
	 * @author Timonin
	 */
	public class GroundCreator 
	{
		
		private const ROOM:int = 1;
		private const HALL:int = 2;
		private const OPERATION_ROOM:int = 3;
		private const OPERATION_HALL:int = 4;
		private const DIRECT_FLOOR:int = 5;
		private const WOOD1_FLOOR:int = 6;
		private const WOOD2_FLOOR:int = 7;
		private const WOOD3_FLOOR:int = 8;
		private const FLOOR_BANK:int = 9;
		private const FLOOR_BLUE:int = 10;
		public function GroundCreator() 
		{
			
		}
		
		public function createGround(id:int):INode
		{
			var target:MovieClip;
			var node:IsoSprite = new IsoSprite();
			switch(id)
			
			{
				case ROOM:
				target = new ground_mc();	
				break;
				case HALL:
				target = new bg_holl_mc();		
				break;			
				case OPERATION_ROOM:
				target = new operation_ground_mc();		
				break;	
				case OPERATION_HALL:
				target = new operation_hall_ground_mc();		
				break;	
				case DIRECT_FLOOR:
				target = new direct_floor_mc();		
				break;	
				case WOOD1_FLOOR:
				target = new wood01_floo_mc();		
				break;	
				case WOOD2_FLOOR:
				target = new wood02_floor_mc();		
				break;	
				case WOOD3_FLOOR:
				target = new wood03_floor_mc();		
				break;
				case FLOOR_BANK:
				target = new floor_bk_mc();		
				break;	
				case FLOOR_BLUE:
				target = new floor_blue_mc();		
				break;	
				
			}
			node.sprites = [target];
			target.mouseEnabled = false;
			return node;
		}
		
	}

}