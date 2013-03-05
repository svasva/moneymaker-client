package ru.fcl.sdd.gui.main.popup 
{
    import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import org.aswing.JButton;
    import org.aswing.JLoadPane;
    import ru.fcl.sdd.config.FlashVarsModel;
	import ru.fcl.sdd.item.Item;
	import ru.fcl.sdd.item.ItemVO;
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
		protected var _reqPane:MovieClip;
		
		protected var _bankRep:MovieClip;
		protected var _bankRepTf:TextField;
		protected var _bankRepCh:MovieClip;
		
		protected var _bankLvl:MovieClip;
		protected var _bankLvlTf:TextField;
		protected var _bankLvlCh:MovieClip;
		
		protected var _reqRoom:MovieClip;
		protected var _reqRoomTf:TextField;
		protected var _reqRoomCh:MovieClip;
		
		protected var _goldPriceIcon:MovieClip;
		protected var _gameNoneyIcon:MovieClip;
       
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
         _yesBtn.setY(274);
         _yesBtn.setX(230);
         _noBtn.setX(395);
         _noBtn.setY(274);
         _bg.addChild(_yesBtn);
         _bg.addChild(_noBtn);
         
         _loadidPanel = new JLoadPane();
         
         _itemNameTf = _bg.getChildByName("itemName") as TextField; 
         _itemDescTf = _bg.getChildByName("itemDesc") as TextField; 
         _goldPriceTf = _bg.getChildByName("goldPriseTf") as TextField; 
         _gamemoneyTf = _bg.getChildByName("gameMoneyPrice") as TextField; 
         _contentSp = _bg.getChildByName("contenSp") as Sprite;
		 _goldPriceIcon = bg.getChildByName("goldPriceIcon") as MovieClip;
		 _gameNoneyIcon = bg.getChildByName("gameNoneyIcon") as MovieClip;
		 
         _goldPriceTf.text = "";
         this.visible = false;
         _contentSp.addChild(_loadidPanel);
         _loadidPanel.setSizeWH(155, 155);         
         _bg.x = app_w / 2 - _bg.width / 2;
         _bg.y = 200;
		 
		 _reqPane =  _bg.getChildByName("reqPane") as MovieClip;
       //  _reqPane.visible = false;
		 _bankRep = _reqPane.getChildByName("bankRep") as MovieClip;
		 _bankRepTf = _bankRep.getChildByName("tf") as TextField;
		 _bankRepCh = _bankRep.getChildByName("check") as MovieClip;
        _bankRepCh.stop();
		
		_bankLvl = _reqPane.getChildByName("bankLvl") as MovieClip;
		_bankLvlTf = _bankLvl.getChildByName("tf") as TextField;
		_bankLvlCh = _bankLvl.getChildByName("check") as MovieClip;
		_bankLvlCh.stop();
		
		_reqRoom = _reqPane.getChildByName("reqRoom") as MovieClip;
		_reqRoomTf = _reqRoom.getChildByName("tf") as TextField;
	//	_reqRoomTf.visible = false;
		_reqRoomCh = _reqRoom.getChildByName("check") as MovieClip;
        _reqRoomCh.stop();
         
        
        }
		public function addData(vo:Item):void
		{
			itemName = vo.item_name;
			itemDesc = vo.description;
			
			if (vo.money_cost)
			{
				_goldPriceTf.text = vo.money_cost;
				_goldPriceTf.visible = true;
				_goldPriceIcon.visible = true;
			}
			else
			{
				_goldPriceTf.visible = false;
				_goldPriceIcon.visible = false;
			}
			if (vo.gameMoneyPrice)
			{
				_gamemoneyTf.text = vo.gameMoneyPrice.toString();
				_gameNoneyIcon.visible = true;
				_gamemoneyTf.visible = true;
			}
			else
			{
				_gameNoneyIcon.visible = false;
				_gamemoneyTf.visible = false;
			}
			if (vo.iconUrl)
			_loadidPanel.load(new URLRequest(vo.iconUrl));
			
			if (vo.reqExp)
			{
				_bankRepTf.text = "Необходимо " + vo.reqExp.toString() + " едениц репутации";
				_bankRep.visible = true;
			}
			else
			{
				_bankRep.visible = false;
			}
			if (vo.requirementLevel)
			{
				_bankLvlTf.text = "Необходим " +vo.requirementLevel.toString() + " уровень банка";
				bankLvl.visible = true;
			}
			else
			{
				bankLvl.visible = false;
			}
			if (vo.reqRoom)
			{
				_reqRoomTf.text = vo.reqRoomName;
				_reqRoom.visible = true;
			}
			else
			{
				_reqRoom.visible = false;
			}
			if (vo.sucssiseLvl)
				_bankLvlCh.gotoAndStop(1);
			else
				_bankLvlCh.gotoAndStop(2);
			
			if (vo.sucssiseRep)
				_bankRepCh.gotoAndStop(1);
			else
				_bankRepCh.gotoAndStop(2);
			
			if (vo.sucssiseRoom)
				_reqRoomCh.gotoAndStop(1);
			else
				_reqRoomCh.gotoAndStop(2);
			
			
		
			
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
		
		public function get bankRep():MovieClip 
		{
			return _bankRep;
		}
		
		public function set bankRep(value:MovieClip):void 
		{
			_bankRep = value;
		}
		
		public function get bankRepTf():TextField 
		{
			return _bankRepTf;
		}
		
		public function set bankRepTf(value:TextField):void 
		{
			_bankRepTf = value;
		}
		
		public function get bankRepCh():MovieClip 
		{
			return _bankRepCh;
		}
		
		public function set bankRepCh(value:MovieClip):void 
		{
			_bankRepCh = value;
		}
		
		public function get bankLvl():MovieClip 
		{
			return _bankLvl;
		}
		
		public function set bankLvl(value:MovieClip):void 
		{
			_bankLvl = value;
		}
		
		public function get bankLvlTf():TextField 
		{
			return _bankLvlTf;
		}
		
		public function set bankLvlTf(value:TextField):void 
		{
			_bankLvlTf = value;
		}
		
		public function get bankLvlCh():MovieClip 
		{
			return _bankLvlCh;
		}
		
		public function set bankLvlCh(value:MovieClip):void 
		{
			_bankLvlCh = value;
		}
		
		public function get reqRoom():MovieClip 
		{
			return _reqRoom;
		}
		
		public function set reqRoom(value:MovieClip):void 
		{
			_reqRoom = value;
		}
		
		public function get reqRoomTf():TextField 
		{
			return _reqRoomTf;
		}
		
		public function set reqRoomTf(value:TextField):void 
		{
			_reqRoomTf = value;
		}
		
		public function get reqRoomCh():MovieClip 
		{
			return _reqRoomCh;
		}
		
		public function set reqRoomCh(value:MovieClip):void 
		{
			_reqRoomCh = value;
		}
        
        
        
    }

}