/* $Id: AdapterAbstract.as 597 2010-10-26 12:18:07Z runksvn $ */
package asst.api.network
{
	import flash.events.EventDispatcher;
	
	public class AdapterAbstract extends EventDispatcher
	{
	
		public static const EVENT_STREAM_PUBLISHED:String = 'eventStreamPublished';
		
		public function AdapterAbstract()
		{}
		
	}
	
}