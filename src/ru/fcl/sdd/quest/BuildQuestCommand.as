package ru.fcl.sdd.quest 
{
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
	 * ...
	 * @author 
	 */
	public class BuildQuestCommand extends SignalCommand 
	{
		
		override public function execute():void 
        {
			injector.mapSingleton(CheckQuestSignal)
			injector.mapSingleton(CurrentQuestUpdatedSig); 
			injector.mapSingleton(QuestModel);
			injector.mapSingleton(QuestReqSuccessSig);
			injector.mapSingleton(QuestCompleateSig);
			
			signalCommandMap.mapSignalClass(CheckQuestSignal, CheckQuestCompleateCommand);
			signalCommandMap.mapSignalClass(QuestCompleateSig, QuestCompleateCommand);
		}
		
	}

}