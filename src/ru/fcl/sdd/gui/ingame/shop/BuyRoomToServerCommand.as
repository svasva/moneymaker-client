package ru.fcl.sdd.gui.ingame.shop 
{
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.item.ShopModel;
    import ru.fcl.sdd.services.main.ISender;
	
	/**
     * ...
     * @author atuzov
     */
    public class BuyRoomToServerCommand extends SignalCommand 
    {
        
        [Inject]
        public var sender:ISender;
        
        [Inject]
        public var shopMdl:ShopModel;
        
        override public function execute():void
        {
             trace("BuyRoomToServerCommand");
              sender.send({command:"buyContent",args:[/*item_id:*/shopMdl.forPurshRoomId,/*currency:*/"coins"]},BuyRoomHnd);
        }
        
    }

}