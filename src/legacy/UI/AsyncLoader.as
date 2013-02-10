//Created by Action Script Viewer - http://www.buraks.com/asv
package legacy.UI 
{
    import flash.display.*;
    import flash.events.*;

    public class AsyncLoader extends Sprite 
    {

        private var clip:Sprite;

        public function AsyncLoader()
        {
            var angle:Number;
            var cx:Number;
            var cy:Number;
            this.clip = new Sprite();
            super();
            mouseChildren = false;
            mouseEnabled = false;
            addChild(this.clip);
            var g:Graphics = this.clip.graphics;
            var i:int;
            while (i < 6) {
                angle = (((2 * Math.PI) / 6) * i);
                cx = (Math.cos(angle) * 13);
                cy = (Math.sin(angle) * 13);
                g.beginFill(10513438, 0.3);
                g.drawEllipse((cx - 6), (cy - 6), 12, 12);
                g.endFill();
                g.beginFill(10513438, 0.6);
                g.drawEllipse((cx - 5), (cy - 5), 10, 10);
                g.endFill();
                i++;
            };
            addEventListener(Event.ENTER_FRAME, this.onEnterFramecb);
        }

        private function onEnterFramecb(e:Event):void
        {
            this.clip.rotation = (this.clip.rotation + 5);
        }

        public function dispose():void
        {
            removeEventListener(Event.ENTER_FRAME, this.onEnterFramecb);
            if (parent){
                parent.removeChild(this);
            };
        }


    }
}//package engine.core.UI 
