package ru.fcl.sdd.services.main.parser 
{
	import org.robotlegs.mvcs.SignalCommand;
	import ru.fcl.sdd.config.FlashVarsModel;
	import ru.fcl.sdd.item.Item;
	import ru.fcl.sdd.item.ItemCatalog;
	import ru.fcl.sdd.location.room.Room;
	import ru.fcl.sdd.location.room.RoomCatalog;
	import ru.fcl.sdd.quest.GetAvalibleQuestCommand;
	import ru.fcl.sdd.quest.MiniItemVO;
	import ru.fcl.sdd.quest.QuestModel;
	import ru.fcl.sdd.quest.QuestVO;
	import ru.fcl.sdd.tools.PrintJSON;
	
	/**
	 * ...
	 * @author 
	 */
	public class ParseQuestCommand extends SignalCommand 
	{
		
		[Inject]
        public var questObj:Object;
		
		[Inject]
		public var questModel:QuestModel;
		
		[Inject]
		public var flashVars:FlashVarsModel;
		
		[Inject]
        public var itemCatalog:ItemCatalog;
		
		[Inject]
		public var roomList:RoomCatalog;		
		
		override public function execute():void 
        {
			trace("ParseQuestCommand");			
			var itemsArray:Array = questObj.response;     
            PrintJSON.deepTrace(questObj);
			itemsArray.forEach(parseItem);		
			
			commandMap.execute(GetAvalibleQuestCommand);
		}
		
		private function parseItem(object:Object, index:int, array:Array):void
        {
			
			var quest:QuestVO    = new QuestVO();
			quest.name           = object.name;
			quest.desc           = object.desc;
			quest.id             = object._id;
			quest.character_icon = flashVars.content_url + object.character_icon;
			
			quest.character_swf  = flashVars.content_url + object.character_swf;
			quest.complete_requirements = object.complete_requirements;
			quest.complete_text  = object.complete_text;
			quest.quest_character_id = object.quest_character_id;
			quest.requirements   = object.requirements;
			quest.rewards        = object.rewards;
			questModel.setCatalogQuest(quest.id, quest);
			
			if (quest.complete_requirements.items)
			{
				quest.itemReq = new Vector.<MiniItemVO>();
				for (var id:String in quest.complete_requirements.items) 
				{
					var item:Item = itemCatalog.get(id) as Item;
					var miniIt:MiniItemVO = new MiniItemVO();
					miniIt.catalogId = id;
					miniIt.itemName = item.item_name;
					miniIt.isCheck = false;
				
					quest.itemReq.push(miniIt);
				}
			}
			if (quest.complete_requirements.rooms)
			{
				quest.roomReq = new Vector.<MiniItemVO>();
				for (var idRooms:String in quest.complete_requirements.rooms) 
				{
					var room:Room = roomList.get(idRooms) as Room;					 
					var miniIt:MiniItemVO = new MiniItemVO();
					miniIt.catalogId = idRooms;
					miniIt.itemName = room.name;
					miniIt.isCheck = false;
					quest.roomReq.push(miniIt);
				}
			}
			
		}
		
	}

}