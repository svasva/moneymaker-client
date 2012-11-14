/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 13:13
 */
package ru.fcl.sdd.scenes
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.ApplicationBound;

import ru.fcl.sdd.scenes.grid.GridScene;

import ru.fcl.sdd.scenes.mainscene.MainIsoScene;

public class BuildScenesCommand extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(MainIsoScene);
        var mainIsoScene:MainIsoScene = injector.getInstance(MainIsoScene);

        injector.mapSingleton(GridScene);
        var gridScene:GridScene = injector.getInstance(GridScene);

        injector.mapSingleton(MainIsoView);
        mediatorMap.mapView(MainIsoView,MainIsoViewMediator);
        var mainIsoView:MainIsoView = injector.getInstance(MainIsoView);
        mainIsoView.clipContent = true;

        mainIsoView.setSize(ApplicationBound.WIDTH,ApplicationBound.HEIGHT);

        mainIsoView.addScene(mainIsoScene);
        mainIsoView.addScene(gridScene);
        gridScene.render();
    }
}
}
