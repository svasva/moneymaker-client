/**
 * User: Jessie
 * Date: 21.11.12
 * Time: 14:38
 */
package ru.fcl.sdd.gui.main
{
    import com.adobe.air.filesystem.events.FileMonitorEvent;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
	import flash.events.MouseEvent;
    import org.aswing.AssetIcon;
    import org.aswing.Component;
    import org.aswing.Decorator;
    import org.aswing.graphics.Graphics2D;
    import org.aswing.GroundDecorator;
    import org.aswing.Icon;
    import org.aswing.JToggleButton;
    import org.aswing.plaf.DefaultEmptyDecoraterResource;
    import ru.fcl.sdd.config.FlashVarsModel;
    import ru.fcl.sdd.gui.main.dialogs.NewLevelSmallDialog;
    import ru.fcl.sdd.gui.main.popup.BuyShopItemDialog;
    import ru.fcl.sdd.gui.main.popup.CantBuyPopUpDialog;
	import ru.fcl.sdd.gui.main.questwindow.QuestWindowView;
    import ru.fcl.sdd.gui.main.tooltip.ShopToolTip;
	import ru.fcl.sdd.item.ItemVO;
    import ru.fcl.sdd.item.ShopModel;
    import ru.fcl.sdd.rsl.GuiRsl;
     
    public class MainInterfaceView extends Sprite
    {        
        
        [Inject]
        public var rsl:GuiRsl;
        
         [Inject]
        public var flashVars:FlashVarsModel;
        
        private var _friendBarVisBtn:JToggleButton;
      
        private var _popUpDialog:BuyShopItemDialog;
        
        private var _cantBuyDialog:CantBuyPopUpDialog;
        
        private var _shopItemToolTip:ShopToolTip;
        
        private var _buyRoomDialog:BuyShopItemDialog;
        
        private var _itemControl:ItemPanelSp = new ItemPanelSp();
        
        private var _newLevelSmallDialog:NewLevelSmallDialog;
		
		private var _questBtn:JToggleButton;
		
		private var _questWindows:QuestWindowView;
         
        [PostConstruct]
        public function init():void
        {
            _friendBarVisBtn = new JToggleButton();
            _friendBarVisBtn.width = 27;
            _friendBarVisBtn.height = 27;
            _friendBarVisBtn.setX(45);  
            _friendBarVisBtn.setY(690);  
            _friendBarVisBtn.setBackgroundDecorator(new DefaultEmptyDecoraterResource())
            _friendBarVisBtn.setForegroundDecorator(new DefaultEmptyDecoraterResource())
            _friendBarVisBtn.setIcon( new AssetIcon( getAsset("ButtonHideUpArt")));
            _friendBarVisBtn.setPressedIcon( new AssetIcon( getAsset("ButtonHideDownArt")));
            _friendBarVisBtn.setRollOverIcon( new AssetIcon( getAsset("ButtonHideOverArt")));
            _friendBarVisBtn.setSelectedIcon( new AssetIcon( getAsset("ButtonShowUpArt")));
            _friendBarVisBtn.setRollOverSelectedIcon( new AssetIcon( getAsset("ButtonShowOverArt")));
            _friendBarVisBtn.setDisabledIcon( new AssetIcon( getAsset("ButtonHideDisableArt")));
            _friendBarVisBtn.setDisabledSelectedIcon( new AssetIcon( getAsset("ButtonShowNoActiveArt")));
            _friendBarVisBtn.buttonMode = true;
          
            _popUpDialog = new BuyShopItemDialog(rsl,flashVars.app_width,flashVars.app_height);            
            addChild(_popUpDialog);
            
            _cantBuyDialog = new CantBuyPopUpDialog(rsl, flashVars.app_width, flashVars.app_height);
            addChild(_cantBuyDialog);
            
            _shopItemToolTip = new ShopToolTip(rsl, flashVars.app_width, flashVars.app_height);
            addChild(_shopItemToolTip);
            
            _buyRoomDialog = new BuyShopItemDialog(rsl, flashVars.app_width, flashVars.app_height);
          
            _newLevelSmallDialog = new NewLevelSmallDialog(rsl, flashVars.app_width, flashVars.app_height);
			
			_questWindows = new QuestWindowView(rsl, flashVars.app_width, flashVars.app_height);
			addChild(_questWindows);
			
			_questBtn = new JToggleButton("Quest");
			_questBtn.setSizeWH(82, 89);
			addChild(_questBtn);
			_questBtn.x = 20;
			_questBtn.y = 120;   
			_questBtn.buttonMode = true;
		//	_questBtn.setBackgroundDecorator(new DefaultEmptyDecoraterResource());
		//	_questBtn.setForegroundDecorator(new DefaultEmptyDecoraterResource());
		
			
			
        }
		
	
        
        public function get friendBarVisBtn():JToggleButton 
        {
            return _friendBarVisBtn;
        }
        
        public function set friendBarVisBtn(value:JToggleButton):void 
        {
            _friendBarVisBtn = value;
        }
        
        public function get popUpDialog():BuyShopItemDialog 
        {
            return _popUpDialog;
        }
        
        public function set popUpDialog(value:BuyShopItemDialog):void 
        {
            _popUpDialog = value;
        }
        public function get cantBuyDialog():CantBuyPopUpDialog 
        {
            return _cantBuyDialog;
        }
        
        public function set cantBuyDialog(value:CantBuyPopUpDialog):void 
        {
            _cantBuyDialog = value;
        }
        
        public function get shopItemToolTip():ShopToolTip 
        {
            return _shopItemToolTip;
        }
        
        public function set shopItemToolTip(value:ShopToolTip):void 
        {
            _shopItemToolTip = value;
        }
        
        public function get buyRoomDialog():BuyShopItemDialog 
        {
            return _buyRoomDialog;
        }
        
        public function set buyRoomDialog(value:BuyShopItemDialog):void 
        {
            _buyRoomDialog = value;
        }
        
        public function get itemControl():ItemPanelSp 
        {
            return _itemControl;
        }
        
        public function set itemControl(value:ItemPanelSp):void 
        {
            _itemControl = value;
        }
        
        public function get newLevelSmallDialog():NewLevelSmallDialog 
        {
            return _newLevelSmallDialog;
        }
        
        public function set newLevelSmallDialog(value:NewLevelSmallDialog):void 
        {
            _newLevelSmallDialog = value;
        }
		
		public function get questBtn():JToggleButton 
		{
			return _questBtn;
		}
		
		public function set questBtn(value:JToggleButton):void 
		{
			_questBtn = value;
		}
		
		public function get questWindows():QuestWindowView 
		{
			return _questWindows;
		}
		
		public function set questWindows(value:QuestWindowView):void 
		{
			_questWindows = value;
		}
        private function getAsset(value:String):DisplayObject
        {
            return rsl.getAsset("gui.FriendBar."+value);
        }
        private function getAsset1(value:String):DisplayObject
        {
            return rsl.getAsset("gui.ingame.shop."+value);
        }

      
        
    }
}
