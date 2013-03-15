package ru.fcl.sdd.services.main.parser 
{
	import org.robotlegs.mvcs.SignalCommand;
	import ru.fcl.sdd.quest.QuestModel;
	import ru.fcl.sdd.quest.QuestVO;
	import ru.fcl.sdd.tools.PrintJSON;
	
	/**
	 * ...
	 * @author 
	 */
	public class ParseAvalibleQuest extends SignalCommand 
	{
		[Inject]
        public var questObj:Object;
		
		[Inject]
		public var questModel:QuestModel;		
		
		override public function execute():void
		{
			trace("ParseAvalibleQuest");
			//PrintJSON.deepTrace(questObj);
			var itemsArray:Array = questObj.response;     
			var str:String  = questObj.response;
            if (str.length!=0)
				itemsArray.forEach(parseItem);	
			else
				getQuest();
		}
		
		private function getQuest():void 
		{
			
			var quest:QuestVO;
			quest = questModel.getQuestFromCatakogById(questModel.curentQuestId);
			if (quest)
			{
				trace("quest.name " + quest.name);
				quest.isAccept = true;
				questModel.currentQuest = quest;
			}
			
		}
		private function parseItem(object:Object, index:int, array:Array):void
        {
			var quest:QuestVO;
			quest = questModel.getQuestFromCatakogById(object as String);
			questModel.currentQuest = quest;
		}
		
	}

}