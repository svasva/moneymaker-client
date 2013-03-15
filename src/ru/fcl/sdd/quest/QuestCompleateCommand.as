package ru.fcl.sdd.quest 
{
	import org.robotlegs.mvcs.SignalCommand;
	import ru.fcl.sdd.services.main.ISender;
	
	/**
	 * ...
	 * @author 
	 */
	public class QuestCompleateCommand extends SignalCommand 
	{
		[Inject]
		public var questModel:QuestModel;
		
		[Inject]
        public var sender:ISender;
		
		override public function execute():void 
        {
			
			trace(questModel.currentQuest.id);
			sender.send( { command:"completeQuest", args:[questModel.currentQuest.id] });
		}
		
	}

}