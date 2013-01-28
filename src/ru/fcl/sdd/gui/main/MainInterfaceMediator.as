package ru.fcl.sdd.gui.main
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    import org.aswing.event.InteractiveEvent;
    import org.osflash.signals.ISignal;
    import org.robotlegs.mvcs.Mediator;
    import ru.fcl.sdd.config.FlashVarsModel;
    import ru.fcl.sdd.gui.ingame.InGameGuiView;
    import ru.fcl.sdd.gui.ingame.shop.OveredShopItemUpdatedSignal;
    import ru.fcl.sdd.gui.ingame.shop.SelectedShopItemUpdatedSignal;
    import ru.fcl.sdd.gui.main.friendbar.FriendBarView;
    import ru.fcl.sdd.gui.main.MainInterfaceView;
    import ru.fcl.sdd.gui.main.popup.WindowsLayerView;
    import ru.fcl.sdd.item.ShopModel;
    import ru.fcl.sdd.log.ILogger;
    import ru.fcl.sdd.services.shared.FriendBarVisModel;
    import ru.fcl.sdd.services.shared.FriendBarVisModelUpdatedSignal;
    import ru.fcl.sdd.services.shared.FriendBarVisServiceUpdatedSignal;
    import ru.fcl.sdd.services.shared.ISharedGameDataService;
    import ru.fcl.sdd.userdata.experience.IExperience;
    
      
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
            
            view.popUpDialog.yesBtn.addEventListener(MouseEvent.CLICK, yesBtn_click);
            view.popUpDialog.noBtn.addEventListener(MouseEvent.CLICK, noBtn_click);
            view.cantBuyDialog.noBtn.addEventListener(MouseEvent.CLICK, noBtn_click);
            
            
            
           // view.popUpDialog.x = flashVars.app_width/2 - view.popUpDialog.width/2;
           // view.popUpDialog.y = 200;
           
            
              windowsLayer.addChild(view.popUpDialog);
              windowsLayer.addChild(view.cantBuyDialog);
              windowsLayer.addChild(view.shopItemToolTip);
        }
        
        private function noBtn_click(e:MouseEvent):void 
        {
           view.popUpDialog.hide(); 
           view.cantBuyDialog.hide();
        }
        
        private function yesBtn_click(e:MouseEvent):void 
        {
            
            view.popUpDialog.hide();
            buyItem.dispatch(shopMdl.selectedShopItem);
        }
        
        private function onOveredShopItemUpdatedSignal():void 
        {
           // logger.log(this, "onOveredShopItemUpdatedSignal");
            
            if (shopMdl.overedShopItem)
            {
                view.shopItemToolTip.show();
                view.shopItemToolTip.itemName = shopMdl.overedShopItem.item_name;
                view.shopItemToolTip.itemDesc = shopMdl.overedShopItem.description;                
                if (shopMdl.overedShopItem.money_cost);
                view.shopItemToolTip.goldPrice = shopMdl.overedShopItem.money_cost.toString();
                view.shopItemToolTip.gameMoneyPrise = shopMdl.overedShopItem.gameMoneyPrice.toString();
                view.shopItemToolTip.url = shopMdl.overedShopItem.iconUrl;        
            }
            else
            {
               view.shopItemToolTip.hide();
            }
        }
        
        private function onSelectedShopItemUpdated():void 
        {
           //logger.log(this, "onSelectedShopItemUpdated");
            
            if (shopMdl.selectedShopItem.requirementLevel <=  expMdl.levelNumer)
            {
                view.popUpDialog.itemName = shopMdl.selectedShopItem.item_name;
                view.popUpDialog.itemDesc = shopMdl.selectedShopItem.description;
                if (shopMdl.selectedShopItem.money_cost);
                view.popUpDialog.goldPrice = shopMdl.selectedShopItem.money_cost.toString();
                view.popUpDialog.gameMoneyPrise = shopMdl.selectedShopItem.gameMoneyPrice.toString();
                view.popUpDialog.url = shopMdl.selectedShopItem.iconUrl;            
                view.popUpDialog.show();  
            }
            else
            {
                view.cantBuyDialog.itemName = shopMdl.selectedShopItem.item_name;
                view.cantBuyDialog.itemDesc = shopMdl.selectedShopItem.description;
                if (shopMdl.selectedShopItem.money_cost);
                view.cantBuyDialog.goldPrice = shopMdl.selectedShopItem.money_cost.toString();
                view.cantBuyDialog.gameMoneyPrise = shopMdl.selectedShopItem.gameMoneyPrice.toString();
                view.cantBuyDialog.url = shopMdl.selectedShopItem.iconUrl;            
                view.cantBuyDialog.show();  
            }
           
            
        }
        
        
        
        private function onFriendBarVisModelUpdated(value:Boolean):void
        {
            
            logger.log(this, "onFriendBarVisModelUpdated",value);
            friendBarView.vis = value;
            if (value)
            {
              //  view.friendBarVisBtn.setText("Закрыть");
                view.friendBarVisBtn.setSelected(false);
            }
            else
            {
             //   view.friendBarVisBtn.setText("Открыть");
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