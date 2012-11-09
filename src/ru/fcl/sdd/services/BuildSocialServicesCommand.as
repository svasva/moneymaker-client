/**
 * Created with IntelliJ IDEA.
 * User: questa_4
 * Date: 07.11.12
 * Time: 19:32
 * To change this template use File | Settings | File Templates.
 */
package ru.fcl.sdd.services
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.services.social.ISocialNetService;
import ru.fcl.sdd.services.social.VKService;

public class BuildSocialServicesCommand extends SignalCommand
{
    override public function execute():void
    {
        injector.mapSingletonOf(ISocialNetService, VKService);
        injector.getInstance(ISocialNetService);
    }
}
}
