/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.north
{
    import flash.events.MouseEvent;
    import org.robotlegs.mvcs.Mediator;
    import ru.fcl.sdd.money.GameMoneyUpdateSignal;
    import ru.fcl.sdd.money.IMoney;
    import ru.fcl.sdd.userdata.capacity.CapacityUpdateSignal;
    import ru.fcl.sdd.userdata.capacity.ICapacity;
    
    public class NorthPanelMediator extends Mediator
    {
        [Inject]
        public var view:NorthPanelView;
        [Inject]
        public var gameMoneyUpdate:GameMoneyUpdateSignal;
        [Inject(name="game_money")]
        public var gameMoneyModel:IMoney;
        [Inject(name="real_money")]
        public var realMoneyModel:IMoney;
        [Inject]
        public var capacityUpdate:CapacityUpdateSignal;
        [Inject]
        public var capacity:ICapacity;
        
        
        override public function onRegister():void
        {
            gameMoneyUpdate.add(setGameMoney);
            capacityUpdate.add(setCapacity);
            
            setGameMoney();
            setCapacity();
            setRealMoney();
            setExperience();
            setReputation();
            
            view.gameMoneyBtn.addEventListener(MouseEvent.CLICK, gameMoney_clickHandler);
            view.realMoneyBtn.addEventListener(MouseEvent.CLICK, realMoney_clickHandler);
            view.experienceBtn.addEventListener(MouseEvent.CLICK, experience_clickHandler);
            view.reputationBtn.addEventListener(MouseEvent.CLICK, reputation_clickHandler);
        }
        
        private function setCapacity():void 
        {
         
              view.gameMoneyBar.currValue = gameMoneyModel.count /capacity.capacity  * 100;    
             
             trace(view.gameMoneyBar.currValue);
        }
        
        override public function onRemove():void
        {
            view.gameMoneyBtn.removeEventListener(MouseEvent.CLICK, gameMoney_clickHandler);
            view.realMoneyBtn.removeEventListener(MouseEvent.CLICK, realMoney_clickHandler);
            view.experienceBtn.removeEventListener(MouseEvent.CLICK, experience_clickHandler);
            view.reputationBtn.removeEventListener(MouseEvent.CLICK, reputation_clickHandler);
        }
        
        private function setGameMoney():void
        {  
            view.gameMoney = gameMoneyModel.count;
        }
        
        private function setRealMoney():void
        {
            view.realMoney = realMoneyModel.count;
        }
        
        private function setExperience():void
        {
            view.experience = 9;
          
            view.experienceBar.currValue = 45;
        }
        
        private function setReputation():void
        {
            var reputation:Number=99;
            var minReputation:Number=100;
            var percent:Number;
            
            view.reputation = reputation;
            percent = reputation / minReputation * 100;
            
            if (reputation >= minReputation)
                view.reputationLevel = 3;
            else
            {
                if (percent >= 75 && percent < 100)
                     view.reputationLevel = 2;
                else if (percent >= 50 && percent < 75)
                    view.reputationLevel = 1;
                else if(percent<50)
                    view.reputationLevel = 0;
            }
            
           
            
            
            
           
        }
        
        private function gameMoney_clickHandler(event:MouseEvent):void
        {
        }
        
        private function realMoney_clickHandler(event:MouseEvent):void
        {
        }
        
        private function experience_clickHandler(event:MouseEvent):void
        {
        }
        
        private function reputation_clickHandler(event:MouseEvent):void
        {
        }
    }
}
