/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 12:25
 */
package ru.fcl.sdd.services.main.test
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildMainServerTestCommand extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(Send4test);
        injector.getInstance(Send4test);
    }
}
}
