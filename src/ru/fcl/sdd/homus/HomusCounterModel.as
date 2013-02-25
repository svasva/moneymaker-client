package ru.fcl.sdd.homus 
{
	import de.polygonal.ds.HashMap;
	/**
	 * ...
	 * @author 
	 */
	public class HomusCounterModel 
	{
		private var _count:int = 0;
		private var _clientusByTargetKey:HashMap = new HashMap();
		
		
		public function HomusCounterModel() 
		{
			
		}
		
		public function get count():int 
		{
			return _count;
		}
		
		public function set count(value:int):void 
		{
			_count = value;
		}
		
		public function get clientusByTargetKey():HashMap 
		{
			return _clientusByTargetKey;
		}
		
		public function set clientusByTargetKey(value:HashMap):void 
		{
			_clientusByTargetKey = value;
		}
		
	}

}