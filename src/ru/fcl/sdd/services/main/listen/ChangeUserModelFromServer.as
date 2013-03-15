package ru.fcl.sdd.services.main.listen 
{
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.money.IMoney;
	import ru.fcl.sdd.quest.CheckQuestSignal;
	import ru.fcl.sdd.quest.GetAvalibleQuestCommand;
	import ru.fcl.sdd.quest.QuestAcceptedSig;
    
    import ru.fcl.sdd.userdata.experience.IExperience;
    import ru.fcl.sdd.userdata.reputation.IReputation;
	
	/**
     * ...
     * @author atuzov
     */
    public class ChangeUserModelFromServer extends SignalCommand 
    {
        [Inject]
        public var response:Object;
        
        [Inject]
        public var reputationMdl:IReputation;
        
        [Inject]
        public var exp:IExperience;
		
		[Inject]
		public var acceptedQuest:QuestAcceptedSig;
		
		[Inject]
		public var checkQuest:CheckQuestSignal;
        
          [Inject(name="game_money")]
        public var gameMoneyModel:IMoney;
        
        override public function execute():void
        {
         
            if (response.response.accepted_quests)
			{
				acceptedQuest.dispatch();
			}
			if (response.response.completed_quests)
			{
				commandMap.execute(GetAvalibleQuestCommand)
			}
			
            if (response.response.reputation)
            {
                reputationMdl.countValue = response.response.reputation;
				checkQuest.dispatch();
            }
            else if (response.response.coins)
            {
                gameMoneyModel.count = response.response.coins;
				checkQuest.dispatch();
            }
            else if (response.response.experience)
            {
                exp.count = response.response.experience;
            }
            else if (response.response.levelnumber)
            {
             //   trace("response.response.levelnumber "+response.response.levelnumber);
                exp.levelNumer = response.response.levelnumber;
                exp.isLevelUdated = false;
               
            }
            
            
        }
        
    }

}