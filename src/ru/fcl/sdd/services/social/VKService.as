package ru.fcl.sdd.services.social 
{
	/**
	 * ...
	 * @author www0z0k
	 */
	import com.adobe.crypto.MD5;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.Dictionary;
	import flash.utils.Timer;	
    import flash.external.ExternalInterface;
	public class VKService implements ISocialNetService 
	{
		private var _inited:Boolean = false;
		private var _uid:String;
		private var _apiURLLoader:URLLoader;
		
		public static const CALL_METHOD:String = 'VK.callMethod';
		public static const API:String = 'VK.api';
		
		public static const FRIENDS_ALL:String = 'friends.get';
		public static const FRIENDS_ONLINE:String = 'friends.getOnline';
		public static const FRIENDS_APP:String = 'friends.getAppUsers';
		
		public static const WALL_POST:String = 'wall.post';
		public static const INVITE:String = 'showInviteBox';
	
		public function VKService() 
		{
			
		}
		
		/* INTERFACE ru.fcl.sdd.services.social.ISocialNetService */
		
		public function init():void
		{
			_uid = uid;
			if (ExternalInterface.available) {
				ExternalInterface.addCallback('responseHandler', responseHandler);
				_inited = true;
			}
		}

		public function wallPost(targetID:String, text:String):void 
		{
			if (!_inited) {
				return;
			}
			call(WALL_POST, targetID, text);
		}
		/**
		 * 
		 * @param	requestType - not so cool to use this kind of params, however:
			 * 0 - all friends
			 * 1 - online friends
			 * 2 - app friends
		 */
		public function friendsGet(requestType:int = 0):void 
		{
			if (!_inited) {
				return;
			}
			switch(requestType) {
				case 0:
					call(FRIENDS_ALL);
				break;
				case 1:
					call(FRIENDS_ONLINE);
				break;
				case 2:
					call(FRIENDS_APP);
				break;
				default:
				//might throw unexpected argument exception here
			}
		}
		
		public function invite():void 
		{
			if (!_inited) {
				return;
			}
			call(INVITE);
		}
		
		public function get inited():Boolean 
		{
			return _inited;
		}
		
		/**@private
		 * 
		 */
		private function call(method:String, ...rest):void
		{
			switch(method) {
				case INVITE:
					ExternalInterface.call(CALL_METHOD, method);
				break;
				case WALL_POST:
					ExternalInterface.call(API, method, {owner_id : rest[0], message : rest[1]});
				break;
				case FRIENDS_ALL:
					ExternalInterface.call(API, method, {fields : 'uid,first_name,last_name,nickname,photo_medium_rec'}, responseHandler);
				break;
				case FRIENDS_ONLINE:
					ExternalInterface.call(API, method, {fields : 'uid,first_name,last_name,nickname,photo_medium_rec'}, responseHandler);
				break;
				case FRIENDS_APP:
					ExternalInterface.call(API, method, {fields : 'uid,first_name,last_name,nickname,photo_medium_rec'}, responseHandler);
				break;
				default:
				//might throw unexpected argument exception here				
			}
		}
		
		private function responseHandler(result:Object):void 
		{
			if (result.error) {
				
			}else {
				
			}
		}
	}
}