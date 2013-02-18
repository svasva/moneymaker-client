package ru.fcl.sdd.location.floors.creators 
{
	import as3isolib.data.INode;
	import as3isolib.display.IsoSprite;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Timonin
	 */
	public class ObjectCreator 
	{
		
		private const CHAIR1:int = 1;
		private const CHAIR2:int = 2;
		private const BANK:int = 3;
		private const DIVAN:int = 4;
		private const DIRECTOR:int = 5;
		private const BANKOMATS:int = 6;
		private const SEQURITY:int = 7;
		private const MARKETING:int = 8;
		private const FILIALS:int = 9;
		private const SAFE:int = 10;
		private const LIFT:int = 11;
		private const ROOF:int = 12;
		
		public function ObjectCreator() 
		{
			
		}
		
		public function createObject(id:int):INode
		{
			var target:MovieClip;
			var node:IsoSprite = new IsoSprite();
			switch(id)
			
			{
				case CHAIR1:
				target = new chair1_mc();	
				break;
				case CHAIR2:
				target = new chair2_mc();		
				break;
				case BANK:
				target = new bank1_mc();
					
				break;
				
				case DIVAN:
				target = new divan_mc();
					
				break;
				case DIRECTOR:
				target = new director_objs_mc();
				break;
				
				case BANKOMATS:
				
				target = new bankomats_obj_mc();
				break;
				case SEQURITY:
				
				target = new sequyrity_objts_mc();
				break;
				case MARKETING:
				target = new marketing_obj_mc();
				break;
				case FILIALS:
				target = new filials_obj();
				break;
				case SAFE:
				target = new shraniliche_obj_mc();
				break;
				case LIFT:
				target = new lift_mc();
				break;
				case ROOF:
				target = new roof_obj_mc();
				break;	
				
			}
			node.sprites = [target];
			
			return node;
		}
		
	}

}