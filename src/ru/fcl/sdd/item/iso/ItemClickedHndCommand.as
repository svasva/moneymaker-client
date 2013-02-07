package ru.fcl.sdd.item.iso 
{
    import as3isolib.geom.Pt;
    import com.adobe.crypto.SHA1;
    import flash.display.Shape;
    import flash.geom.Point;
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.gui.main.popup.WindowsLayerView;
    import ru.fcl.sdd.location.room.Room;
    import ru.fcl.sdd.location.room.RoomModel;
    import ru.fcl.sdd.location.room.UserRoomList;
    import ru.fcl.sdd.scenes.MainIsoView;
	
	/**
     * ...
     * @author atuzov
     */
    public class ItemClickedHndCommand extends SignalCommand 
    {
        [Inject]
        public var isoItem:ItemIsoView;
        
        [Inject]
        public var mainIso:MainIsoView;
        
        [Inject]
        public var windowsLayer:WindowsLayerView;
        
        [Inject] 
        public var roomMdl:RoomModel;
        
        [Inject]
        public var userRoomList:UserRoomList;
        
        private var shape:Shape;
        
        override public function execute():void 
        {
          
            roomMdl.selectedItem = isoItem;
            roomMdl.selectedItemId = isoItem.key;
            trace("isoItem status "+isoItem.status);
            trace("isoItem cash "+isoItem.cashMoney);
            trace("isoItem capacity "+isoItem.capacity);
            
         //   var room:Room =  userRoomList.get(roomMdl.selectedItemId);
           // trace("room "+room.)
            
           
            
            //
        }
        private function createSgape():Shape
        {
            var sh:Shape = new Shape();
            sh.graphics.beginFill(0x0);
            sh.graphics.drawCircle(0, 0, 10);
            sh.graphics.endFill();
            
            return sh;
        }
        
    }

}