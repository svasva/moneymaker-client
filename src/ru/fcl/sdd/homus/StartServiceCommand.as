package ru.fcl.sdd.homus 
{
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
	 * ...
	 * @author 
	 */
	public class StartServiceCommand extends SignalCommand 
	{
		[Inject]
		public var clientus:ClientusIsoView; 
		
		[Inject]
		public var homusCatalog:HomusCounterModel;
		
		
		override public function execute():void 
		{
			trace("StartServiceCommand");
			trace("idClients "+clientus.localId);
			trace("idClients " + clientus.target.key);
			//проверить
			homusCatalog.clientusByTargetKey.set(clientus.target.key,clientus);
			
		}
		
	}

}