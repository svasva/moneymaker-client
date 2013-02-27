package ru.fcl.sdd.pathfind 
{
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.config.IsoConfig;
    import ru.fcl.sdd.item.iso.ItemIsoView;
	import ru.fcl.sdd.scenes.MainIsoView;
	
	/**
     * ...
     * @author atuzov
     */
    public class DeletePathGreedItemCommand extends SignalCommand 
    {
        [Inject]
        public var iso:ItemIsoView;
        [Inject]
        public var pathGrids:FloorPathGridItemList;
		 [Inject]
		public var mainIsoView:MainIsoView;
		
        override public function execute():void
        
		{
			
		var pathGrid:ItemsPathGrid = pathGrids.get(mainIsoView.currentFloorNumber) as ItemsPathGrid;
        for (var j:int = 0; j < iso.length / IsoConfig.CELL_SIZE; j++)
        {
            for (var i:int = 0; i < iso.width / IsoConfig.CELL_SIZE; i++)
            {
                pathGrid.setWalkable(i + iso.x / IsoConfig.CELL_SIZE, j + iso.y / IsoConfig.CELL_SIZE, true);
                
            }
        }
    }
        
    }

}