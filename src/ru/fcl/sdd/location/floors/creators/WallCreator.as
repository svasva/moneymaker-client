package ru.fcl.sdd.location.floors.creators 
{
	import as3isolib.data.INode;
	import as3isolib.display.IsoSprite;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Timonin
	 */
	public class WallCreator 
	{
		
		private const C_PEREGORODKA1:int = 1;
		private const C_PEREGORODKA2:int = 2;
		private const C_PEREGORODKA3:int = 3;
		private const C_WALL_TOP1:int = 4;
		private const C_WALL_TOP2:int = 5;
		private const C_WALL_HOLL:int = 6;
		private const C_WALL_BOTTOM1:int = 7;
		private const OPERATION_WALL1:int = 8;
		private const	BOTTOM2_MC:int = 9;		
		private const WALL_TOP1D:int = 10;
		private const WALL_TOP1C:int = 11;
		private const WALL_TOP1E:int = 12;
		private const WALL_BOTTOM_SINGLE:int = 13;
		private const C_PERGORODKA4:int = 14;
		private const WALL_BOTTOM2A:int = 15;
		private const WALL_BOTTOM1C:int = 16;
		private const WALL_TOP2A:int = 18;
		private const WALL_TOP1B:int = 19;
		private const PEREGORODKA:int = 20;
		private const WALL_TOP_SINGLE:int = 21;
		private const OPERATION_WALL2:int = 22;
		private const OPERATION_WALL3:int = 23;
		private const C_PEREGORODKA5:int = 24;
		private const WALL_TOP1A:int = 26;
		private const BIG_WALL1:int = 25;
		private const BIG_WALL2:int = 27;
		private const WALL_TOP3:int = 28;
		public function WallCreator() 
		{
			
		}
		
		public function createWall(id:int):INode
		{
			var target:MovieClip;
			var node:IsoSprite = new IsoSprite();
			switch(id)
			
			{
				case C_PEREGORODKA1:
				target = new peregorodka_mc();	
				break;
				case C_PEREGORODKA2:
				target = new peregorodka2_mc();		
				break;
				case C_PEREGORODKA3:
				target = new peregorodka3_mc();
					
				break;
				
				case C_WALL_TOP1:
				target = new wall_top_1_mc();
					
				break;
				case C_WALL_TOP2:
				target = new wall_top2_mc();
					
				break;
				case C_WALL_HOLL:
				target = new wall_holl_mc();
					
				break;
				case C_WALL_BOTTOM1:
				target = new wall_bottom1_mc();
					
				break;
				
				case OPERATION_WALL1:
				target = new operation_wall1_mc();
					
				break;
				case BOTTOM2_MC:
				target = new wall_bottom2c_mc();					
				break;
				
				case WALL_TOP1D:
				target = new wall_top1d_mc();					
				break;
				case WALL_TOP1C:
				target = new wall_top1c_mc();					
				break;
				case WALL_TOP1E:
				target = new wall_top1e_mc();					
				break;
				case WALL_BOTTOM_SINGLE:
				target = new wall_bottom_sigle_mc();					
				break;
				case C_PERGORODKA4:
				target = new peregorodka4_mc();					
				break;
				case WALL_BOTTOM2A:
				target = new wall_bottom2a_mc();					
				break;	
				case WALL_BOTTOM1C:
				target = new wall_bottom1b_mc();					
				break;
				case WALL_TOP2A:
				target = new wall_top2a_mc();					
				break;
				case WALL_TOP1B:
				target = new wall_top1b_mc();					
				break;
				case PEREGORODKA:
				target = new peregorodka1_mc();					
				break;
				case WALL_TOP_SINGLE:
				target = new wall_top_single_mc();					
				break;
				case OPERATION_WALL2:
				target = new operation_wall2_mc();					
				break;
				case OPERATION_WALL3:
				target = new operation_wall3_mc();					
				break;
				case C_PEREGORODKA5:
				target = new cperegorodka5_mc();					
				break;
			
				case WALL_TOP1A:
				target = new wall_top1a_mc();					
				break;
				case BIG_WALL1:
				target = new big_wall_mc();					
				break;
				case BIG_WALL2:
				target = new big_wall2_mc();					
				break;
				case WALL_TOP3:
				target = new walltop3_mc();					
				break;
				
			}
			target.mouseEnabled = false;
			node.sprites = [target];
			
			return node;
		}
		
	}

}