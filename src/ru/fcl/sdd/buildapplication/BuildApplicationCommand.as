/**
 * User: Jessie
 * Date: 07.11.12
 * Time: 14:16
  */
package ru.fcl.sdd.buildapplication
{
import ru.fcl.sdd.buildapplication.buildscreen.BuildDisplayCommand;
import ru.fcl.sdd.buildapplication.init.InitialiseServerCommand_1;
import ru.fcl.sdd.buildapplication.MapModelsCommand_0;
import ru.fcl.sdd.config.BuildConfigCommand;
import ru.fcl.sdd.error.BuildErrorHandlers;
import ru.fcl.sdd.log.BuildLoggerCommand;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.gui.main.BuildMainGUICommand;

import ru.fcl.sdd.rsl.BuildRslCommand;

import ru.fcl.sdd.scenes.BuildScenesCommand;
import ru.fcl.sdd.services.main.BuildMainServicesCommand;

import ru.fcl.sdd.test.BuildDebugConsoleCommand;


public class BuildApplicationCommand extends SignalCommand
{
    override public function execute():void
    {


        commandMap.execute(MapModelsCommand_0);

        //***********CONFIGURE*****************************
        commandMap.execute(BuildConfigCommand);
        //***********configure*****************************

        //*******DEBUGGER-LOGGER***************************
        commandMap.execute(BuildDebugConsoleCommand);
        commandMap.execute(BuildLoggerCommand);
        //*******debugger-logger***************************

        //******ERROR-HANDLERS*****************************
        commandMap.execute(BuildErrorHandlers);
        //******error-handlers*****************************

        //*******SERVICES**********************************
        commandMap.execute(BuildMainServicesCommand);
        //*******services**********************************

        //*******RSL***************************************
        commandMap.execute(BuildRslCommand);
        //*******rsl***************************************

        //**************DISPLAY****************************
        commandMap.execute(BuildScenesCommand);

        //**************display****************************

        //*************INITIALISE**************************
        commandMap.execute(InitialiseServerCommand_1);
        //*************initialise**************************

    }
}
}
