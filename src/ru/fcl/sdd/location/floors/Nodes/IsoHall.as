package ru.fcl.sdd.location.floors.Nodes 
{
	import as3isolib.display.IsoView;
	/**
	 * ...
	 * @author Timonin
	 */
	public class IsoHall extends IsoRoom 
	{
		
		public function IsoHall(view:IsoView) 
		{
			super(view);		
			grid.setGridSize(4, CELL, 1);
		}		
	
		
	}		
		
	
		
	

}