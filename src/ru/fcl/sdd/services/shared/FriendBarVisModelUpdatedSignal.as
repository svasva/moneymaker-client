package ru.fcl.sdd.services.shared 
{
	import org.osflash.signals.Signal;
	
	/**
     * ...
     * @author atuzov
     */
    public class FriendBarVisModelUpdatedSignal extends Signal 
    {
        
        public function FriendBarVisModelUpdatedSignal() 
        {
            super(Boolean);
        }
        
    }

}