/**
 * User: Jessie
 * Date: 12.12.12
 * Time: 11:31
 */
package ru.fcl.sdd.pathfind
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildPathFind extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(HomusPathGrid);
        var humansPathGrid:HomusPathGrid = injector.getInstance(HomusPathGrid);
        humansPathGrid.init(26,44);

        injector.mapSingleton(FloorPathGridItemList);
		var floorsPathGrid:FloorPathGridItemList = injector.getInstance(FloorPathGridItemList);
		for (var i:int = 0; i < 5; i++)
		{
			var itemgrid:ItemsPathGrid = new ItemsPathGrid();
			itemgrid.init(26,44);
			floorsPathGrid.set(int(i), itemgrid);
			
		} 
		
		injector.mapSingleton(RoomsPathGrid);
        var roomsPathGrid:RoomsPathGrid = injector.getInstance(RoomsPathGrid);
		
		roomsPathGrid.init(26, 44);
       
        
    }
}
}
