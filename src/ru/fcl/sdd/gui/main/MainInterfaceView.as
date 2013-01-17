/**
 * User: Jessie
 * Date: 21.11.12
 * Time: 14:38
 */
package ru.fcl.sdd.gui.main
{
    import com.adobe.air.filesystem.events.FileMonitorEvent;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import org.aswing.AssetIcon;
    import org.aswing.Component;
    import org.aswing.Decorator;
    import org.aswing.graphics.Graphics2D;
    import org.aswing.GroundDecorator;
    import org.aswing.Icon;
    import org.aswing.JToggleButton;
    import org.aswing.plaf.DefaultEmptyDecoraterResource;
    import ru.fcl.sdd.rsl.GuiRsl;
     
    public class MainInterfaceView extends Sprite
    {        
        
        [Inject]
        public var rsl:GuiRsl;
        
        private var _friendBarVisBtn:JToggleButton;
         
        [PostConstruct]
        public function init():void
        {
            _friendBarVisBtn = new JToggleButton();
            _friendBarVisBtn.width = 27;
            _friendBarVisBtn.height = 27;
            _friendBarVisBtn.setX(45);  
            _friendBarVisBtn.setY(690);  
            _friendBarVisBtn.setBackgroundDecorator(new DefaultEmptyDecoraterResource())
            _friendBarVisBtn.setForegroundDecorator(new DefaultEmptyDecoraterResource())
            _friendBarVisBtn.setIcon( new AssetIcon( getAsset("ButtonHideUpArt")));
            _friendBarVisBtn.setPressedIcon( new AssetIcon( getAsset("ButtonHideDownArt")));
            _friendBarVisBtn.setRollOverIcon( new AssetIcon( getAsset("ButtonHideOverArt")));
            _friendBarVisBtn.setSelectedIcon( new AssetIcon( getAsset("ButtonShowUpArt")));
            _friendBarVisBtn.setRollOverSelectedIcon( new AssetIcon( getAsset("ButtonShowOverArt")));
            _friendBarVisBtn.setDisabledIcon( new AssetIcon( getAsset("ButtonHideDisableArt")));
            _friendBarVisBtn.setDisabledSelectedIcon( new AssetIcon( getAsset("ButtonShowNoActiveArt")));
            _friendBarVisBtn.buttonMode = true
            
        }
        
        public function get friendBarVisBtn():JToggleButton 
        {
            return _friendBarVisBtn;
        }
        
        public function set friendBarVisBtn(value:JToggleButton):void 
        {
            _friendBarVisBtn = value;
        }
         private function getAsset(value:String):DisplayObject
        {
            return rsl.getAsset("gui.FriendBar."+value);
        }

      
        
    }
}
