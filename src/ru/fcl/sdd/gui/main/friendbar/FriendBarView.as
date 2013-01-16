/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.friendbar
{
import flash.display.Sprite;
import org.aswing.event.InteractiveEvent;
import org.aswing.JButton;
import org.aswing.JToggleButton;

import ru.fcl.sdd.rsl.GuiRsl;

public class FriendBarView extends Sprite
{
    [Inject]
    public var rsl:GuiRsl;

    private var _bg:Sprite;
    
    private var _vis:Boolean;
    
    private var _checkBtn:JToggleButton;
    
    [PostConstruct]
    public function init():void
    {
        _bg = rsl.getFriendBarBarArtInstance;
        this.addChild(_bg);
        _checkBtn = new JToggleButton("Закрыть");
        _checkBtn.width = 100;
        _checkBtn.height = 30;
        addChild(_checkBtn);
    }
    
    
    
    public function get checkBtn():JToggleButton 
    {
        return _checkBtn;
    }
    
    public function set checkBtn(value:JToggleButton):void 
    {
        _checkBtn = value;
    }
    
    public function get vis():Boolean 
    {
        return _vis;
    }
    
    public function set vis(value:Boolean):void 
    {
        _vis = value;
        _bg.visible = _vis;
    }
}
}
