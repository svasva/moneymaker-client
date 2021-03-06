package ru.fcl.sdd.userdata.experience 
{
	import org.robotlegs.mvcs.SignalCommand;
	import ru.fcl.sdd.item.CheckItemFromShopCommand;
	
	/**
     * ...
     * @author 
     */
    public class BuildExperienceCommand extends SignalCommand 
    {
        
        override public function execute():void
        {
            injector.mapSingleton(UpdateExperienceSignal);
            injector.mapSingleton(UpdateLevelSignal);
            injector.mapSingletonOf(IExperience, Experience);
			
        }
        
    }

}