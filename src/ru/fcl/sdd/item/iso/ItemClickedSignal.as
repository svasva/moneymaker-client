package ru.fcl.sdd.item.iso 
{
    import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	/**
     * ...
     * @author atuzov
     */
    public class ItemClickedSignal extends Signal
    {
        
        public function ItemClickedSignal() 
        {
            super(ItemIsoView);
        }
        
    }

}