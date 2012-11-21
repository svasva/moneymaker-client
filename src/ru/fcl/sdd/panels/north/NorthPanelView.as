/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.panels.north
{
import flash.display.Sprite;

import ru.fcl.sdd.rsl.IRsl;
import ru.fcl.sdd.rsl.MainInterfaceRsl;


public class NorthPanelView extends Sprite
{
    [Inject(name="main_interface_rsl_loader")]
    public var rsl:MainInterfaceRsl;

    private var _bg:Sprite;

    [PostConstruct]
    public function init():void
    {
        _bg = rsl.getBarArtInstance;
        this.addChild(_bg);
    }
}
}
