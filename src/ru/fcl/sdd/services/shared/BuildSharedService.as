package ru.fcl.sdd.services.shared
{
   
    import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.log.ILogger;
    
    /**
     * ...
     * @author atuzov
     */
    public class BuildSharedService extends SignalCommand
    {
        override public function execute():void
        {
            injector.mapSingleton(FriendBarVisServiceUpdatedSignal);
            injector.mapSingletonOf(ISharedService, SharedService);
            injector.mapSingletonOf(ISharedGameDataService, SharedGameDataService);
            signalCommandMap.mapSignalClass(FriendBarVisServiceUpdatedSignal, FriendBarVisModelUpdateCommand);
        }
    
    }
}