/**
 * User: Jessie
 * Date: 21.01.13
 * Time: 13:00
 */
package ru.fcl.sdd.gui.info
{
import as3isolib.geom.Pt;

import com.flashdynamix.motion.Tweensy;

import fl.motion.easing.Linear;

import flash.geom.Point;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.gui.info.experience.ExperienceIconView;
import ru.fcl.sdd.homus.ClientusIsoView;
import ru.fcl.sdd.scenes.MainIsoView;

public class ShowAddReputationInfoCommand extends SignalCommand
{
    [Inject]
    public var value:ClientusIsoView;
    [Inject]
    public var infoView:InfoLayerView;
    [Inject]
    public var mainIsoView:MainIsoView;

    override public function execute():void
    {
        var repView:ExperienceIconView = injector.getInstance(ExperienceIconView);
        repView.setValue(value.reputation);
        var isoPt:Pt = new Pt();
        var screenPt:Point = new Point();

        infoView.addChild(repView);
        isoPt.x = value.x;
        isoPt.y = value.y;
        isoPt.z = value.z;
        screenPt = mainIsoView.isoToLocal(isoPt);
        repView.x = screenPt.x-repView.width/2;
        repView.y = screenPt.y-value.height*mainIsoView.currentZoom-repView.height-10;
        //todo: вытащить в конфиг время из твина.
        Tweensy.to(repView,{y:repView.y-100,alpha:0.25},3,Linear.easeNone,0,null,function():void{infoView.removeChild(repView)});
    }
}
}
