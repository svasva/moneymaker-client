package ru.fcl.sdd.services.main.parser 
{
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.userdata.experience.IExperience;
	
	/**
     * ...
     * @author atuzov
     */
    public class ParseExperienceCommand extends SignalCommand 
    {
        
        [Inject]
        public var expObj:Object;
        
        [Inject]
        public var expMdl:IExperience;
        
        override public function execute():void
        {
            expMdl.count = expObj.exp;
            expMdl.levelNumer = expObj.levelNuber;
            expMdl.nextLevel = expObj.nextLv;
          
        }
    }
}