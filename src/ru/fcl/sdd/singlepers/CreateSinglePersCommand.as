/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:00
 */
package ru.fcl.sdd.singlepers
{
import flash.geom.Point;
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.location.floors.FloorItemScene;
import ru.fcl.sdd.location.floors.FloorsList;
import ru.fcl.sdd.location.room.Room;
import ru.fcl.sdd.location.room.XmlRoomModel;

import ru.fcl.sdd.scenes.MainIsoView;



public class CreateSinglePersCommand extends SignalCommand
{
	
    [Inject]
    public var room:Room; 
	[Inject]
    public var floorList:FloorsList;
	[Inject]
    public var xmlRoomModel:XmlRoomModel;
	[Inject]
    public var persList:SinglePersList;

    override public function execute():void
    {
		var persons:Array = xmlRoomModel.PersonsByOrder(room.order);
		
		var p:Point = xmlRoomModel.CooordByOrder(room.order);
		for each(var pers:Object in persons)
		{
			var view:SinglePersIsoView = injector.getInstance(SinglePersIsoView);
			view.x = Number(pers.x)  * IsoConfig.CELL_SIZE + p.x *IsoConfig.CELL_SIZE;
			view.y = Number(pers.y)  * IsoConfig.CELL_SIZE + p.y * IsoConfig.CELL_SIZE;
		
			view.skin = pers.class_name;
			view.setDirection(int(pers.direction),pers.anim);
			var i:int = persList._size + 1;
			persList.set(i, view);
			commandMap.execute(AddSinglePersCommand, view);
		}
		
    }
}
}
