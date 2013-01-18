package ru.fcl.sdd.gui
{
    import flash.display.Sprite;
    
    public class GameProgressBar extends Sprite
    {
        private var _maxValue:int = 1;
        private var _currValue:int = 0;
        private var barArt:Sprite = null;
        private var barMask:Sprite = new Sprite();
        
        public function GameProgressBar(_barArt:Sprite)
        {
            super();
            
            barArt = _barArt;
            barArt.mask = barMask;
            addChild(barMask);
            addChild(barArt);
        }
        
        public function get maxValue():int
        {
            return _maxValue;
        }
        
        public function set maxValue(value:int):void
        {
            _maxValue = value;
            updateBar();
        }
        
        public function get currValue():int
        {
            return _currValue;
        }
        
        public function set currValue(value:int):void
        {
            _currValue = value;
            updateBar();
        }
        
        private function updateBar():void
        {
            barMask.graphics.clear();
            if (_maxValue == 0 )
                return;
            
            var maskWidth:Number = (Math.min(_maxValue, _currValue) / _maxValue) * barArt.width;
            barMask.graphics.beginFill(0x000000, 0);
            barMask.graphics.drawRect(0, 0, maskWidth, barArt.height);
        }
    }
}