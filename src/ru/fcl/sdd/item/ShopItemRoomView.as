package ru.fcl.sdd.item 
{
    import de.polygonal.core.fmt.Sprintf;
    import flash.display.DisplayObject;
	import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import org.aswing.JLoadPane;
	import org.aswing.JPanel;
    import org.aswing.plaf.EmptyLayoutUIResourse;
    import ru.fcl.sdd.rsl.GuiRsl;
	
	/**
     * ...
     * @author atuzov
     */
    public class ShopItemRoomView extends JPanel 
    {
        private var _src:Sprite;
        private var _title:String;
        private var _titleTf:TextField;
        private var _description:String;
        private var _descrTf:TextField;
        private var _gameMoney:String;
        private var _gameMoneyTf:TextField;
        private var _realMoney:String;
        private var _realMoneyTf:TextField;
        private var _gameMoneyIconSp:Sprite;
        private var _goldMoneyIcon:Sprite;
        private var _contentSp:Sprite;
        private var _iconUrl:String;
        private var _loadPan:JLoadPane;
        private var _buyBtn:SimpleButton;
        private var _id:String;
		
		protected var _reqPane:MovieClip;
		
		protected var _bankRep:MovieClip;
		protected var _bankRepTf:TextField;
		protected var _bankRepCh:MovieClip;
		
		protected var _bankLvl:MovieClip;
		protected var _bankLvlTf:TextField;
		protected var _bankLvlCh:MovieClip;
		
		protected var _reqRoomMv:MovieClip;
		protected var _reqRoomTf:TextField;
		protected var _reqRoomCh:MovieClip;
		
		private var _requirementLevel:int;	
		private var _currentUserLevel:int;
		private var _reqExp:int=NaN;
		private var _reqRoom:String;
		private var _reqRoomName:String;
		private var _isLock:Boolean = false;
		private var _sucssiseRep:Boolean = false;
		private var _sucssiseLvl:Boolean = false;
		private var _sucssiseRoom:Boolean = false;
        
        
        public function ShopItemRoomView(src:Sprite=null) 
        {
            _src = src;
            if (_src)
            addChild(_src);
            setSizeWH(635, 711);
            setClipMasked(false);
            _titleTf = src.getChildByName("title") as TextField;
            _descrTf = src.getChildByName("desc") as TextField;
            _gameMoneyTf = src.getChildByName("gameMoneyTf") as TextField;
            _realMoneyTf = src.getChildByName("goldMoneyTf") as TextField;
            _gameMoneyIconSp = src.getChildByName("gameMoneyIcon") as Sprite;
            _goldMoneyIcon = src.getChildByName("goldMoneyIcon") as Sprite;
            _contentSp = src.getChildByName("content") as Sprite;   
            _loadPan = new JLoadPane();
           
          
             this.setLayout(new EmptyLayoutUIResourse());
             _loadPan.setLayout(new EmptyLayoutUIResourse());
             this.append(_loadPan);
             _loadPan.setX(40);
             _loadPan.setY(104);
            // _contentSp.addChild(_loadPan);
              _loadPan.setSizeWH(250, 250);
              _loadPan.setClipMasked(false);
              this.addChild(_gameMoneyIconSp);
              this.addChild(_gameMoneyTf);
             
          
              _reqPane =  src.getChildByName("reqPane") as MovieClip;
       //  _reqPane.visible = false;
		 _bankRep = _reqPane.getChildByName("bankRep") as MovieClip;
		 _bankRepTf = _bankRep.getChildByName("tf") as TextField;
		 _bankRepCh = _bankRep.getChildByName("check") as MovieClip;
        _bankRepCh.stop();
		
		_bankLvl = _reqPane.getChildByName("bankLvl") as MovieClip;
		_bankLvlTf = _bankLvl.getChildByName("tf") as TextField;
		_bankLvlCh = _bankLvl.getChildByName("check") as MovieClip;
		_bankLvlCh.stop();
		
		_reqRoomMv = _reqPane.getChildByName("reqRoom") as MovieClip;
		_reqRoomTf = _reqRoomMv.getChildByName("tf") as TextField;
	//	_reqRoomTf.visible = false;
		_reqRoomCh = _reqRoomMv.getChildByName("check") as MovieClip;
        _reqRoomCh.stop();
           
           
         
        }
		public function checkReq():void
		{
				if (_sucssiseLvl)
				_bankLvlCh.gotoAndStop(1);
			else
				_bankLvlCh.gotoAndStop(2);
			
			if (_sucssiseRep)
				_bankRepCh.gotoAndStop(1);
			else
				_bankLvlCh.gotoAndStop(2);
			
			if (_sucssiseRoom)
				_reqRoomCh.gotoAndStop(1);
			else
				_reqRoomCh.gotoAndStop(2);
				
		}
        
        public function get title():String 
        {
            return _title;
        }
        
        public function set title(value:String):void 
        {
            _title = value;
            _titleTf.text = _title;
        }
        
     
        
        public function set gameMoney(value:String):void 
        {
            _gameMoney = value;
            _gameMoneyTf.text = _gameMoney;
        }
        
        public function set realMoney(value:String):void 
        {
            _realMoney = value;
            _realMoneyTf.text =  _realMoney;
        }
        
        public function set iconUrl(value:String):void 
        {
            _iconUrl = value;
           
            _loadPan.load(new URLRequest(_iconUrl));
        }
        
        public function set description(value:String):void 
        {
            _description = value;
            _descrTf.text = _description;
        }
        
        public function get buyBtn():SimpleButton 
        {
            return _buyBtn;
        }
        
        public function set buyBtn(value:SimpleButton):void 
        {
            _buyBtn = value;
        }
        
        public function get id():String 
        {
            return _id;
        }
        
        public function set id(value:String):void 
        {
            _id = value;
        }
		
		public function get requirementLevel():int 
		{
			return _requirementLevel;
		}
		
		public function set requirementLevel(value:int):void 
		{
			_requirementLevel = value;
			if(_requirementLevel)
				_bankLvlTf.text = "Необходим " + _requirementLevel.toString() + " уровень банка";
			else 
				_bankLvl.visible = false;
		}
		
		public function get reqExp():int 
		{
			return _reqExp;
		}
		
		public function set reqExp(value:int):void 
		{
			_reqExp = value;
			if(_reqExp)
				_bankRepTf.text = "Необходимо " + _reqExp.toString() + " едениц репутации";
			else
				_bankRep.visible = false;
			
		}
		
		public function get reqRoom():String 
		{
			return _reqRoom;
		}
		
		public function set reqRoom(value:String):void 
		{
			_reqRoom = value;
		}
		
		public function get reqRoomName():String 
		{
			return _reqRoomName;
		}
		
		public function set reqRoomName(value:String):void 
		{
			_reqRoomName = value;
			_reqRoomTf.text = _reqRoomName;
		}
		
		public function get isLock():Boolean 
		{
			return _isLock;
		}
		
		public function set isLock(value:Boolean):void 
		{
			_isLock = value;
			if (_isLock)
				buyBtn.visible = false;
			else 
				buyBtn.visible = true;
		}
		
		public function get sucssiseRep():Boolean 
		{
			return _sucssiseRep;
		}
		
		public function set sucssiseRep(value:Boolean):void 
		{
			_sucssiseRep = value;
		}
		
		public function get sucssiseLvl():Boolean 
		{
			return _sucssiseLvl;
		}
		
		public function set sucssiseLvl(value:Boolean):void 
		{
			_sucssiseLvl = value;
		}
		
		public function get sucssiseRoom():Boolean 
		{
			return _sucssiseRoom;
		}
		
		public function set sucssiseRoom(value:Boolean):void 
		{
			_sucssiseRoom = value;
		}
        
       
       
        
    }

}