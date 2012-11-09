package ru.fcl.sdd.services.social 
{
	
	/**
	 * ...
	 * @author www0z0k
	 */
	public interface ISocialNetService 
	{
		function get inited():Boolean;
		function init():void;
		function wallPost(targetID:String, text:String):void;
		function friendsGet(requestType:int):void;
		function invite():void;
	}
	
}