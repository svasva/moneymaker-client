package ru.fcl.sdd.userdata.experience 
{
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
     * ...
     * @author atuzov
     */
    public class BuildExperienceCommand extends SignalCommand 
    {
        
        override public function execute():void
        {
            injector.mapSingleton(UpdateExperienceSignal);
            injector.mapSingletonOf(IExperience, Experience);
        }
        
    }

}