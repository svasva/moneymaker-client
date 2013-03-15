package ru.fcl.sdd.gui.ingame.shop 
{
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.buildapplication.init.InitCompeteCommand;
    import ru.fcl.sdd.services.main.ISender;
    import ru.fcl.sdd.services.main.parser.ParseShopObjectCommand;
	
	/**
     * ...
     * @author atuzov
     */
    public class GetShopObjectCommand extends SignalCommand 
    {
        
        [Inject]
        public var sender:ISender;
        
        override public function execute():void 
        {
              sender.send( { command:"getShopCatalog"}, ParseShopObjectCommand);              
              commandMap.execute(InitCompeteCommand);
              commandMap.execute(GetMarketingCatalog);
        }
        
    }

}