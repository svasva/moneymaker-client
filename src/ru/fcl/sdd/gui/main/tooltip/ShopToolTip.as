package ru.fcl.sdd.gui.main.tooltip 
{
    import flash.display.Sprite;
    import flash.text.TextField;
	import ru.fcl.sdd.gui.main.popup.BuyShopItemDialog;
    import ru.fcl.sdd.rsl.GuiRsl;
	
	/**
     * ...
     * @author atuzov
     */
    public class ShopToolTip extends BuyShopItemDialog 
    {
        private var _titleTf:TextField;
        private var _titleBackSp:Sprite;
        private var _gamemoneySp:Sprite;
        private var _goldPriceSp:Sprite;
        private var _backSp:Sprite;
        
        public function ShopToolTip(rsl:GuiRsl,app_w:int,app_h:int) 
        {
             super(rsl, app_w, app_h);
            noBtn.visible = false;
            yesBtn.visible = false;
            _back.visible = false;
            _bg.y = 0;
             _titleTf = _bg.getChildByName("titleTf") as TextField; 
             _titleTf.visible = false;
             _titleBackSp =  _bg.getChildByName("titleBack") as Sprite; 
             _titleBackSp.visible = false;
             
             _gamemoneySp =  _bg.getChildByName("gameNoneyIcon") as Sprite; 
             _goldPriceSp =  _bg.getChildByName("goldPriceIcon") as Sprite; 
             _backSp =  _bg.getChildByName("backSp") as Sprite; 
             _backSp.height = 190;
             
             //_itemDescTf.y =- 60;
             _itemNameTf.y = 15;
             _itemDescTf.y = 45;
             _contentSp.y  = 20;
             _gamemoneySp.y = 145;
             _gamemoneyTf.y = 149;
             _goldPriceSp.y = 112;
             _goldPriceTf.y = 118;
           
        }
        
    }

}