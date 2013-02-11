package asst.api.network 
{
	
	import asst.api.vk.APIConnection;
	import asst.api.vk.events.CustomEvent;
	import asst.api.vk.events.IFlashEvent;
	import asst.utils.net.MultipartURLLoader;
	
	import com.adobe.crypto.MD5;
	import com.adobe.serialization.json.JSON;
	import com.silin.utils.Alert;
	
	import flash.errors.*;
	import flash.events.*;
	import flash.net.*;
	
	public class Vk {
    	
    	// Methods
    	// Profile's methods
        public static var USER_IS_APP_USER:String         = "isAppUser";
    	public static var USER_GET_PROFILES:String        = "getProfiles";
    	public static var USER_GET_FRIENDS:String	      = "getFriends";
    	public static var USER_GET_APP_FRIENDS:String     = "getAppFriends";
    	public static var USER_GET_BALANCE:String  		  = "getUserBalance";
    	public static var USER_GET_SETTINGS:String 		  = "getUserSettings";
    	// Photo's methods
    	public static var PHOTOS_GET_ALBUMS:String 		  = "photos.getAlbums";
    	public static var PHOTOS_GET:String   		      = "photos.get";
    	public static var PHOTOS_CREATE_ALBUM:String 	  = "photos.createAlbum";
    	public static var PHOTOS_GET_UPLOAD_SERVER:String = "photos.getUploadServer";
    	public static var PHOTOS_SAVE:String              = "photos.save";
		public static var PHOTOS_GET_WALL_UPLOAD_SERVER:String = 'photos.getWallUploadServer';
		public static var PHOTOS_SAVE_WALL_PHOTO:String   = 'photos.saveWallPhoto';
		
    	// Audio's methods
    	public static var AUDIO_GET:String     			  = "audio.get";
    	public static var AUDIO_GET_UPLOAD_SERVER:String  = "audio.getUploadServer";
    	public static var AUDIO_SAVE:String   			  = "audio.save";
    	public static var AUDIO_SEARCH:String		      = "audio.search";
    	// Unclassified methods
    	public static var GET_VARIABLE:String		      = "getVariable";
    	public static var PUT_VARIABLE:String    		  = "putVariable";
    	public static var GET_VARIABLES:String   		  = "getVariables";
    	public static var GET_MESSAGES:String    		  = "getMessages";
    	public static var SEND_MESSAGE:String    		  = "sendMessage";
    	public static var GET_SERVER_TIME:String 		  = "getServerTime";
    	// wall's methods
    	public static var WALL_GET_PHOTO_UPLOAD_SERVER:String	= "wall.getPhotoUploadServer";
    	public static var WALL_SAVE_POST:String					= "wall.savePost";
		public static var WALL_POST:String				     	= "wall.post";
		
		
    	
		private static var _config:Object;
		private static var _conn:APIConnection = null;
		private static var _cache:Array = new Array();
    
		public function Vk() 
		{}
		
		public static function init(config:Object):void
		{
		    _config = config;
			
			if (Config.STAGE == 'live') {
				_conn = new APIConnection('*', initListeners);
			}
		}
    
		public static function initListeners(e:IFlashEvent): void {
			var VK = e.VK;
			// и зачем я это тут делаю?? хз...
			VK.addEventListener('onLocationChanged', function(e:CustomEvent):void {
				VK.debug(e.params[0]);
			});
		}
		
		public static function request(method:String, callback:Function = null, options:Object = null):void
		{
			options = (options != null) ? options : new Object();
     		callback = (callback != null) ? callback : defaultCompleteEventHandler;
    	
			var cache_options:String = MD5.hash(JSON.encode(options));
			if (_cache[method + '-' + cache_options] != null && [USER_GET_APP_FRIENDS, USER_GET_PROFILES, USER_GET_FRIENDS].indexOf(method) > -1) {
				callback(_cache[method + '-' + cache_options].response);
				return;
			}
			
			if (_conn != null) {
				options.format = 'JSON';
				_conn.api(method, options, function(data:Object):void{
					if (Config.STAGE == 'dev' && Config.DEBUG) trace(data);
					
					//var data:Object = JSON.decode(o);
					
					if (data.hasOwnProperty('error')) {
						defaultErrorEventHandler(data.error);
					} else {
						_cache[method + '-' + cache_options] = new Object();
						_cache[method + '-' + cache_options]['response'] = data.hasOwnProperty('response')? data['response'] : data;
						callback(data.hasOwnProperty('response')? data['response'] : data);
					}
				});
			} else {
				var data:URLVariables = new URLVariables();
				
				var request:URLRequest = new URLRequest();
                trace("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				request.url    = Config.VK_API_URL + '?m=' + method;
                trace("request.url " + request.url);
                trace("request.data" + request.data);
				request.method = URLRequestMethod.POST;
				request.data   = data;
				 trace("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
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
					
					if (data.hasOwnProperty('error')) {
						defaultErrorEventHandler(data.error);
					} else {
						if(!_cache[method + '-' + cache_options])_cache[method + '-' + cache_options] = new Object();
						_cache[method + '-' + cache_options]['response'] = data['response']? data['response'] : data;
						callback(data['response']? data['response'] : data);
					}
				});
				
				try {
					loader.load(request);
				} catch (error:Error) {
					defaultErrorEventHandler(error);
     			}
				/*
 				if (data.hasOwnProperty('error')) {
					defaultErrorEventHandler(data.error);
				} else {
					_cache[method + '-' + cache_options] = new Object();
					_cache[method + '-' + cache_options]['response'] = data;
					callback(data);
				}
				*/
			}

        }

		public static function show(method:String, options:Object = null, callback:Function = null):void
		{
			if (_conn == null) return;
			_conn.callMethod(method, options);
		}
		
		public static function addEventListener(type:String, callback:Function):void
		{
			if (_conn != null)
			_conn.addEventListener(type, function(e:CustomEvent):void {
				if (callback != null) callback();
			});
		}
		
		private static function defaultErrorEventHandler(event:Object):void
		{	
			if (event is Error) {
				Alert.message('error: ' + event.toString());
				if (Config.STAGE == 'dev' && Config.DEBUG) trace(event.message);
			} else {
				Alert.ask(event.error_msg);
			}
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
		
		public static function getApiConnection():APIConnection
		{
			return _conn;
		}
  	}
	

}
