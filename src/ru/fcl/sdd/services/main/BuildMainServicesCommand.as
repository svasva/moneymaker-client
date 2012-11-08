/**
 * Created with IntelliJ IDEA.
 * User: questa_4
 * Date: 07.11.12
 * Time: 19:32
 * To change this template use File | Settings | File Templates.
 */
package ru.fcl.sdd.services.main
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildMainServicesCommand  extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingletonOf(IServerProxy,ServerProxy);
    }
}
}
