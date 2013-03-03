/**
 * User: Jessie
 * Date: 22.12.12
 * Time: 17:05
 */
package ru.fcl.sdd.location.floors
{
    import as3isolib.display.scene.IIsoScene;
	import as3isolib.display.scene.IsoScene;
    import as3isolib.geom.Pt;
	import de.polygonal.ds.HashMapValIterator;
	import ru.fcl.sdd.item.ActiveUserItemList;
	import ru.fcl.sdd.item.iso.ItemIsoView;
	import ru.fcl.sdd.location.room.Room;
	import ru.fcl.sdd.location.room.UserRoomList;
	import ru.fcl.sdd.pathfind.ClearPathGridRoomCommand;
	import ru.fcl.sdd.singlepers.ClearSinglePersCommand;
	
	
    
    import flash.display.DisplayObject;
    
    import org.robotlegs.mvcs.SignalCommand;
    
    import ru.fcl.sdd.scenes.MainIsoView;
    
    public class ChangeFloorCommand extends SignalCommand
    {
        [Inject]
        public var floorNumber:int;
		 [Inject]
    public var userItems:ActiveUserItemList;
         [Inject]
    public var floorsList:FloorsList;
	 [Inject]
    public var userRooms:UserRoomList;
      //  [Embed(source="./art/floor0.jpg")]
		//[Embed(source="../../../../../../art/pic/floor0.jpg")] private var floor0BgArt:Class;
       /// [Embed(source="./art/floor1.jpg")]
	//   [Embed(source="../../../../../../art/pic/floor1.jpg")]
        private var floor1BgArt:Class;
    //    [Embed(source="../../../../../../art/pic/floor2.jpg")]
       // [Embed(source="./art/floor2.jpg")]
        private var floor2BgArt:Class;
        
     //   [Embed(source="./art/floor3.jpg")]
	//	[Embed(source="../../../../../../art/pic/floor3.jpg")]
        private var floor3BgArt:Class;
		
    //    [Embed(source="../../../../../../art/pic/floor4.jpg")]
        //[Embed(source="./art/floor4.jpg")]
        private var floor4BgArt:Class;
       
      
        
			
        override public function execute():void
        {
            var mainIsoView:MainIsoView = injector.getInstance(MainIsoView);
            var _bg:DisplayObject;
            var pt:Pt;
            pt = new Pt( -2763, -897);
			commandMap.execute(ClearSinglePersCommand,mainIsoView.currentFloorNumber);
            mainIsoView.currentFloorNumber = floorNumber;
           
            // mainIsoView.backgroundContainer.removeChildAt(0);
            switch (floorNumber)
            {
                case 0:
                {
                    mainIsoView.currentFloor = floorsList.toArray()[0];
                  //  _bg = new floor0BgArt() as DisplayObject;
                 //   _bg.width = 4621;
                 //  _bg.height = 3093;
                 //   pt = new Pt(-2763, -897);
                //    _bg.x = pt.x;
                //    _bg.y = pt.y;
					 _bg =new floor_back_b_mc();
                 //    mainIsoView.removeScene(floor);
                    break;
                }
                case 1:
                {
                    mainIsoView.currentFloor = floorsList.toArray()[1];
                   //  _bg = new floor1BgArt() as DisplayObject;
                   _bg = new floor_back_mc();
                   //  mainIsoView.addScene(floor);
                    break;
                }
                case 2:
                {
                    mainIsoView.currentFloor = floorsList.toArray()[2]
                 //   _bg = new floor2BgArt() as DisplayObject;
                 //   _bg.width = 4621;
                 //   _bg.height = 3093;
                 //   pt = new Pt(-2763, -897);
                 //  _bg.x = pt.x;
                 //   _bg.y = pt.y;
					 _bg = new floor_back_mc();
                     //  mainIsoView.removeScene(floor);
                    break;
                }
                case 3:
                {
                    mainIsoView.currentFloor = floorsList.toArray()[3]
                 //   _bg = new floor3BgArt() as DisplayObject;
                //    _bg.width = 4621;
                //    _bg.height = 3093;
                //    pt = new Pt(-2763, -897);
                ///    ;
                ///    _bg.x = pt.x;
                 //  _bg.y = pt.y;
					 _bg = new floor_back_mc();
                     // mainIsoView.removeScene(floor);
                    break;
                }
                case 4:
                {
                    mainIsoView.currentFloor = floorsList.toArray()[4]
                 //   _bg = new floor4BgArt() as DisplayObject;
                //    _bg.width = 4621;
                 //   _bg.height = 3093;
                //    pt = new Pt(-2763, -897);
                //   _bg.x = pt.x;
                //   _bg.y = pt.y;
					 _bg = new floor_back_mc();
                     //  mainIsoView.removeScene(floor);
                    break;
                }
                default:
                {
                    mainIsoView.currentFloorNumber = 1;
					 mainIsoView.currentFloor = floorsList.toArray()[1]
                    _bg =new floor_back_mc();
                    break;
                }
            }
            
           while (mainIsoView.backgroundContainer.numChildren)
           {
                mainIsoView.backgroundContainer.removeChildAt(0);
            }
		  
           mainIsoView.backgroundContainer.addChild(_bg);
            mainIsoView.rangeOfMotionTarget = _bg;
			
			commandMap.execute(PlaceDefaultRoomCommand, floorNumber);
			var itrooms:HashMapValIterator = userRooms.iterator() as HashMapValIterator;
       // itrooms.reset();	
       
		commandMap.execute(ClearPathGridRoomCommand);
		
		 while(itrooms.hasNext())
		{
		  var room:Room = itrooms.next() as Room;
		  room.floor = floorNumber;
		 // if (room.floor == floorNumber)
		  commandMap.execute(PlaceRoomCommand, room);
		}
            
          
        }
    }
}
