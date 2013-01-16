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
     //   [Inject]
     //   public var logger:ILogger;       
        
        override public function execute():void
        {
        //    logger.log(this,"BuildSharedService");            
            injector.mapSingleton(FriendBarVisServiceUpdatedSignal);
            injector.mapSingletonOf(ISharedService, SharedService);
            trace("  injector.mapSingletonOf(ISharedService, SharedService);");
            injector.mapSingletonOf(ISharedGameDataService, SharedGameDataService);
        
        }
    
    }
}