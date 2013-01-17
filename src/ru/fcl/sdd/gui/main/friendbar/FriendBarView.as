/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.friendbar
{
import flash.display.DisplayObject;
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
    
    private var _bgLine:Sprite;
    
    [PostConstruct]
    public function init():void
    {
        _bg = rsl.getFriendBarBarArtInstance;
        _bg.y = 57;
        _bgLine = getAsset("Background") as Sprite;
        _bgLine.y = 230;
        this.addChild(_bgLine);
        this.addChild(_bg);
       
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
    private function getAsset(value:String):DisplayObject
    {
        return rsl.getAsset("gui.FriendBar."+value);
    }

}
}
