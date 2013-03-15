package ru.fcl.sdd.quest 
{
	import org.robotlegs.mvcs.SignalCommand;
	import ru.fcl.sdd.item.ActiveUserItemList;
	import ru.fcl.sdd.item.iso.ItemIsoView;
	import ru.fcl.sdd.item.Item;
	import ru.fcl.sdd.item.ItemCatalog;
	import ru.fcl.sdd.item.ShopModel;
	import ru.fcl.sdd.location.room.Room;
	import ru.fcl.sdd.location.room.RoomCatalog;
	import ru.fcl.sdd.location.room.UserRoomList;
	import ru.fcl.sdd.money.IMoney;
	import ru.fcl.sdd.tools.PrintJSON;
	import ru.fcl.sdd.userdata.experience.IExperience;
	import ru.fcl.sdd.userdata.reputation.IReputation;
	
	/**
	 * ...
	 * @author 
	 */
	public class CheckQuestCompleateCommand extends SignalCommand 
	{
		[Inject]
		public var questModel:QuestModel;
		
		[Inject]
        public var itemCatalog:ItemCatalog;
		
		 [Inject]
		public var userRoomList:UserRoomList;

		[Inject]
		public var roomList:RoomCatalog;
		
		[Inject]
        public var expMdl:IExperience;
		
		[Inject]
		public var  repMdl:IReputation;
		
		[Inject]
        public var shopMdl:ShopModel;
		
		[Inject]
		public var questReqSuccessSig:QuestReqSuccessSig;
		
		[Inject(name="game_money")]
        public var gameMoneyModel:IMoney;
		
		[Inject]
        public var userItems:ActiveUserItemList;
		
		private var checkObj:Object;
		
		private var questReq:Object;
		
		private var curantGameStates:Object;
		
		private var iterator:int = 0;
		
		
		
		override public function execute():void 
        {
			trace("CheckQuestCompleateCommand");
			checkObj = {level:false,money:false,coins:false,reputation:false,rooms:false,items:false };
			questReq = questModel.currentQuest.complete_requirements;
			//данные для выполнения квеста
			//questReq =  {level:3,money:"",coins:"",reputation:"",rooms:"50fd4da75dae913832000001",items:"50c868205dae91b34a000005"};
			//текущие параметры игры
			//curantGameStates = {level:3,money:100,coins:100,reputation:100,rooms:false,items:false };
			curantGameStates = {level:expMdl.levelNumer,money:gameMoneyModel.count,coins:gameMoneyModel.count,reputation:repMdl.countValue,rooms:false,items:false };
			iterator = 0;
			var str:String;			
			
			str = questReq.level;
			if (questReq.hasOwnProperty("level"))
			{
				if (str.length==0)
				{
					checkObj.level = true;
				}
			}	///
			else
				checkObj.level = true;
				
			str = questReq.money;
			if (questReq.hasOwnProperty("money"))
			{
				if (str.length==0)
				{
					checkObj.money = true;
				}
			}	///
			else
				checkObj.money = true;
			
			str = questReq.coins;
			if (questReq.hasOwnProperty("coins"))
			{
				if (str.length==0)
				{
					checkObj.coins = true;
				}
			}	///
			else
				checkObj.coins = true;
			
			str = questReq.reputation;
			if (questReq.hasOwnProperty("reputation"))
			{
				if (str.length==0)
				{
					checkObj.reputation = true;
				}
			}	///
			else
				checkObj.reputation = true;
				
			str = questReq.rooms;	
			if (questReq.hasOwnProperty("rooms"))
			{
				if (str.length==0)
				{
					checkObj.rooms = true;
				}
			}	///
			else
				checkObj.rooms = true;
				
			str = questReq.items;		
			if (questReq.hasOwnProperty("items"))
			{
				if (str.length==0)
				{
					checkObj.items = true;
				}
			}	///
			else
				checkObj.items = true;				
				
			PrintJSON.deepTrace(checkObj);
			trace("---------------------");
			checkReq();
			if(questModel.currentQuest.roomReq)
			checkRoom();
			if(questModel.currentQuest.itemReq)
			checkItem();
			PrintJSON.deepTrace(checkObj);
			
			calculateReq();
		}
		
		private function checkItem():void 
		{
			
			var vec:Vector.<MiniItemVO> =  questModel.currentQuest.itemReq
		
			
			for each (var reqItem:MiniItemVO in vec) 
			{				
				for each(var userItem:ItemIsoView in userItems.toArray())
				{	
					
					if (reqItem.catalogId == userItem.keyForCheck)
					{
						reqItem.isCheck = true;
						trace(reqItem.itemName);
					}
				}
			}
			var it:int = 0;
			for each (var reqItem1:MiniItemVO in vec) 
			{
				if (reqItem1.isCheck)
				{
					it++
				}
			}
		
			if (it == vec.length)
			{
				checkObj.items = true;	
			}
			else
			{
				checkObj.items = false;	
				for each (var reqItem2:MiniItemVO in vec) 
				{
					if (!reqItem2.isCheck)
					{
						trace("нужно купить " + reqItem2.itemName);
					}
				}
			}
			
		}
		
		private function checkRoom():void 
		{
			var vec:Vector.<MiniItemVO> =  questModel.currentQuest.roomReq
		
			
			for each (var reqItem:MiniItemVO in vec) 
			{				
				for each(var userItem:Room in userRoomList.toArray())
				{	
					
					if (reqItem.catalogId == userItem.catalogId)
					{
						reqItem.isCheck = true;
						trace(reqItem.itemName);
					}
				}
			}
			var it:int = 0;
			for each (var reqItem1:MiniItemVO in vec) 
			{
				if (reqItem1.isCheck)
				{
					it++
				}
			}
		
			if (it == vec.length)
			{
				checkObj.rooms = true;	
			}
			else
			{
				checkObj.rooms = false;	
				for each (var reqItem2:MiniItemVO in vec) 
				{
					if (!reqItem2.isCheck)
					{
						trace("нужно купить " + reqItem2.itemName);
					}
				}
			}
		}
		
		private function calculateReq():void 
		{
			for (var name:String in checkObj) 
			{
				if (checkObj[name])
					iterator++			
			}
			if (iterator == 6)
			{
				trace("Квест Выполнен");
				questModel.currentQuest.isCompleated = true;
				questReqSuccessSig.dispatch();
			}
			else
			{
				for (var name1:String in checkObj) 
				{
					if (!checkObj[name1])
					{
						trace("Не выполнено условие " + name1);
					}
						
				}
			}
		}
		
		private function checkReq():void 
		{
			if (!checkObj.level)
			{
				if (curantGameStates.level >= questReq.level)
				{
					checkObj.level = true;
				}				
			}
			if (!checkObj.money)
			{
				if (curantGameStates.money >= questReq.money)
				{
					checkObj.money = true;
				}	
			}
			if (!checkObj.coins)
			{
				if (curantGameStates.coins >= questReq.coins)
				{
					checkObj.coins = true;
				}	
			}
			if (!checkObj.reputation)
			{
				if (curantGameStates.reputation >= questReq.reputation)
				{
					checkObj.reputation = true;
				}	
			}
			
		}
		
	}

}