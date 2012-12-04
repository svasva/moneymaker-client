/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 13:13
 */
package ru.fcl.sdd.scenes
{
import as3isolib.geom.Pt;

import flash.display.DisplayObject;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.scenes.grid.SceneGrid;
import ru.fcl.sdd.scenes.FloorScene;

public class BuildScenesCommand extends SignalCommand
{
    [Inject]
    public var flashVars:FlashVarsModel;

//    [Embed(source="./art/bg.jpg")]
    [Embed(source="./art/1st-floor.jpg")]
    private var bgArt:Class;

    private var _bg:DisplayObject;
    override public function execute():void
    {
        injector.mapSingleton(FloorScene);
        var mainIsoScene:FloorScene = injector.getInstance(FloorScene);

        injector.mapSingleton(SceneGrid);
        var gridScene:SceneGrid = injector.getInstance(SceneGrid);

        injector.mapSingleton(MainIsoView);
        mediatorMap.mapView(MainIsoView,MainIsoViewMediator);
        var mainIsoView:MainIsoView = injector.getInstance(MainIsoView);
        mainIsoView.clipContent = true;

        _bg = new bgArt() as DisplayObject;
        _bg.width = 4621;
        _bg.height = 3093;
        mainIsoView.backgroundContainer.addChild(_bg);
        mainIsoView.rangeOfMotionTarget = _bg;

        var pt:Pt = new Pt(-2758,-890);
        _bg.x=pt.x;
        _bg.y=pt.y;

        mainIsoView.setSize(flashVars.app_width,flashVars.app_height);

        mainIsoView.addScene(mainIsoScene);
        mainIsoView.addScene(gridScene);
        gridScene.render();
    }
}
}
