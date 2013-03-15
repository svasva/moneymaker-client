package ru.fcl.sdd.gui.ingame.shop 
{
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.buildapplication.init.InitCompeteCommand;
    import ru.fcl.sdd.services.main.ISender;
    import ru.fcl.sdd.services.main.parser.ParseMarketingCommand;
	
	/**
     * ...
     * @author atuzov
     */
    public class GetMarketingCatalog extends SignalCommand 
    {
        [Inject]
        public var sender:ISender;
        
        override public function execute():void 
        {
             sender.send( { command:"getContracts"}, ParseMarketingCommand);
              
             // commandMap.execute(InitCompeteCommand);
        }
        
    }

}