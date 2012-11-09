package ru.fcl.sdd.services.social 
{
	
	/**
	 * ...
	 * @author www0z0k
	 */
	public interface ISocialNetService 
	{
		public function get inited():Boolean;
		public function init(uid:String):void;
		public function wallPost(...rest):void;
		public function friendsGet(...rest):void;
		public function invite():void;
	}
	
}