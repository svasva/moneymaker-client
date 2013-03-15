package ru.fcl.sdd.quest 
{
	/**
	 * ...
	 * @author 
	 */
	public class QuestModel 
	{
		
		[Inject]
		public var updateCurrentSig:CurrentQuestUpdatedSig;
		
		
		private var questCatalog:QuestCatalogHash;
		private var userQuests:UserQuests;
		private var _currentQuest:QuestVO;
		private var _curentQuestId:String;
		
		public function QuestModel() 
		{
			questCatalog = new QuestCatalogHash();
			userQuests = new UserQuests();
		}
		public function setCatalogQuest(key:String,obj:QuestVO):void
		{
			questCatalog.set(key,obj);
		}
		public function setUserQuest(key:String,obj:QuestVO):void
		{
			userQuests.set(key,obj);
		}
		
		public function get currentQuest():QuestVO 
		{
			return _currentQuest;
		}
		
		public function set currentQuest(value:QuestVO):void 
		{
			_currentQuest = value;
			updateCurrentSig.dispatch();
		}
		
		public function get curentQuestId():String 
		{
			return _curentQuestId;
		}
		
		public function set curentQuestId(value:String):void 
		{
			_curentQuestId = value;
			//trace("_curentQuestId "+_curentQuestId);
		}
		public function getQuestFromCatakogById(id:String):QuestVO
		{
			return questCatalog.get(id) as QuestVO;
		}
		
	}

}