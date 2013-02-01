package ru.fcl.sdd.gui.main.popup 
{
    import flash.display.DisplayObject;
	import flash.display.Sprite;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import org.aswing.JButton;
    import org.aswing.JLoadPane;
    import ru.fcl.sdd.config.FlashVarsModel;
    import ru.fcl.sdd.rsl.GuiRsl;
	
	/**
     * ...
     * @author atuzov
     */
    public class BuyShopItemDialog extends Sprite 
    {
        
        
        private var _rsl:GuiRsl;
        
        protected var _bg:Sprite;
        private var _yesBtn:JButton;
        private var _noBtn:JButton;
        protected var _itemNameTf:TextField;
        protected var _itemDescTf:TextField;
        protected var _goldPriceTf:TextField;
        protected var _gamemoneyTf:TextField;
        protected var _contentSp:Sprite;
        
        private var _itemName:String;
        private var _itemDesc:String;
        private var _goldPrice:String;
        private var _gameMoneyPrise:String;
        private var _loadidPanel:JLoadPane;
        protected var _back:Sprite;
       
        private var _url:String;
        
         
        
        
        
        public function BuyShopItemDialog(rsl:GuiRsl,app_w:int,app_h:int) 
        {
         
          _rsl = rsl;
          _bg = getAsset1("BuyPopUp") as Sprite;
          _back = new Sprite();
          _back.graphics.beginFill(0x000000, 0.5);
          _back.graphics.drawRect(0, 0,app_w, app_h);
          _back.graphics.endFill();
          addChild(_back);
          addChild(_bg);
          _yesBtn = new JButton("Да");
          _noBtn = new JButton("Нет");
         _yesBtn.setSizeWH(130, 30);
         _noBtn.setSizeWH(130, 30);
         _yesBtn.setY(204);
         _yesBtn.setX(230);
         _noBtn.setX(395);
         _noBtn.setY(204);
         _bg.addChild(_yesBtn);
         _bg.addChild(_noBtn);
         
         _loadidPanel = new JLoadPane();
         
         _itemNameTf = _bg.getChildByName("itemName") as TextField; 
         _itemDescTf = _bg.getChildByName("itemDesc") as TextField; 
         _goldPriceTf = _bg.getChildByName("goldPriseTf") as TextField; 
         _gamemoneyTf = _bg.getChildByName("gameMoneyPrice") as TextField; 
         _contentSp = _bg.getChildByName("contenSp") as Sprite;
         _goldPriceTf.text = "";
         this.visible = false;
         _contentSp.addChild(_loadidPanel);
         _loadidPanel.setSizeWH(155, 155);         
         _bg.x = app_w / 2 - _bg.width / 2;
         _bg.y = 200;
         
        
         
        
        }
        public function show():void
        {
            parent.setChildIndex(this, parent.numChildren -1);
            visible = true;
        }
        public function hide():void
        {
           this.visible = false;
        }
        
        
        private function getAsset1(value:String):DisplayObject
        {
            return _rsl.getAsset("gui.ingame.shop."+value);
        }
        
        public function get itemName():String 
        {
            return _itemName;
        }
        
        public function set itemName(value:String):void 
        {
            _itemName = value;
            _itemNameTf.text = _itemName;
        }
        
        public function get itemDesc():String 
        {
            return _itemDesc;
        }
        
        public function set itemDesc(value:String):void 
        {
            _itemDesc = value;
            _itemDescTf.text = _itemDesc;
        }
        
        public function get goldPrice():String 
        {
            return _goldPrice;
        }
        
        public function set goldPrice(value:String):void 
        {
            _goldPrice = value;
            if(_goldPrice)
            _goldPriceTf.text = _goldPrice;
        }
        
        public function get gameMoneyPrise():String 
        {
            return _gameMoneyPrise;
        }
        
        public function set gameMoneyPrise(value:String):void 
        {
            _gameMoneyPrise = value;
            _gamemoneyTf.text = _gameMoneyPrise;
        }
        
        public function get url():String 
        {
            return _url;
        }
        
        public function set url(value:String):void 
        {
            _url = value;
            _loadidPanel.load(new URLRequest(_url));
        }
        
        public function get bg():Sprite 
        {
            return _bg;
        }
        
        public function set bg(value:Sprite):void 
        {
            _bg = value;
        }
        
        public function get yesBtn():JButton 
        {
            return _yesBtn;
        }
        
        public function set yesBtn(value:JButton):void 
        {
            _yesBtn = value;
        }
        
        public function get noBtn():JButton 
        {
            return _noBtn;
        }
        
        public function set noBtn(value:JButton):void 
        {
            _noBtn = value;
        }
        
        
        
    }

}