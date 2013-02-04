package ru.fcl.sdd.tempFloorView 
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
		
		const CHAIR1:int = 1;
		const CHAIR2:int = 2;
		const BANK:int = 3;
		const DIVAN:int = 4;
		const DIRECTOR:int = 5;
		const BANKOMATS:int = 6;
		const SEQURITY:int = 7;
		const MARKETING:int = 8;
		
		
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
							
				
			}
			node.sprites = [target];
			
			return node;
		}
		
	}

}