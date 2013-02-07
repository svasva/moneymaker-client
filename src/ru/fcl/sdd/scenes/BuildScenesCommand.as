/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 13:13
 */
package ru.fcl.sdd.scenes
{
import org.osflash.signals.AboutInt;
import org.osflash.signals.ISignal;
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.item.iso.ItemClickedHndCommand;
import ru.fcl.sdd.item.iso.ItemClickedSignal;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.location.floors.ChangeFloorCommand;
import ru.fcl.sdd.location.floors.CreateFloorsCommand;
import ru.fcl.sdd.scenes.grid.SceneGrid;

public class BuildScenesCommand extends SignalCommand
{
    [Inject]
    public var flashVars:FlashVarsModel;

    override public function execute():void
    {


       
//        var mainIsoScene:Floor1Scene = injector.getInstance(Floor1Scene);

        injector.mapSingleton(SceneGrid);
        var gridScene:SceneGrid = injector.getInstance(SceneGrid);

        injector.mapSingleton(MainIsoView);
//        mediatorMap.mapView(MainIsoView,MainIsoViewMediator); //map in state changer

        var mainIsoView:MainIsoView = injector.getInstance(MainIsoView);
        mainIsoView.clipContent = true;


        mainIsoView.setSize(flashVars.app_width, flashVars.app_height);
//        mainIsoView.addScene(gridScene);
//        gridScene.render();


//        mainIsoView.addScene(mainIsoScene);

    }
}
}
