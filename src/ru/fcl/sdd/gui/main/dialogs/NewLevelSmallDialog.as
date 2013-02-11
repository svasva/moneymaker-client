package ru.fcl.sdd.gui.main.dialogs 
{
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
	import flash.display.Sprite;
    import flash.text.TextField;
    import ru.fcl.sdd.rsl.GuiRsl;
	
	/**
     * ...
     * @author atuzov
     */
    public class NewLevelSmallDialog extends Sprite 
    {
        
         private var _rsl:GuiRsl;
         private var _bg:Sprite;
         private var _okBtn:MovieClip;
         private var _levelTf:TextField;
        
        public function NewLevelSmallDialog(rsl:GuiRsl,app_w:int,app_h:int) 
        {
               _rsl = rsl;
               _bg = getAsset1("NewLevelSmall") as Sprite;
               addChild(_bg);
               _bg.y = 200;
               _bg.x = 40;
               _okBtn = _bg.getChildByName("okBtn") as MovieClip;
               _levelTf = _bg.getChildByName("levelTf") as TextField;
               _okBtn.buttonMode = true;
        }
         private function getAsset1(value:String):DisplayObject
        {
            return _rsl.getAsset("dialog."+value);
        }
        
        public function get okBtn():MovieClip 
        {
            return _okBtn;
        }
        
        public function set okBtn(value:MovieClip):void 
        {
            _okBtn = value;
        }
        
        public function get levelTf():TextField 
        {
            return _levelTf;
        }
        
        public function set levelTf(value:TextField):void 
        {
            _levelTf = value;
        }
        
    }

}