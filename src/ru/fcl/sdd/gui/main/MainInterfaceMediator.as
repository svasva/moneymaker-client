package ru.fcl.sdd.gui.main
{
    import as3isolib.geom.Pt;
    import com.bit101.components.PushButton;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.geom.Point;
    import flash.utils.ByteArray;
    import flash.utils.Timer;
    import org.aswing.event.InteractiveEvent;
	import org.aswing.LoadIcon;
    import org.osflash.signals.ISignal;
    import org.robotlegs.mvcs.Mediator;
    import ru.fcl.sdd.config.FlashVarsModel;
    import ru.fcl.sdd.gui.ingame.InGameGuiView;
    import ru.fcl.sdd.gui.ingame.shop.BuyRoomToServerCommandSignal;
    import ru.fcl.sdd.gui.ingame.shop.ForPurshRoomIdUpdatedSignal;
    import ru.fcl.sdd.gui.ingame.shop.OveredShopItemUpdatedSignal;
    import ru.fcl.sdd.gui.ingame.shop.SelectedShopItemUpdatedSignal;
    import ru.fcl.sdd.gui.main.controlpanel.ShowTutorialSignal;
    import ru.fcl.sdd.gui.main.friendbar.FriendBarView;
    import ru.fcl.sdd.gui.main.MainInterfaceView;
    import ru.fcl.sdd.gui.main.popup.WindowsLayerView;
    import ru.fcl.sdd.gui.main.tutorial.TutorialView;
	import ru.fcl.sdd.item.ItemVO;
    import ru.fcl.sdd.item.SellItemSignal;
    import ru.fcl.sdd.item.ShopModel;
    import ru.fcl.sdd.location.room.Room;
    import ru.fcl.sdd.location.room.RoomCatalog;
    import ru.fcl.sdd.location.room.RoomModel;
    import ru.fcl.sdd.location.room.SelectedItemUpdated;
    import ru.fcl.sdd.log.ILogger;
	import ru.fcl.sdd.quest.AcceptQuestSigCom;
	import ru.fcl.sdd.quest.CheckQuestSignal;
	import ru.fcl.sdd.quest.CurrentQuestUpdatedSig;
	import ru.fcl.sdd.quest.QuestAcceptedSig;
	import ru.fcl.sdd.quest.QuestCompleateSig;
	import ru.fcl.sdd.quest.QuestModel;
	import ru.fcl.sdd.quest.QuestReqSuccessSig;
    import ru.fcl.sdd.scenes.MainIsoView;
    import ru.fcl.sdd.services.main.ISender;
    import ru.fcl.sdd.services.shared.FriendBarVisModel;
    import ru.fcl.sdd.services.shared.FriendBarVisModelUpdatedSignal;
    import ru.fcl.sdd.services.shared.FriendBarVisServiceUpdatedSignal;
    import ru.fcl.sdd.services.shared.ISharedGameDataService;
  
    import ru.fcl.sdd.userdata.experience.IExperience;
    import ru.fcl.sdd.userdata.experience.UpdateLevelSignal;
    
    public class MainInterfaceMediator extends Mediator
    {
        [Inject]
        public var view:MainInterfaceView;
        
        [Inject]
        public var friendBarView:FriendBarView;
        
        [Inject]
        public var model:FriendBarVisModel;
        
        [Inject]
        public var friendBarModelUpdatedSignal:FriendBarVisModelUpdatedSignal;
        
        [Inject]
        public var logger:ILogger;
        
        [Inject]
        public var fiendBarVisBtnPressed:FriendBarVisBtnPressedSignal;
        
        [Inject]
        public var sharedGameDataSrv:ISharedGameDataService;
        
        [Inject]
        public var selectedShopItemUpdatedSignal:SelectedShopItemUpdatedSignal;
        [Inject]
        public var overedShopItemUpdatedSignal:OveredShopItemUpdatedSignal;
        
        [Inject]
        public var shopMdl:ShopModel;
        
        [Inject]
        public var inGame:InGameGuiView;
        
        [Inject]
        public var flashVars:FlashVarsModel;
        
        [Inject(name="buy_item")]
        public var buyItem:ISignal;
        
        [Inject]
        public var expMdl:IExperience;
        
        [Inject]
        public var windowsLayer:WindowsLayerView;
        
        [Inject]
        public var forPurshRoomIdUpdated:ForPurshRoomIdUpdatedSignal;
        
        [Inject]
        public var roomCatalog:RoomCatalog;
        
        [Inject]
        public var buyRoomSig:BuyRoomToServerCommandSignal;
        
        private var resetGame:PushButton;
        
        private var addBankomatRoom:PushButton;
        
        private var seciurityRoom:PushButton;
        
        private var investRoom:PushButton;       
        
        [Inject]
        public var sender:ISender;
        
        [Inject]
        public var selectedRoomItemUpdated:SelectedItemUpdated;
        [Inject] 
        public var roomMdl:RoomModel;
        
        [Inject]
        public var mainIso:MainIsoView;       
      
        
        [Inject]
        public var sellSignal:SellItemSignal;
        
          [Inject]
        public var updaterLevel:UpdateLevelSignal;
        
        [Inject]
        public var showTurorial:ShowTutorialSignal
		
		[Inject]
		public var questUpdateSig:CurrentQuestUpdatedSig;
		
		[Inject]
		public var questModel:QuestModel;    
		
		
		private var tutorial:TutorialView;
		
		[Inject]
		public var questAcept:AcceptQuestSigCom;
      
        
        [Inject]
		public var mainIsoView:MainIsoView;
		
		[Inject]
		public var checkQuest:CheckQuestSignal;
		
		[Inject]
		public var questReqSuccessSig:QuestReqSuccessSig;
		
		[Inject]
		public var questCompleateSig:QuestCompleateSig;
		
		[Inject]
		public var acceptedQuest:QuestAcceptedSig;
        
        private var timer:Timer = new Timer(1000, 1);
		
		private var tempVO:ItemVO;
        /**
         * Constructor
         */
        public function MainInterfaceMediator()
        {
        
        }
        
        /*-----------------------------------------------------------------------------------------
           Public methods
         -------------------------------------------------------------------------------------------*/
        override public function onRegister():void
        {
            view.friendBarVisBtn.addEventListener(MouseEvent.CLICK, onCloseFriendBarSelected);
            friendBarModelUpdatedSignal.add(onFriendBarVisModelUpdated);
            sharedGameDataSrv.friendBarVisState = sharedGameDataSrv.friendBarVisState;   
            
            view.addChild(view.friendBarVisBtn);
            selectedShopItemUpdatedSignal.add(onSelectedShopItemUpdated);
            overedShopItemUpdatedSignal.add(onOveredShopItemUpdatedSignal);
            forPurshRoomIdUpdated.add(onForPurshRoomIdUpdated);
            
            selectedRoomItemUpdated.add(onSelectedRoomItemUpdateds);
            
            updaterLevel.add(showNewLevelDialog);
            showTurorial.add(showTutor);
			
			questUpdateSig.add(questUpdated);
            
            view.popUpDialog.yesBtn.addEventListener(MouseEvent.CLICK, yesBtn_click);
            view.popUpDialog.noBtn.addEventListener(MouseEvent.CLICK, noBtn_click);
            view.cantBuyDialog.noBtn.addEventListener(MouseEvent.CLICK, noBtn_click);
            view.buyRoomDialog.noBtn.addEventListener(MouseEvent.CLICK, noBuyRoomBtn_click);
            view.buyRoomDialog.yesBtn.addEventListener(MouseEvent.CLICK, onBuyRoom);
            
            view.itemControl.ok.addEventListener(MouseEvent.CLICK, ok_click);
            view.itemControl.sell.addEventListener(MouseEvent.CLICK, sell_click);
            windowsLayer.addChild(view.popUpDialog);
            windowsLayer.addChild(view.cantBuyDialog);
            windowsLayer.addChild(view.shopItemToolTip);
            windowsLayer.addChild(view.buyRoomDialog);
            windowsLayer.addChild(view.itemControl);
            
            windowsLayer.addChild(view.newLevelSmallDialog);
            
            view.newLevelSmallDialog.visible = false;
            
            view.newLevelSmallDialog.okBtn.addEventListener(MouseEvent.CLICK, okBtn_click);
            tutorial = new TutorialView();
			windowsLayer.addChild(tutorial);
			tutorial.x = windowsLayer.width / 2 - tutorial.width / 2; 
			tutorial.y = windowsLayer.height / 2 - tutorial.height / 2; 
			tutorial.visible = false;
            timer.addEventListener(TimerEvent.TIMER, timer_timer);
			
			view.questBtn.addEventListener(MouseEvent.CLICK, questBtn_click);
			
			view.questWindows.addData(questModel.currentQuest);
			windowsLayer.addChild(view.questWindows);
			view.questWindows.x = windowsLayer.width / 2 - view.questWindows.width / 2; 
			view.questWindows.y = windowsLayer.height / 2 - view.questWindows.height / 2; 
			view.questWindows.okBtn.addEventListener(MouseEvent.CLICK, questWindowsOkBtn_click);
			
			questReqSuccessSig.add(questReqSuccess)
			
			acceptedQuest.add(questAccepted);
			
			if(questModel.currentQuest)
				view.questBtn.setIcon(new LoadIcon(questModel.currentQuest.character_icon,82,89,true));
			
        }
		
		private function questAccepted():void 
		{
			questModel.currentQuest.isAccept = true;
			view.questWindows.okBtn.visible = false;
		}
		
		private function questReqSuccess():void 
		{
			view.questWindows.descrS = questModel.currentQuest.complete_text;
			view.questWindows.okBtn.visible = true;
		}
		
		private function questWindowsOkBtn_click(e:MouseEvent):void 
		{
			if (questModel.currentQuest.isCompleated)
			{
				
				questCompleateSig.dispatch();
				view.questWindows.visible = false;
			}
			else
			{
				view.questWindows.visible = false;
				questAcept.dispatch();
			}
			
		}
		
		private function questUpdated():void 
		{
			
			view.questWindows.addData(questModel.currentQuest);
			if(questModel.currentQuest)
				view.questBtn.setIcon(new LoadIcon(questModel.currentQuest.character_icon,82,89,true));
		}
		
		private function questBtn_click(e:MouseEvent):void 
		{
			
			checkQuest.dispatch();
			if(view.questBtn.isSelected()) 
			{
				view.questWindows.visible = true;
			}
			else
			{
				view.questWindows.visible = false;
			}
		}
        
        private function timer_timer(e:TimerEvent):void 
        {
            view.shopItemToolTip.addData(shopMdl.overedShopItem);
			view.shopItemToolTip.show();            
        }
        
        private function showTutor():void 
        {
            tutorial.visible = true;
        }       
        private function showNewLevelDialog():void 
        {
             view.newLevelSmallDialog.visible = true;
             view.newLevelSmallDialog.levelTf.text = expMdl.levelNumer.toString();
			 
			 checkQuest.dispatch();
			 
        }
        
        private function okBtn_click(e:MouseEvent):void 
        {
            view.newLevelSmallDialog.visible = false;
        }
        
        private function sell_click(e:MouseEvent):void 
        {
            sellSignal.dispatch();
        }
        
        private function ok_click(e:MouseEvent):void 
        {
            view.itemControl.visible = false;
        }
        
        private function onSelectedRoomItemUpdateds():void
        {
            
            if (roomMdl.selectedItem)
            {            
                var point:Point = mainIso.isoToLocal(new Pt(roomMdl.selectedItem.x, roomMdl.selectedItem.y, roomMdl.selectedItem.z));
                view.itemControl.x = point.x;
                view.itemControl.y = point.y;
                view.itemControl.visible = true;
                
                
             /*   if(roomMdl.selectedItem.cashMoney)
             //       view.itemControl.cashTf.text = roomMdl.selectedItem.cashMoney.toString();
                else
//                    view.itemControl.cashTf.text = " "; */
                
              /*  if(roomMdl.selectedItem.capacity)
                    view.itemControl.capacityTf.text = roomMdl.selectedItem.capacity.toString();
                else
          //          view.itemControl.capacityTf.text = " ";*/
                
                if (roomMdl.selectedItem.status)
                {
                    view.itemControl.progress.visible = true;
                    var persent:int  = roomMdl.selectedItem.cashMoney * 100 / roomMdl.selectedItem.capacity;
                    if (persent < 100)
                    {
                        view.itemControl.progress.gotoAndStop(persent);
                    }
                }
                else
                {
                    view.itemControl.progress.visible = false;
                }
                
            }
            else
            {
                view.itemControl.visible = false;
            }
        }
        private function resetGameHnd(e:Event):void
        {
            trace("addBankomatRoom");
            
            sender.send({command: "resetGame"});
        }
        private function onBuyRoom(e:MouseEvent):void
        {
            view.buyRoomDialog.hide();
            buyRoomSig.dispatch();
        }
        private function noBuyRoomBtn_click(e:MouseEvent):void
        {
            view.buyRoomDialog.hide();
        }
        
        private function onForPurshRoomIdUpdated():void
        {
            view.buyRoomDialog.show();
            var room:Room =  roomCatalog.get(shopMdl.forPurshRoomId) as Room;
            view.buyRoomDialog.itemName = room.name;
            view.buyRoomDialog.itemDesc = room.decription;
            view.buyRoomDialog.url = room.icon_url;
            view.buyRoomDialog.gameMoneyPrise = room.coins_cost.toString();
            view.buyRoomDialog.goldPrice = room.money_cost.toString();
        }
        
        private function noBtn_click(e:MouseEvent):void
        {
            view.popUpDialog.hide();
            view.cantBuyDialog.hide();
        }
        
        private function yesBtn_click(e:MouseEvent):void
        {
            if (shopMdl.selectedShopItem.nonIsoItems)
			{
				trace("Это маркетинг чувак");
			}
			else
			{
				view.popUpDialog.hide();
				buyItem.dispatch(shopMdl.selectedShopItem);
			}
			
        }
        
        private function onOveredShopItemUpdatedSignal():void
        {
            // logger.log(this, "onOveredShopItemUpdatedSignal");
            
            if (shopMdl.overedShopItem)
            {
                   timer.start();
            }
            else
            {
                view.shopItemToolTip.hide();
                 timer.stop();
                 timer.reset();
            }
        }
        
        private function onSelectedShopItemUpdated():void
        {
            //logger.log(this, "onSelectedShopItemUpdated");
            
            if (!shopMdl.selectedShopItem.isLock)
            {
				view.popUpDialog.addData(shopMdl.selectedShopItem);
                view.popUpDialog.show();
            }
            else
            {
                view.cantBuyDialog.addData(shopMdl.selectedShopItem);
				view.cantBuyDialog.show();
            }
        }
        private function onFriendBarVisModelUpdated(value:Boolean):void
        {
          
            friendBarView.vis = value;
            if (value)
            {
               
                view.friendBarVisBtn.setSelected(false);
            }
            else
            {
                
                view.friendBarVisBtn.setSelected(true);
            }
        }
        
        private function onCloseFriendBarSelected(e:Event):void
        {
            fiendBarVisBtnPressed.dispatch();
        }
    
    /*-----------------------------------------------------------------------------------------
       Private methods
     -------------------------------------------------------------------------------------------*/
    
    /*-----------------------------------------------------------------------------------------
       Event Handlers
     -------------------------------------------------------------------------------------------*/
    }
}