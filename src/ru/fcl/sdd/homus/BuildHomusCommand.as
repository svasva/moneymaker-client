/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:01
 */
package ru.fcl.sdd.homus
{
import org.robotlegs.mvcs.SignalCommand;

public class BuildHomusCommand extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingleton(ClientusList);
        injector.mapClass(ClientusIsoView,ClientusIsoView);
        mediatorMap.mapView(ClientusIsoView,ClientusIsoViewMediator);
    }
}
}
