/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 13:02
 */
package ru.fcl.sdd.scenes.bgScene
{
import as3isolib.display.IsoSprite;
import as3isolib.display.scene.IsoScene;
import as3isolib.geom.IsoMath;
import as3isolib.geom.Pt;

import flash.display.DisplayObject;

public class BgIsoScene extends IsoScene
{
    [Embed(source="../art/bg.jpg")]
    private var bgArt:Class;

    private var _bg:DisplayObject;
    private var bgIsoSprite:IsoSprite;

    [PostConstruct]
    public function init():void
    {
        _bg = new bgArt() as DisplayObject;
        bgIsoSprite = new IsoSprite();
        var pt:Pt = new Pt(-2758,-890);
        IsoMath.screenToIso(pt) ;
        bgIsoSprite.moveTo(pt.x,pt.y,0);
        bgIsoSprite.sprites = [_bg];
        this.addChild(bgIsoSprite);
    }
}
}
