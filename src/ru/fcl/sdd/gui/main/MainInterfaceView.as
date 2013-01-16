/**
 * User: Jessie
 * Date: 21.11.12
 * Time: 14:38
 */
package ru.fcl.sdd.gui.main
{
    import com.adobe.air.filesystem.events.FileMonitorEvent;
    import flash.display.Sprite;
    import org.aswing.JToggleButton;
     
    public class MainInterfaceView extends Sprite
    {        
        private var _friendBarVisBtn:JToggleButton;
         
        public function MainInterfaceView():void
        {
            _friendBarVisBtn = new JToggleButton("Закрыть");
            _friendBarVisBtn.width = 100;
            _friendBarVisBtn.height = 30;
            _friendBarVisBtn.setX(10);  
            _friendBarVisBtn.setY(400);  
            addChild(_friendBarVisBtn);
        }
        
        public function get friendBarVisBtn():JToggleButton 
        {
            return _friendBarVisBtn;
        }
        
        public function set friendBarVisBtn(value:JToggleButton):void 
        {
            _friendBarVisBtn = value;
        }
      
        
    }
}
