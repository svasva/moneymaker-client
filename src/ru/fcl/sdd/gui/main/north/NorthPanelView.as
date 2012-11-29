/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.north
{
import flash.display.Sprite;

import ru.fcl.sdd.rsl.GuiRsl;


public class NorthPanelView extends Sprite
{
    [Inject]
    public var rsl:GuiRsl;

    private var _bg:Sprite;

    [PostConstruct]
    public function init():void
    {
        _bg = rsl.getUpBarArtInstance;
        this.addChild(_bg);
    }
}
}
