package ru.fcl.sdd.gui.main.popup 
{
    import flash.text.TextField;
    import ru.fcl.sdd.rsl.GuiRsl;
	/**
     * ...
     * @author atuzov
     */
    public class CantBuyPopUpDialog extends BuyShopItemDialog 
    {
        private var _titleTf:TextField;
        
        public function CantBuyPopUpDialog(rsl:GuiRsl,app_w:int,app_h:int) 
        {
            super(rsl, app_w, app_h);
            yesBtn.visible = false;
            noBtn.setText("добре");
           _titleTf = _bg.getChildByName("titleTf") as TextField; 
            _titleTf.text = "Вы не можете купить этот предмет";
            
        }
        override public function show():void
        {
          //  super.show();
            parent.setChildIndex(this, parent.numChildren -1);
            visible = true;
        }
        
    }

}