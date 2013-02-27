package ru.fcl.sdd.services.main.parser 
{
	import org.robotlegs.mvcs.SignalCommand;
	import ru.fcl.sdd.homus.ClientusIsoView;
	import ru.fcl.sdd.homus.HomusCounterModel;
	import ru.fcl.sdd.tools.PrintJSON;
	
	/**
	 * ...
	 * @author 
	 */
	public class ParseItemStateCommand extends SignalCommand 
	{
		[Inject]
		public var response:Object;	
		
		[Inject]
		public var homusMdl:HomusCounterModel;
		
		private var clientus:ClientusIsoView;
		
		private var key:String;
		
		override public function execute():void 
        {
			//trace("ParseItemStateCommand");
			PrintJSON.deepTrace(response);
		
			if (response.response.no_service)
			{
				key = new String( response.response.item_id );
				
				clientus =  homusMdl.clientusByTargetKey.get(key) as ClientusIsoView;
				if (clientus)
				{
					clientus.noService();
				}
			 
			}
			
		}
		
	}

}