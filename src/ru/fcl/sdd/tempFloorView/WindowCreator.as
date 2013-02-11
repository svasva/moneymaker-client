package ru.fcl.sdd.tempFloorView 
{
	import as3isolib.data.INode;
	import as3isolib.display.IsoSprite;
	import flash.display.MovieClip;

	/**
	 * ...
	 * @author Timonin
	 */
	public class WindowCreator 
	{
		
		private const WINDOW1:int = 1;
		private const WINDOW2:int = 2;
		private const WINDOW1_BT:int = 3;
		private const WINDOW2_BT:int = 4;
		public function WindowCreator() 
		{
			
		}
		
		public function createWindow(id:int):INode
		{
			var target:MovieClip;
			var node:IsoSprite = new IsoSprite();
			switch(id)
			
			{
				case WINDOW1:
				target = new window1_mc();	
				break;
				case WINDOW2:
				target = new window2_mc();		
				break;	
				case WINDOW1_BT:
				target = new window1_bt_mc();	
				break;
				case WINDOW2_BT:
				target = new window2_bt_mc();		
				break;			
			
			}
			node.sprites = [target];
			target.mouseEnabled = false;
			return node;
		}
		
	}

}