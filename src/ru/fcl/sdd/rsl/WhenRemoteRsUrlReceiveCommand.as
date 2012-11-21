/**
 * User: Jessie
 * Date: 21.11.12
 * Time: 13:12
 */
package ru.fcl.sdd.rsl
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.log.ILogger;

public class WhenRemoteRsUrlReceiveCommand extends SignalCommand
{
    [Inject(name="main_interface_rsl_loader")]
    public var rsl:MainInterfaceRsl;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var response:Object;

    override public function execute():void
    {
        var url:String = response.response[0];
        rsl.loadRsl(url);
    }
}
}
