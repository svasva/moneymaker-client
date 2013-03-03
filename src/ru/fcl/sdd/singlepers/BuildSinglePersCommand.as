/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:01
 */
package ru.fcl.sdd.singlepers
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.gui.info.ShowAddReputationInfoCommand;

public class BuildSinglePersCommand extends SignalCommand
{
    override public function execute():void
    {
		
        injector.mapClass(SinglePersIsoView, SinglePersIsoView);
		injector.mapSingleton(SinglePersList);
		var persList:SinglePersList = injector.getInstance(SinglePersList);
		
    }
}
}
