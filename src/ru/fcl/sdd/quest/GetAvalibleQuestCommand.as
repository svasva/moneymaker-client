package ru.fcl.sdd.quest 
{
	import org.robotlegs.mvcs.SignalCommand;
	import ru.fcl.sdd.services.main.ISender;
	import ru.fcl.sdd.services.main.parser.ParseAvalibleQuest;
	
	/**
	 * ...
	 * @author 
	 */
	public class GetAvalibleQuestCommand extends SignalCommand 
	{
		[Inject]
        public var sender:ISender;
		
		override public function execute():void
		{
			trace("GetAvalibleQuestCommand");
			sender.send( { command:"getAvailableQuests" }, ParseAvalibleQuest);  
		
		}
		
	}

}