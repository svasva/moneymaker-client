package ru.fcl.sdd.gui.ingame.shop 
{
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
     * ...
     * @author atuzov
     */
    public class BuyRoomHnd extends SignalCommand 
    {
        
        override public function execute():void
        {
            trace("BuyRoomHnd");
        }
        
    }

}