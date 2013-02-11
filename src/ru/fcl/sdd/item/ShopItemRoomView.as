package ru.fcl.sdd.item 
{
    import de.polygonal.core.fmt.Sprintf;
    import flash.display.DisplayObject;
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
        
       
       
        
    }

}