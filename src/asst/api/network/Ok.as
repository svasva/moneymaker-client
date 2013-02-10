package asst.api.network 
{
	
	import com.adobe.crypto.MD5;
	import com.adobe.serialization.json.JSON;
	import com.silin.utils.Alert;
	
	import flash.errors.*;
	import flash.events.*;
	import flash.net.*;
	
	public class Ok
	{
		
		public static var AUTH_LOGIN:String                 = "auth.login";
		public static var AUTH_LOGIN_BY_TOKEN:String        = "auth.loginByToken";
		public static var AUTH_EXPIRE_SESSION:String        = "auth.expireSession";
		public static var FRIENDS_GET:String                = "friends.get";
		public static var FRIENDS_GET_MUTUAL_FRIENDS:String = "friends.getMutualFriends";
		public static var FRIENDS_ARE_FRIENDS:String        = "friends.areFriends";
		public static var FRIENDS_GET_ONLINE:String         = "friends.getOnline";
		public static var FRIENDS_GET_APP_USERS:String      = "friends.getAppUsers";
		public static var FRIENDS_GET_BIRTHDAYS:String      = "friends.getBirthdays";
		public static var USERS_GET_LOGGED_IN_USER:String   = "users.getLoggedInUser";
		public static var USERS_GET_INFO:String             = "users.getInfo";
		public static var USERS_SET_STATUS:String           = "users.setStatus";
		public static var PHOTOS_GET_UPLOA_DURL:String      = "photos.getUploadUrl";
		public static var PHOTOS_UPLOAD:String              = "photos.upload";
		public static var PHOTO_GET_ALBUMS:String			= "photos.getAlbums";
		public static var PHOTO_CREATE_ALBUM:String			= "photos.createAlbum";
		public static var EVENTS_GET_TYPE_INFO:String       = "events.getTypeInfo";
		public static var EVENTS_GET:String                 = "events.get";
		public static var STREAM_PUBLISH:String             = "stream.publish";
	
		public static var _config:Object; //mcn
		private static var _sequence:uint = 0;
		
		private static var _cache:Array = new Array();
		
		public function Ok() 
		{}
		
		public static function init(config:Object):void
		{
			_config = config;
		}
		
		public static function request(method:String, callback:Function = null, options:Object = null, calculateShit:Boolean = true):void
		{
			
			options = (options != null) ? options : new Object();
			callback = (callback != null) ? callback : defaultCompleteEventHandler;
			
			var cache_options:String = MD5.hash(JSON.encode(options));
			if (_cache[method + '-' + cache_options] != null && [FRIENDS_GET_APP_USERS, USERS_GET_INFO, FRIENDS_GET].indexOf(method) > -1) {
				callback(_cache[method + '-' + cache_options]);
				return;
			}
			
			var data:URLVariables = new URLVariables();
			
			data['method']  		= method;
			data['format']  		= "JSON";
			data['application_key'] = Config.OK_API_KEY;
			data['session_key']     = _config.session_key;
			data['call_id']         = _sequence++;

			if (options) {
				for (var i: String in options) {
					data[i] = options[i];
				}
			}
			
			if (calculateShit) data['sig'] = generateSignature(data);
			
			var request:URLRequest = new URLRequest();
			request.url    = _config.api_server + 'fb.do';
			request.method = URLRequestMethod.POST;
			request.data   = data;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, function(e:Event):void {
				defaultErrorEventHandler("Connection error occured");
			});
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function(e:Event):void {
				defaultErrorEventHandler("Security error occured");
			});
			
			loader.addEventListener(Event.COMPLETE, function(e:Event):void {
				var loader:URLLoader = URLLoader(e.target);
				
				if (Config.STAGE == 'dev' && Config.DEBUG) trace(loader.data);
				
				var data:Object = JSON.decode(loader.data);
				if (!(data is String) && data.error) {
					defaultErrorEventHandler(data.error);
				} else {
					_cache[method + '-' + cache_options] = data;
					callback(data);
				}
			});
			
			try {
				loader.load(request);
			} catch (error:Error) {
				defaultErrorEventHandler(error);
			}
		}
		
		/**
		 * @see // http://dev.odnoklassniki.ru/wiki/display/ok/Authentication+and+Authorization
		 * 
		 * В случае если у нас есть session_key, то подписываем запрос переменной session_secret_key из параметров
		 * в другом случае - secret key из настроек приложения.
		 */
		public static function generateSignature(params:Object):String
		{
			var sig:String = "";
			var sortedParams:Array = new Array();
			
			for (var key:String in params) {
				sortedParams.push(key + "=" + params[key]);
			}
			sortedParams.sort();
			
			for (key in sortedParams) {
				sig += sortedParams[key];
			}
			//			Main.instance.txt.appendText('SIG: '+sig +_config.session_secret_key+'\n');
			return MD5.hash(sig + _config.session_secret_key);
		}
		
		private static function defaultErrorEventHandler(event:Object):void
		{
			/*if (event is Error) {
				Alert.message(I18n.main.okError + event.toString());
				if (Config.STAGE == 'dev' && Config.DEBUG) trace(event.message);
			} else {
				Alert.message(I18n.main.okError + event.toString());
			}*/
		}
		
		private static function defaultCompleteEventHandler(result:Object):void
		{}
		
		public static function cacheClear(method:String):void
		{
			if (method != '') {
				_cache[method] = null;
			} else {
				_cache = new Array();
			}
		}
		
		public static function get sequence():uint
		{
			return _sequence;
		}
		
		public static function set sequence(value:uint):void
		{
			_sequence = value;
		}
	}
}