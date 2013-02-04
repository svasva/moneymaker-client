package ru.fcl.sdd.userdata.reputation 
{
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
     * ...
     * @author 
     */
    public class BuildReputationCommand extends SignalCommand 
    {
        
        override public function execute():void
        {
            injector.mapSingleton(UpdateReputationSignal);
            injector.mapSingletonOf(IReputation, Reputation);
        }
        
    }

}