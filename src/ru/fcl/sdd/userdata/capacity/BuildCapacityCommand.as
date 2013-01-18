package ru.fcl.sdd.userdata.capacity 
{
    import org.robotlegs.mvcs.SignalCommand;
	/**
     * ...
     * @author atuzov
     */
    public class BuildCapacityCommand extends SignalCommand
    {
        
        override public function execute():void 
        {
            injector.mapSingleton(CapacityUpdateSignal);
            injector.mapSingletonOf(ICapacity, Capacity);
            
        }
        
    }

}