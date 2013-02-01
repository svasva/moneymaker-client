package ru.fcl.sdd.gui.ingame.shop 
{
    import com.adobe.images.JPGEncoder;
    import de.polygonal.ds.HashMap;
    import flash.display.DisplayObject;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import org.aswing.AssetIcon;
    import org.aswing.ButtonGroup;
    import org.aswing.EmptyLayout;
    import org.aswing.GridLayout;
    import org.aswing.JButton;
    import org.aswing.JPanel;
    import org.aswing.JTabbedPane;
    import org.aswing.JToggleButton;
    import org.aswing.plaf.DefaultEmptyDecoraterResource;
    import org.aswing.plaf.EmptyLayoutUIResourse;
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.gui.ingame.shop.events.ShopItemRoomEvent;
    import ru.fcl.sdd.item.ItemCatalog;
    import ru.fcl.sdd.item.ShopItemRoom;
    import ru.fcl.sdd.item.ShopItemRoomView;
    import ru.fcl.sdd.item.ShopModel;
    import ru.fcl.sdd.location.room.Room;
    import ru.fcl.sdd.location.room.RoomCatalog;
    import ru.fcl.sdd.location.room.UserRoomList;
    import ru.fcl.sdd.rsl.GuiRsl;
    import ru.fcl.sdd.userdata.experience.Experience;
    import ru.fcl.sdd.userdata.experience.IExperience;
	
	/**
     * ...
     * @author atuzov
     */
    public class ConstructShopViewFromModel extends SignalCommand 
    {
        
        [Inject]
        public var shopView:ShopView;
        
        [Inject]
        public var shopMdl:ShopModel;
        
        [Inject]
        public var clickedSignal:ShopItemRoomSignal;
        
        private var btnGroup:ButtonGroup
        
        [Inject]
        public var rsl:GuiRsl;
                
        [Inject]
        public var userRoomlist:UserRoomList;
        
        public var pointVector:Vector.<Point>;
        
        [Inject]
        public var itemCatalog:ItemCatalog;
        
        [Inject]
        public var roomCatalog:RoomCatalog;
        
        [Inject]
        public var expMdl:IExperience;
        
        override public function execute():void 
        {
          
           var mainPanel:JPanel = new JPanel();
         
          // var layout0:GridLayout = new GridLayout(2,3,29,16);
           mainPanel.setLayout(new EmptyLayoutUIResourse());
           mainPanel.setY(76);
           mainPanel.setClipMasked(false);
           mainPanel.setSizeWH(550, 70);
           
           btnGroup = new ButtonGroup();
           //TODO:Сделать програмную расстановку кнопок по порядковом номеру с сервера. 
           
           var shopMain:Vector.<Object> = (shopMdl.get("main") as HashMap).toVector();
                      
           var operationRoomShopBtn:JToggleButton = new JToggleButton();
            operationRoomShopBtn.width = 48;
            operationRoomShopBtn.height = 63;
            operationRoomShopBtn.x = 150;        
            operationRoomShopBtn.setBackgroundDecorator(new DefaultEmptyDecoraterResource());
            operationRoomShopBtn.setForegroundDecorator(new DefaultEmptyDecoraterResource());
            operationRoomShopBtn.setIcon( new AssetIcon( getAsset("ButtonRoom1UpArt")));
            operationRoomShopBtn.setPressedIcon( new AssetIcon( getAsset("ButtonRoom1DownArt")));
            operationRoomShopBtn.setRollOverIcon( new AssetIcon( getAsset("ButtonRoom1OverArt")));
            operationRoomShopBtn.setSelectedIcon( new AssetIcon( getAsset("ButtonRoom1ActiveArt")));
            operationRoomShopBtn.setRollOverSelectedIcon( new AssetIcon( getAsset("ButtonOperationRoomActiveOverArt")));
            operationRoomShopBtn.setDisabledIcon( new AssetIcon( getAsset("ButtonRoom1CloseArt")));
            operationRoomShopBtn.setDisabledSelectedIcon( new AssetIcon( getAsset("ButtonRoom1CloseArt")));
            operationRoomShopBtn.buttonMode = true;
          //  operationRoomShopBtn.setEnabled(false);
            mainPanel.append(operationRoomShopBtn);
         
            
            var directorRoomShopBtn:JToggleButton = new JToggleButton();
            directorRoomShopBtn.width = 48;
            directorRoomShopBtn.height = 63;
            directorRoomShopBtn.x = 210;
            //directorRoomShopBtn.y = 72;          
            directorRoomShopBtn.setBackgroundDecorator(new DefaultEmptyDecoraterResource());
            directorRoomShopBtn.setForegroundDecorator(new DefaultEmptyDecoraterResource());
            directorRoomShopBtn.setIcon( new AssetIcon( getAsset("ButtonDirectorRoomUpArt")));
            directorRoomShopBtn.setPressedIcon( new AssetIcon( getAsset("ButtonDirectorRoomDownArt")));
            directorRoomShopBtn.setRollOverIcon( new AssetIcon( getAsset("ButtonDirectorRoomOverArt")));
            directorRoomShopBtn.setSelectedIcon( new AssetIcon( getAsset("ButtonDirectorRoomActiveArt")));
            directorRoomShopBtn.setRollOverSelectedIcon( new AssetIcon( getAsset("ButtonDirectorRoomActiveOverArt")));
            directorRoomShopBtn.setDisabledIcon( new AssetIcon( getAsset("ButtonDirectorRoomCloseArt")));
            directorRoomShopBtn.setDisabledSelectedIcon( new AssetIcon( getAsset("ButtonDirectorRoomCloseArt")));
            directorRoomShopBtn.buttonMode = true;
         //   directorRoomShopBtn.setEnabled(false);            
            mainPanel.append(directorRoomShopBtn);
          
          
            
             
            var seifRoomShopBtn:JToggleButton = new JToggleButton();
            seifRoomShopBtn.width = 48;
            seifRoomShopBtn.height = 63;
            seifRoomShopBtn.x = 450;
            //seifRoomShopBtn.y = 72;          
            seifRoomShopBtn.setBackgroundDecorator(new DefaultEmptyDecoraterResource());
            seifRoomShopBtn.setForegroundDecorator(new DefaultEmptyDecoraterResource());
            seifRoomShopBtn.setIcon( new AssetIcon( getAsset("ButtonSeifRoomUpArt")));
            seifRoomShopBtn.setPressedIcon( new AssetIcon( getAsset("ButtonSeifRoomDownArt")));
            seifRoomShopBtn.setRollOverIcon( new AssetIcon( getAsset("ButtonSeifRoomOverArt")));
            seifRoomShopBtn.setSelectedIcon( new AssetIcon( getAsset("ButtonSeifRoomActiveArt")));
            seifRoomShopBtn.setRollOverSelectedIcon( new AssetIcon( getAsset("ButtonSeifRoomActiveOverArt")));
            seifRoomShopBtn.setDisabledIcon( new AssetIcon( getAsset("ButtonSeifRoomCloseArt")));
            seifRoomShopBtn.setDisabledSelectedIcon( new AssetIcon( getAsset("ButtonSeifRoomCloseArt")));
            seifRoomShopBtn.buttonMode = true;
          //  seifRoomShopBtn.setEnabled(false);            
            mainPanel.append(seifRoomShopBtn);
            
           
            
             var bankomatRoomShopBtn:JToggleButton = new JToggleButton();
            bankomatRoomShopBtn.width = 48;
            bankomatRoomShopBtn.height = 63;
            bankomatRoomShopBtn.x = 270;
            //bankomatRoomShopBtn.y = 72;          
            bankomatRoomShopBtn.setBackgroundDecorator(new DefaultEmptyDecoraterResource());
            bankomatRoomShopBtn.setForegroundDecorator(new DefaultEmptyDecoraterResource());
            bankomatRoomShopBtn.setIcon( new AssetIcon( getAsset("ButtonBankomatRoomUpArt")));
            bankomatRoomShopBtn.setPressedIcon( new AssetIcon( getAsset("ButtonBankomatRoomDownArt")));
            bankomatRoomShopBtn.setRollOverIcon( new AssetIcon( getAsset("ButtonBankomatRoomOverArt")));
            bankomatRoomShopBtn.setSelectedIcon( new AssetIcon( getAsset("ButtonBankomatRoomAcriveArt")));
            bankomatRoomShopBtn.setRollOverSelectedIcon( new AssetIcon( getAsset("ButtonBankomatRoomAcriveOverArt")));
            bankomatRoomShopBtn.setDisabledIcon( new AssetIcon( getAsset("ButtonBankomatRoomCloseArt")));
            bankomatRoomShopBtn.setDisabledSelectedIcon( new AssetIcon( getAsset("ButtonBankomatRoomCloseArt")));
            bankomatRoomShopBtn.buttonMode = true;
         //   bankomatRoomShopBtn.setEnabled(false);
            mainPanel.append(bankomatRoomShopBtn);
            
          
            
            var secureRoomShopBtn:JToggleButton = new JToggleButton();
            secureRoomShopBtn.width = 48;
            secureRoomShopBtn.height = 63;
            secureRoomShopBtn.x = 390;
            //secureRoomShopBtn.y = 72;          
            secureRoomShopBtn.setBackgroundDecorator(new DefaultEmptyDecoraterResource());
            secureRoomShopBtn.setForegroundDecorator(new DefaultEmptyDecoraterResource());
            secureRoomShopBtn.setIcon( new AssetIcon( getAsset("ButtonSecurRoomUpArt")));
            secureRoomShopBtn.setPressedIcon( new AssetIcon( getAsset("ButtonSecurRoomDownArt")));
            secureRoomShopBtn.setRollOverIcon( new AssetIcon( getAsset("ButtonSecurRoomOverArt")));
            secureRoomShopBtn.setSelectedIcon( new AssetIcon( getAsset("ButtonSecurRoomActiveArt")));
            secureRoomShopBtn.setRollOverSelectedIcon( new AssetIcon( getAsset("ButtonSecurRoomActiveOverArt")));
            secureRoomShopBtn.setDisabledIcon( new AssetIcon( getAsset("ButtonSecurRoomCloseArt")));
            secureRoomShopBtn.setDisabledSelectedIcon( new AssetIcon( getAsset("ButtonSecurRoomCloseArt")));
            secureRoomShopBtn.buttonMode = true;
          //  secureRoomShopBtn.setEnabled(false);            
            mainPanel.append(secureRoomShopBtn);
            
          
            
             var filialRoomShopBtn:JToggleButton = new JToggleButton();
            filialRoomShopBtn.width = 48;
            filialRoomShopBtn.height = 63;
            filialRoomShopBtn.x = 330;
            //filialRoomShopBtn.y = 72;          
            filialRoomShopBtn.setBackgroundDecorator(new DefaultEmptyDecoraterResource());
            filialRoomShopBtn.setForegroundDecorator(new DefaultEmptyDecoraterResource());
            filialRoomShopBtn.setIcon( new AssetIcon( getAsset("ButtonFilialRoomUpArt")));
            filialRoomShopBtn.setPressedIcon( new AssetIcon( getAsset("ButtonFilialRoomDownArt")));
            filialRoomShopBtn.setRollOverIcon( new AssetIcon( getAsset("ButtonFilialRoomOverArt")));
            filialRoomShopBtn.setSelectedIcon( new AssetIcon( getAsset("ButtonFilialRoomActiveArt")));
            filialRoomShopBtn.setRollOverSelectedIcon( new AssetIcon( getAsset("ButtonFilialRoomActiveOverArt")));
            filialRoomShopBtn.setDisabledIcon( new AssetIcon( getAsset("ButtonFilialRoomCloseArt")));
            filialRoomShopBtn.setDisabledSelectedIcon( new AssetIcon( getAsset("ButtonFilialRoomCloseArt")));
            filialRoomShopBtn.buttonMode = true;
           // filialRoomShopBtn.setEnabled(false);
            mainPanel.append(filialRoomShopBtn);
            
          
            
            var encashmentShopBtn:JToggleButton = new JToggleButton();
            encashmentShopBtn.width = 48;
            encashmentShopBtn.height = 63;
            encashmentShopBtn.x = 510;
            //encashmentShopBtn.y = 72;          
            encashmentShopBtn.setBackgroundDecorator(new DefaultEmptyDecoraterResource());
            encashmentShopBtn.setForegroundDecorator(new DefaultEmptyDecoraterResource());
            encashmentShopBtn.setIcon( new AssetIcon( getAsset("ButtonEncashmentRoomUpArt")));
            encashmentShopBtn.setPressedIcon( new AssetIcon( getAsset("ButtonEncashmentRoomDownArt")));
            encashmentShopBtn.setRollOverIcon( new AssetIcon( getAsset("ButtonEncashmentRoomOverArt")));
            encashmentShopBtn.setSelectedIcon( new AssetIcon( getAsset("ButtonEncashmentRoomActiveArt")));
            encashmentShopBtn.setRollOverSelectedIcon( new AssetIcon( getAsset("ButtonEncashmentRoomActiveOverArt")));
            encashmentShopBtn.setDisabledIcon( new AssetIcon( getAsset("ButtonEncashmentRoomCloseArt")));
            encashmentShopBtn.setDisabledSelectedIcon( new AssetIcon( getAsset("ButtonEncashmentRoomCloseArt")));
            encashmentShopBtn.buttonMode = true;
           
            //encashmentShopBtn.setEnabled(false);
            mainPanel.append(encashmentShopBtn);
            
            
            
             var investShopBtn:JToggleButton = new JToggleButton();
            investShopBtn.width = 48;
            investShopBtn.height = 63;
            investShopBtn.x = 630;
            //investShopBtn.y = 72;          
            investShopBtn.setBackgroundDecorator(new DefaultEmptyDecoraterResource());
            investShopBtn.setForegroundDecorator(new DefaultEmptyDecoraterResource());
            investShopBtn.setIcon( new AssetIcon( getAsset("ButtonInvestRoomUpArt")));
            investShopBtn.setPressedIcon( new AssetIcon( getAsset("ButtonInvestRoomDownArt")));
            investShopBtn.setRollOverIcon( new AssetIcon( getAsset("ButtonInvestRoomOverArt")));
            investShopBtn.setSelectedIcon( new AssetIcon( getAsset("ButtonInvestRoomActiveArt")));
            investShopBtn.setRollOverSelectedIcon( new AssetIcon( getAsset("ButtonInvestRoomActiveOverArt")));
            investShopBtn.setDisabledIcon( new AssetIcon( getAsset("ButtonInvestRoomCloseArt")));
            investShopBtn.setDisabledSelectedIcon( new AssetIcon( getAsset("ButtonInvestRoomCloseArt")));
            investShopBtn.buttonMode = true;
            
            //investShopBtn.setEnabled(false);
            mainPanel.append(investShopBtn);
            
           
            
             var prShopBtn:JToggleButton = new JToggleButton();
            prShopBtn.width = 48;
            prShopBtn.height = 63;
            prShopBtn.x  = 570;
            //prShopBtn.y = 72;          
            prShopBtn.setBackgroundDecorator(new DefaultEmptyDecoraterResource());
            prShopBtn.setForegroundDecorator(new DefaultEmptyDecoraterResource());
            prShopBtn.setIcon( new AssetIcon( getAsset("ButtonPRRoomUpArt")));
            prShopBtn.setPressedIcon( new AssetIcon( getAsset("ButtonPRRoomDownArt")));
            prShopBtn.setRollOverIcon( new AssetIcon( getAsset("ButtonPRRoomOverArt")));
            prShopBtn.setSelectedIcon( new AssetIcon( getAsset("ButtonPRRoomActiveArt")));
            prShopBtn.setRollOverSelectedIcon( new AssetIcon( getAsset("ButtonPRRoomActiveOverArt")));
            prShopBtn.setDisabledIcon( new AssetIcon( getAsset("ButtonPRRoomCloseArt")));
            prShopBtn.setDisabledSelectedIcon( new AssetIcon( getAsset("ButtonPRRoomCloseArt")));
            prShopBtn.buttonMode = true;
            //prShopBtn.setEnabled(false);
            mainPanel.append(prShopBtn);
            
            btnGroup.append(operationRoomShopBtn);
            shopMdl.getShopItemByOrder(ShopModel.SHOP_TAB_MAIN, 0).btnView = operationRoomShopBtn;
            btnGroup.append(directorRoomShopBtn);
            shopMdl.getShopItemByOrder(ShopModel.SHOP_TAB_MAIN, 1).btnView = directorRoomShopBtn;
            btnGroup.append(bankomatRoomShopBtn);
            
            
            shopMdl.getShopItemByOrder(ShopModel.SHOP_TAB_MAIN, 2).btnView = bankomatRoomShopBtn;
            shopMdl.getShopItemByOrder(ShopModel.SHOP_TAB_MAIN, 2).shopItemRoomView = new ShopItemRoomView(getAsset("StoreRoomMockup") as Sprite);
            btnGroup.append(filialRoomShopBtn);
            
            
            shopMdl.getShopItemByOrder(ShopModel.SHOP_TAB_MAIN, 3).btnView = filialRoomShopBtn;
            btnGroup.append(secureRoomShopBtn);
            shopMdl.getShopItemByOrder(ShopModel.SHOP_TAB_MAIN, 4).btnView = secureRoomShopBtn;
            btnGroup.append(seifRoomShopBtn);
            shopMdl.getShopItemByOrder(ShopModel.SHOP_TAB_MAIN, 5).btnView = seifRoomShopBtn;
            
            btnGroup.append(encashmentShopBtn); 
            shopMdl.getShopItemByOrder(ShopModel.SHOP_TAB_MAIN, 6).btnView = encashmentShopBtn;
            btnGroup.append(prShopBtn);
            shopMdl.getShopItemByOrder(ShopModel.SHOP_TAB_MAIN, 7).btnView = prShopBtn;
            btnGroup.append(investShopBtn);
            shopMdl.getShopItemByOrder(ShopModel.SHOP_TAB_MAIN, 8).btnView = investShopBtn;
            
            shopView.uiJpanel.append(mainPanel);
            shopView.uiJpanel.validate();
            mainPanel.addEventListener(MouseEvent.CLICK, mainPanel_click);
            
            var temVec:Vector.<Object> = (shopMdl.get("main") as HashMap).toVector();
            var room:Room;
            for each (var item:ShopItemRoom in temVec) 
            {
                item.shopItemRoomView = new ShopItemRoomView(getAsset("StoreRoomMockup") as Sprite);
                item.shopItemRoomView.title = item.item_name;
                room = roomCatalog.roomCatalogByRommTypeId.get(item.id) as Room;
                item.shopItemRoomView.description = room.decription;
                item.shopItemRoomView.realMoney = room.money_cost.toString();
                item.shopItemRoomView.gameMoney = room.coins_cost.toString();
                item.shopItemRoomView.iconUrl = room.icon_url; 
                item.shopItemRoomView.buyBtn = new SimpleButton(getAsset("PlaceButtonUpArt"), getAsset("PlaceButtonOverArt"), getAsset("PlaceButtonDownArt"), getAsset("PlaceButtonUpArt"));
                item.shopItemRoomView.addChild( item.shopItemRoomView.buyBtn);
                item.shopItemRoomView.buyBtn.x = 200;
                item.shopItemRoomView.buyBtn.y = 425;
                item.shopItemRoomView.buyBtn.addEventListener(MouseEvent.CLICK, buyBtn_click);
                item.shopItemRoomView.id = room.id;
             }
            
            
            
            
            btnGroup.setSelected(operationRoomShopBtn.getModel(), true);
            shopMdl.setCategory(0);
            var tempRoom:ShopItemRoom;
            for (var i:int = 0; i < userRoomlist.toArray().length; i++) 
            {
                trace("_____________");
                trace(userRoomlist.toArray()[i].room_type_id);
                tempRoom = shopMdl.outputMainShop.get(userRoomlist.toArray()[i].room_type_id) as ShopItemRoom;
              //   tempRoom.btnView.setEnabled(true);
                tempRoom.isPurshed = true;
            }
            
            
           var lim:int =  itemCatalog.toArray().length;
           var itemCatalogArr:Array = itemCatalog.toArray();
           
           for (var j:int = 0; j < lim; j++) 
           {
               itemCatalogArr[i].currentUserLevel = expMdl.levelNumer;
           }
        }
        
        private function buyBtn_click(e:MouseEvent):void 
        {
            trace(e.target);
            trace(e.target.parent);
            trace(e.target.parent.id);
            shopMdl.forPurshRoomId = e.target.parent.id as String;
        }
        private function getAsset(value:String):DisplayObject
        {
            return rsl.getAsset("gui.ingame.shop."+value);
        }
        
        private function mainPanel_click(e:MouseEvent):void 
        {
           // clickedSignal.dispatch(e.target.name as String);
            if (e.target is JToggleButton)
            {
                //trace(btnGroup.getSelectedIndex());
                shopMdl.setCategory(btnGroup.getSelectedIndex());
            }
           
            
        }
        
        
    }

}