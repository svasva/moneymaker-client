package ru.fcl.sdd.quest 
{
	import org.robotlegs.mvcs.SignalCommand;
	import ru.fcl.sdd.buildapplication.init.InitCompeteCommand;
	import ru.fcl.sdd.services.main.ISender;
	import ru.fcl.sdd.services.main.parser.ParseQuestCommand;
	
	/**
	 * ...
	 * @author 
	 */
	public class GetQuestsCommand extends SignalCommand 
	{	
		[Inject]
        public var sender:ISender;
		
		override public function execute():void 
        {
			trace("GetQuestsCommand");
			sender.send( { command:"getQuests" }, ParseQuestCommand);  
			  
			//commandMap.execute(InitCompeteCommand);
		}
		
	}

}