package ru.fcl.sdd.gui
{
    import flash.display.Sprite;
    
    public class GameProgressBar extends Sprite
    {
        
        private var _currValue:int = 0;
        private var barArt:Sprite = null;
        private var barMask:Sprite = new Sprite();
        
        public function GameProgressBar(_barArt:Sprite)
        {
            super();
            
            barArt = _barArt;
            barArt.mask = barMask;
            addChild(barArt);  
            addChild(barMask);
            barMask.x = 10
                    
            barMask.graphics.beginFill(0x000000, 0);
            barMask.graphics.drawRect(00, 0, barArt.width, barArt.height);
        }
        
        
        public function get currValue():int
        {
            return _currValue;
        }
        
        public function set currValue(value:int):void
        {
            _currValue = value;
            trace("currValue",_currValue);
            updateBar();
        }
        
        private function updateBar():void
        {
          barMask.width = _currValue * barArt.width / 100;
        }
    }
}
