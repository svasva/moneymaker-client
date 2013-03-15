package ru.fcl.sdd.quest 
{
	import org.robotlegs.mvcs.SignalCommand;
	import ru.fcl.sdd.services.main.ISender;
	
	/**
	 * ...
	 * @author 
	 */
	public class AcceptQuestCommand extends SignalCommand 
	{
		[Inject]
		public var questModel:QuestModel;
		
		[Inject]
        public var sender:ISender;
		
		override public function execute():void
		{
			//sender.send( { command:"getAvailableQuests" }, ParseAvalibleQuest);  
			
			sender.send( { command:"acceptQuest", args:[questModel.currentQuest.id] });
		}
		
	}

}