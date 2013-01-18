/**
 * User: Jessie
 * Date: 17.01.13
 * Time: 17:18
 */
package ru.fcl.sdd.gui.info.icons
{
import flash.display.Sprite;

import ru.fcl.sdd.homus.art.ChargingAnimationArt;

public class Clock extends Sprite
{
    private var _art:ChargingAnimationArt;

    public function Clock()
    {
        _art = new ChargingAnimationArt();
        _art.scaleX=_art.scaleY=0.5;
        this.addChild(_art);
    }

    public function set count(value:int):void
    {
        _art.gotoAndStop(value);
    }
}
}
