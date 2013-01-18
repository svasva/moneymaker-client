package ru.fcl.sdd.services.main.parser 
{
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.userdata.capacity.ICapacity;
	
	/**
     * ...
     * @author atuzov
     */
    public class ParseCapasityCommand extends SignalCommand 
    {
        
         [Inject]
        public var capacityRaw:int;
        
        [Inject]
        public var capMdl:ICapacity;
       
        
        override public function execute():void 
        {
            capMdl.capacity = capacityRaw as Number;
            trace( "capMdl.capacity : " + capMdl.capacity );
            
        }
        
    }

}