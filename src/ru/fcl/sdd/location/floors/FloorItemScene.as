package ru.fcl.sdd.location.floors 
{
	import as3isolib.display.scene.IsoScene;
	import ru.fcl.sdd.location.floors.FloorView;
	
	/**
     * ...
     * @author atuzov
     */
	
    public class FloorItemScene extends IsoScene 
    {
		private var floorView:FloorView; 
		
		public function FloorItemScene(floor:int)
		{
			floorView = new FloorView();
			addChild(floorView);
			floorView.init(floor);
		}
       
        
    
	
	public function get Floor():FloorView
	{
		return floorView;
	}
	
	}

}