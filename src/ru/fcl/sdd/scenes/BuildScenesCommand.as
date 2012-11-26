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
import ru.fcl.sdd.scenes.grid.PathGrid;
import ru.fcl.sdd.scenes.FloorScene;

public class BuildScenesCommand extends SignalCommand
{
    [Inject]
    public var flashVars:FlashVarsModel;

    [Embed(source="./art/bg.jpg")]
    private var bgArt:Class;

    private var _bg:DisplayObject;
    override public function execute():void
    {
        injector.mapSingleton(FloorScene);
        var mainIsoScene:FloorScene = injector.getInstance(FloorScene);

        injector.mapSingleton(PathGrid);
        var gridScene:PathGrid = injector.getInstance(PathGrid);

        injector.mapSingleton(MainIsoView);
        mediatorMap.mapView(MainIsoView,MainIsoViewMediator);
        var mainIsoView:MainIsoView = injector.getInstance(MainIsoView);
        mainIsoView.clipContent = false;

        _bg = new bgArt() as DisplayObject;
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
