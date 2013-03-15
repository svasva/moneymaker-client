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
			
			//проверить
			
				
			
				if (homusCatalog.clientusByTargetKey.hasKey(clientus.target.key))
				{
					homusCatalog.clientusByTargetKey.remap(clientus.target.key,clientus);
				}
				else
				{
					homusCatalog.clientusByTargetKey.set(clientus.target.key,clientus);
				}
			
		}
		
	}

}