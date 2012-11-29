/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.friendbar
{
import flash.display.Sprite;

import ru.fcl.sdd.rsl.GuiRsl;

public class FriendBarView extends Sprite
{
    [Inject]
    public var rsl:GuiRsl;

    private var _bg:Sprite;

    [PostConstruct]
    public function init():void
    {
        _bg = rsl.getFriendBarBarArtInstance;
        this.addChild(_bg);
    }
}
}
