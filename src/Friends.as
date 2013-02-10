package
{
	import asst.api.*;
	
	import com.adobe.serialization.json.JSON;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class Friends
	{
		public static const PHOTO_DEFAULT:String = Config.STATIC_URL + 'assets/default.png';
		
		private static var _friends:Object = new Object();
		private static var _top:Object = null;
		private static var _error:int = 0;
		private static var _loading:Boolean = true;
		private static var _listeners:Array = new Array();
		private static var _friendsAll:Object = new Object();
		private static var _callbackAllFriends:Function = null;
		private static var _maxFriends:int = 500;
		
		private static var _totalFriend:uint;
		
		static public function init():void
		{
			_loading = true;		

			SocialClient.adapter.userGetFriends(_onGetFriends);
		}

		static private function _onGetFriends(uids):void
		{			
			if (!(uids is Array)) {
				uids = [];
			}
			
			if (uids.indexOf(Main.viewer_id) < 0) {
				uids.push(Main.viewer_id);
			}
			
			var list:Array = uids as Array;
			
			_totalFriend = list.length;
			
			if (list != null && list.length > _maxFriends) {
				list.splice(_maxFriends-1);
			}
			
			SocialClient.adapter.userGetProfiles(_onGetProfiles, list);
		}
		
		static private function _onGetProfiles(data):void
		{
			if (data == null) {
				_loading = false;
				_error = 1;
				return; 
			}
			
			var f:Array = [];
			for each (var o:Object in data) {
				_friends[o.uid] = o;
				_friends[o.uid]['inGame'] = false;
				_friends[o.uid]['exp'] = Math.round(Math.random()*100);
				_friends[o.uid]['first'] = 0;
				
				if (_friends[o.uid]['is_online'] != null) {
					_friends[o.uid]['online'] = _friends[o.uid]['is_online']
				}
				
				if (o.uid == Main.viewer_id) {
					if (!o.referer_id) {
						if (Config.parameters.referer) {
							o.referer_id = Config.parameters.referer;
						}
						if (Config.social == Config.VKONTAKTE) {
							if (Config.parameters.user_id) {
								o.referer_id = Config.parameters.user_id;
							}
						}
					}
				}
			}
			
			SocialClient.adapter.userGetAppFriends(_onGetAppFriends);
		}
		
		static private function _onGetAppFriends(data:Object):void {
			
			if (_friends[SocialClient.adapter.envViewerId] == null) {
				_friends[SocialClient.adapter.envViewerId] = {};
				_friends[SocialClient.adapter.envViewerId]['first_name'] = 'Я';
			}
			
			_friends[SocialClient.adapter.envViewerId]['inGame'] = true;
			_friends[SocialClient.adapter.envViewerId]['exp'] = 50;
			
			var s:String = '';
			if (Config.NETWORK == SocialClient.NETWORK_OK || Config.social == Config.LOCAL) {
				for each (s in data) {
					_friends[s]['inGame'] = true;
					_friends[s]['exp'] = Math.round(Math.random() * 100);
				}	
			} else {
				for (s in data) {
					_friends[s]['inGame'] = true;
					_friends[s]['exp'] = Math.round(Math.random() * 100);
				}
			}	
			
			var i:int = 1;
			while (_totalFriend < Main.friendPanel.limit) {
				var keyFriend:String = 'friend_'+i;
				_friends[keyFriend] = {};
				_friends[keyFriend]['uin'] 			= i;
				_friends[keyFriend]['first'] 		= i == 1 ? 1 : 0;
				_friends[keyFriend]['inGame'] 		= false
				_friends[keyFriend]['exp'] 			= Math.round(Math.random() * 100);
				_friends[keyFriend]['first_name']	= 'Друг';
				_friends[keyFriend]['online']		= 0;
				i++;
				_totalFriend++;	
			}
			
			//первый из тех кто не играет
			for each (var o:Object in _friends) {
				if (!o.inGame) o.first = 1; 
				break;	
			}
			
			_loading = false;
			
			for each (var func:Object in _listeners) {
				func();
			}
		}
		
		static private function _sortByExp(a:Object, b:Object):Number 
		{
			var aScore:Number = a.exp;
			var bScore:Number = b.exp;
			if(aScore < bScore) {
				return 1;
			} else if(aScore > bScore) {
				return -1;
			} else  {
				return 0;
			}
		}
		
		static public function get friends():Object
		{
			return _friends;
		}

		static public function addListener(callback:Function):void
		{
			if (_loading) {
				_listeners.push(callback);
			} else {
				callback();
			}
		}
		
		static public function info(uid:String):Object
		{
			return _friends[uid]? _friends[uid] : {uid:uid, photo:Friends.PHOTO_DEFAULT};
		}
		
		static public function initAllFriends(callback:Function = null):void
		{
			SocialClient.adapter.userGetFriends(_onGetUnInstFriends);
			_callbackAllFriends = callback;
		}
		
		static private function _onGetUnInstFriends(uids:Object):void
		{
			if (uids == null) {
				uids = [];
			}
			
			if (uids.indexOf(Main.viewer_id) < 0) {
				uids.push(Main.viewer_id);
			}
			
			var list:Array = uids as Array; 
			
			SocialClient.adapter.userGetProfiles(_onGetProfiles1, list);
		}
		
		static private function _onGetProfiles1(uids:Object):void
		{			
			_friendsAll = uids;			
			_callbackAllFriends();
		}
		
		static public function get friendsAll():Object
		{					
			return _friendsAll;
		}
	}
}