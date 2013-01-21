package ru.fcl.sdd.services.main.parser 
{
    import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.userdata.reputation.IReputation;
	/**
     * ...
     * @author atuzov
     */
    public class ParseReputationCommand extends SignalCommand
    {
        
        [Inject]
        public var repObj:Object;
        
        [Inject]
        public var repMdl:IReputation;
        
        override public function execute():void
        {
            repMdl.min_rep = repObj.reputation;
            repMdl.countValue = repObj.min_rep;
        }
    }

}