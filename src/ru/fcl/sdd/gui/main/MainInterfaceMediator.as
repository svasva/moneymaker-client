package ru.fcl.sdd.gui.main
{
    import as3isolib.geom.Pt;
    import com.bit101.components.PushButton;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.utils.ByteArray;
    import org.aswing.event.InteractiveEvent;
    import org.osflash.signals.ISignal;
    import org.robotlegs.mvcs.Mediator;
    import ru.fcl.sdd.config.FlashVarsModel;
    import ru.fcl.sdd.gui.ingame.InGameGuiView;
    import ru.fcl.sdd.gui.ingame.shop.BuyRoomToServerCommandSignal;
    import ru.fcl.sdd.gui.ingame.shop.ForPurshRoomIdUpdatedSignal;
    import ru.fcl.sdd.gui.ingame.shop.OveredShopItemUpdatedSignal;
    import ru.fcl.sdd.gui.ingame.shop.SelectedShopItemUpdatedSignal;
    import ru.fcl.sdd.gui.main.friendbar.FriendBarView;
    import ru.fcl.sdd.gui.main.MainInterfaceView;
    import ru.fcl.sdd.gui.main.popup.WindowsLayerView;
    import ru.fcl.sdd.item.SellItemSignal;
    import ru.fcl.sdd.item.ShopModel;
    import ru.fcl.sdd.location.room.Room;
    import ru.fcl.sdd.location.room.RoomCatalog;
    import ru.fcl.sdd.location.room.RoomModel;
    import ru.fcl.sdd.location.room.SelectedItemUpdated;
    import ru.fcl.sdd.log.ILogger;
    import ru.fcl.sdd.scenes.MainIsoView;
    import ru.fcl.sdd.services.main.ISender;
    import ru.fcl.sdd.services.shared.FriendBarVisModel;
    import ru.fcl.sdd.services.shared.FriendBarVisModelUpdatedSignal;
    import ru.fcl.sdd.services.shared.FriendBarVisServiceUpdatedSignal;
    import ru.fcl.sdd.services.shared.ISharedGameDataService;
    import ru.fcl.sdd.tempFloorView.MapLayer;
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
        public  var layer:MapLayer;
        
        [Inject]
        public var sender:ISender;
        
        [Inject]
        public var selectedRoomItemUpdated:SelectedItemUpdated;
        [Inject] 
        public var roomMdl:RoomModel;
        
        [Inject]
        public var mainIso:MainIsoView;
        
        
        [Embed(source = "../../../../../../art/bin/Room5.xml" , mimeType = "application/octet-stream")]
        private var ROOM5:Class;
        
        [Embed(source = "../../../../../../art/bin/Room6.xml" , mimeType = "application/octet-stream")]
        private var ROOM6:Class;
        
        [Embed(source = "../../../../../../art/bin/Room7.xml" , mimeType = "application/octet-stream")]
        private var ROOM7:Class;
        
        [Inject]
        public var sellSignal:SellItemSignal
        
        
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
            
            view.popUpDialog.yesBtn.addEventListener(MouseEvent.CLICK, yesBtn_click);
            view.popUpDialog.noBtn.addEventListener(MouseEvent.CLICK, noBtn_click);
            view.cantBuyDialog.noBtn.addEventListener(MouseEvent.CLICK, noBtn_click);
            view.buyRoomDialog.noBtn.addEventListener(MouseEvent.CLICK, noBuyRoomBtn_click);
            view.buyRoomDialog.yesBtn.addEventListener(MouseEvent.CLICK, onBuyRoom);
            
            view.itemControl.ok.addEventListener(MouseEvent.CLICK, ok_click);
            view.itemControl.sell.addEventListener(MouseEvent.CLICK, sell_click);
            
            
            // view.popUpDialog.x = flashVars.app_width/2 - view.popUpDialog.width/2;
            // view.popUpDialog.y = 200;
            
            windowsLayer.addChild(view.popUpDialog);
            windowsLayer.addChild(view.cantBuyDialog);
            windowsLayer.addChild(view.shopItemToolTip);
            windowsLayer.addChild(view.buyRoomDialog);
            windowsLayer.addChild(view.itemControl)
            
            addBankomatRoom = new PushButton(windowsLayer, 50, 50, "Bankomat Room", addBankomatRoomHnd);
            seciurityRoom   = new PushButton(windowsLayer, 50, 80, "Security Room", addseciurityRoom);
            investRoom      = new PushButton(windowsLayer, 50, 110, "Invest Room", addinvestRoom);
            resetGame       = new PushButton(windowsLayer, 650, 50, "Reset Game", resetGameHnd);
        
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
                
                
                if(roomMdl.selectedItem.cashMoney)
                    view.itemControl.cashTf.text = roomMdl.selectedItem.cashMoney.toString();
                else
                    view.itemControl.cashTf.text = " "; 
                
                if(roomMdl.selectedItem.capacity)
                    view.itemControl.capacityTf.text = roomMdl.selectedItem.capacity.toString();
                else
                    view.itemControl.capacityTf.text = " ";
                
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
        private function addBankomatRoomHnd(e:Event):void
        {
            trace("addBankomatRoom");
            
            var bytes:ByteArray ; 
            bytes = new ROOM5();
            var xml:XML;         
            
            xml  = new XML(bytes.readUTFBytes(bytes.length));
            layer.isoFlor.loadRooms(xml.floors.rooms);
        }
        
        private function addseciurityRoom(e:Event):void
        {
            trace("addBankomatRoom");
            var bytes:ByteArray ; 
            bytes = new ROOM6();
            var xml:XML;         
            
            xml  = new XML(bytes.readUTFBytes(bytes.length));
            layer.isoFlor.loadRooms(xml.floors.rooms);
        }
        
        private function addinvestRoom(e:Event):void
        {
            trace("addBankomatRoom");
            var bytes:ByteArray ; 
            bytes = new ROOM7();
            var xml:XML;         
            
            xml  = new XML(bytes.readUTFBytes(bytes.length));
            layer.isoFlor.loadRooms(xml.floors.rooms);
        
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
                if( shopMdl.overedShopItem.iconUrl)
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
                if(shopMdl.selectedShopItem.iconUrl)
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
                if(shopMdl.selectedShopItem.iconUrl)
                view.cantBuyDialog.url = shopMdl.selectedShopItem.iconUrl;            
                view.cantBuyDialog.show();
            }
        
        }
        
        private function onFriendBarVisModelUpdated(value:Boolean):void
        {
            
            logger.log(this, "onFriendBarVisModelUpdated", value);
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