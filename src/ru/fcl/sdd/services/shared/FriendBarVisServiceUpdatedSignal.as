package ru.fcl.sdd.services.shared 
{
	import org.osflash.signals.Signal;
	
	/**
     * ...
     * @author atuzov
     */
    public class FriendBarVisServiceUpdatedSignal extends Signal 
    {
        
        public function FriendBarVisServiceUpdatedSignal() 
        {
            super(Boolean);
        }
        
    }

}