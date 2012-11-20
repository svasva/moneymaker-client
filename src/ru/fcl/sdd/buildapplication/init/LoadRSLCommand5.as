/**
 * User: Jessie
 * Date: 20.11.12
 * Time: 11:45
 */
package ru.fcl.sdd.buildapplication.init
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.rsl.IRslLoader;

public class LoadRSLCommand5 extends SignalCommand
{
    [Inject(name="main_interface_rsl_loader")]
    public var rsl:IRslLoader;
    [Inject]
    public var flashVars:FlashVarsModel;
    [Inject]
    public var logger:ILogger;

    override public function execute():void
    {
        if(flashVars.isLocal)
        {
            logger.log(this,"try load local rsl");
            rsl.loadRsl("library");
        }else
        {
            logger.log(this,"try load remote rsl");
            //TODO: get url remote rsl & load it.
        }
    }
}
}
