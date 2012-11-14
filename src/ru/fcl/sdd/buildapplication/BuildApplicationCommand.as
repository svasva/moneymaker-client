/**
 * User: Jessie
 * Date: 07.11.12
 * Time: 14:16
  */
package ru.fcl.sdd.buildapplication
{
import ru.fcl.sdd.buildapplication.buildscreen.BuildDisplayCommand;
import ru.fcl.sdd.config.BuildConfigCommand;
import ru.fcl.sdd.log.BuildLoggerCommand;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.scenes.BuildScenesCommand;

import ru.fcl.sdd.services.main.BuildMainServicesCommand;
import ru.fcl.sdd.services.main.test.ConnectSocketServerCommand;
import ru.fcl.sdd.test.BuildDebugConsoleCommand;


public class BuildApplicationCommand extends SignalCommand
{
    override public function execute():void
    {
        commandMap.execute(MapModelsCommand);

        //*******DEBUGGER-LOGGER***************************
        commandMap.execute(BuildDebugConsoleCommand);
        commandMap.execute(BuildLoggerCommand);
        //*******debugger-logger***************************

        //***********CONFIGURE*****************************
        commandMap.execute(BuildConfigCommand);
        //***********configure*****************************

        //******SERVECIES**********************************
        commandMap.execute(BuildMainServicesCommand);
        commandMap.execute(ConnectSocketServerCommand);
        //******servecies**********************************

        //******Display************************************
        commandMap.execute(BuildScenesCommand);
        commandMap.execute(BuildDisplayCommand);
    }
}
}
