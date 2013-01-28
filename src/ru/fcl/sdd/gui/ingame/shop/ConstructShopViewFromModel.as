package ru.fcl.sdd.gui.ingame.shop 
{
    import com.adobe.images.JPGEncoder;
    import de.polygonal.ds.HashMap;
    import flash.display.DisplayObject;
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
    import ru.fcl.sdd.item.ShopItemRoom;
    import ru.fcl.sdd.item.ShopModel;
    import ru.fcl.sdd.rsl.GuiRsl;
	
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
        
        public var pointVector:Vector.<Point>;
        
        override public function execute():void 
        {
          
           var mainPanel:JPanel = new JPanel();
           
        /*   var iconY:Number =72;
           pointVector = new Vector.<Point>;
         
           for (var i:int = 0; i < 9; i++) 
           {
               pointVector.push(new poi)
           }
           
           pointVector[0] = new Point(150);
          */
         
         
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
         //   operationRoomShopBtn.y = 72;
           // operationRoomShopBtn.
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
           // operationRoomShopBtn.setEnabled(false);            
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
           // directorRoomShopBtn.setEnabled(false);            
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
           // seifRoomShopBtn.setEnabled(false);            
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
           // seifRoomShopBtn.setEnabled(false);            
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
           // secureRoomShopBtn.setEnabled(false);            
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
           // secureRoomShopBtn.setEnabled(false);
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
           // encashmentShopBtn.setEnabled(false);
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
           // encashmentShopBtn.setEnabled(false);
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
           // encashmentShopBtn.setEnabled(false);
            mainPanel.append(prShopBtn);
            
            btnGroup.append(operationRoomShopBtn)
            btnGroup.append(directorRoomShopBtn);
            btnGroup.append(bankomatRoomShopBtn);
            btnGroup.append(filialRoomShopBtn);
            btnGroup.append(secureRoomShopBtn);
            btnGroup.append(seifRoomShopBtn);
            
            btnGroup.append(encashmentShopBtn);
            btnGroup.append(prShopBtn);
            btnGroup.append(investShopBtn);
            
            shopView.uiJpanel.append(mainPanel);
            shopView.uiJpanel.validate();
            mainPanel.addEventListener(MouseEvent.CLICK, mainPanel_click);
            
            btnGroup.setSelected(operationRoomShopBtn.getModel(), true);
            shopMdl.setCategory(0);
            
           
           /*for (var i:int = 0; i < shopMain.length; i++) 
           {
              mainShopItem = new JToggleButton(shopMain[i].item_name);
              mainShopItem.name = shopMain[i].id;
              mainShopItem.setSizeWH(40, 40);
              mainShopItem.setX(i * 50);
              mainShopItem.setToolTipText(shopMain[i].desc);
              mainPanel.append(mainShopItem);
              mainPanel.addEventListener(MouseEvent.CLICK, mainPanel_click);
            }s*/
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