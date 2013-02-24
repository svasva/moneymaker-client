package social.connector
{
	import social.vo.ErrorVO;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	public class Connector
	{
		private var _onComplete:Function;
		private var _onError:Function;
		
		public function Connector()
		{
		}	
		protected function jsonToArrayCollection(json : Object, itemClass : Class) : Array
		{
			var result : Array = new Array();
			for each (var obj : Object in json)
			{
				result.addItem(new itemClass(obj));
			}
			return result;
		}
		
	}
}