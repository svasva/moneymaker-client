/**
 * User: Jessie
 * Date: 17.01.13
 * Time: 14:10
 */
package ru.fcl.sdd.gui.info
{
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.gui.main.popup.WindowsLayerView;

import ru.fcl.sdd.gui.info.experience.ExperienceIconView;

public class BuildInfoViewCommand extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(InfoLayerView);
        mediatorMap.mapView(InfoLayerView,InfoLayerViewMediator);
        injector.mapClass(ExperienceIconView, ExperienceIconView);
        injector.mapSingleton(WindowsLayerView);
    }
}
}
