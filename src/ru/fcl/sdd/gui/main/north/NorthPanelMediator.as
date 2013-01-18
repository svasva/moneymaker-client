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
        
        override public function onRegister():void
        {
            gameMoneyUpdate.add(setGameMoney);
            setGameMoney();
            setRealMoney();
            setExperience();
            setReputation();
            
            view.gameMoneyBtn.addEventListener(MouseEvent.CLICK, gameMoney_clickHandler);
            view.realMoneyBtn.addEventListener(MouseEvent.CLICK, realMoney_clickHandler);
            view.experienceBtn.addEventListener(MouseEvent.CLICK, experience_clickHandler);
            view.reputationBtn.addEventListener(MouseEvent.CLICK, reputation_clickHandler);
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
            view.experience = 1;
            view.experienceBar.maxValue = 100;
            view.experienceBar.currValue = 50;
        }
        
        private function setReputation():void
        {
            view.reputation = 0;
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
