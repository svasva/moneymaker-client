/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 13:13
 */
package ru.fcl.sdd.scenes
{
import as3isolib.geom.IsoMath;
import as3isolib.geom.Pt;

import flash.display.DisplayObject;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.ApplicationBound;
import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.scenes.bgScene.BgIsoScene;
import ru.fcl.sdd.scenes.bgScene.BgIsoScene;

import ru.fcl.sdd.scenes.grid.PathGridScene;

import ru.fcl.sdd.scenes.mainscene.MainIsoScene;

public class BuildScenesCommand extends SignalCommand
{
    [Inject]
    public var flashVars:FlashVarsModel;

    [Embed(source="./art/bg.jpg")]
    private var bgArt:Class;

    private var _bg:DisplayObject;
    override public function execute():void
    {
        injector.mapSingleton(MainIsoScene);
        var mainIsoScene:MainIsoScene = injector.getInstance(MainIsoScene);

//        injector.mapSingleton(BgIsoScene);
//        var bgIsoScene:BgIsoScene = injector.getInstance(BgIsoScene);

        injector.mapSingleton(PathGridScene);
        var gridScene:PathGridScene = injector.getInstance(PathGridScene);

        injector.mapSingleton(MainIsoView);
        mediatorMap.mapView(MainIsoView,MainIsoViewMediator);
        var mainIsoView:MainIsoView = injector.getInstance(MainIsoView);
        mainIsoView.clipContent = true;

        _bg = new bgArt() as DisplayObject;
        mainIsoView.backgroundContainer.addChild(_bg);
        mainIsoView.rangeOfMotionTarget = _bg;

        var pt:Pt = new Pt(-2758,-890);
//        IsoMath.screenToIso(pt) ;
        _bg.x=pt.x;
        _bg.y=pt.y;

        mainIsoView.setSize(flashVars.app_width,flashVars.app_height);

//        mainIsoView.addScene(bgIsoScene);
        mainIsoView.addScene(mainIsoScene);
        mainIsoView.addScene(gridScene);
//        bgIsoScene.render();
        gridScene.render();
    }
}
}
