package asst.api.network 
{

    import com.adobe.crypto.MD5;
    import com.adobe.serialization.json.JSON;
    import com.silin.utils.Alert;
    
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;
    
    public class Mm
    {


        public static var FRIENDS_GET:String               = "friends.get";
        public static var FRIENDS_GET_APP_USERS:String     = "friends.getAppUsers";
        public static var USERS_GET_INFO:String            = "users.getInfo";
        public static var USERS_IS_APP_USER:String         = "users.isAppUser";
        public static var USERS_HAS_APP_PERMISSION:String  = "users.hasAppPermission";
        public static var PAYMENTS_OPEN_DIALOG:String      = "payments.openDialog";
        public static var STREAM_PUBLISH:String            = "stream.publish";
        public static var NOTIFICATIONS_SEND:String        = "notifications.send";
        public static var WIDGET_SET:String                = "widget.set";
        public static var PHOTOS_GET_ALBUMS:String         = "photos.getAlbums";
		public static var PHOTOS_CREATE_ALBUM:String       = "photos.createAlbum";	
        public static var PHOTOS_GET:String                = "photos.get";
		public static var PHOTOS_UPLOAD:String			   = "photos.upload";
        public static var AUDIOS_GET:String                = "audios.get";
        public static var AUDIOS_LINK_AUDIO:String         = "audios.linkAudio";

    	private static var _config:Object;
    	
		private static var _cache:Array = new Array();

		public function Mm() 
    	{}
    	
    	public static function init(config:Object):void
    	{
    	    _config = config;
    	}
    	
    	public static function request(method:String, callback:Function = null, options:Object = null):void
		{
			
			options = (options != null) ? options : new Object();
     		callback = (callback != null) ? callback : defaultCompleteEventHandler;
    	
			var cache_options:String = MD5.hash(JSON.encode(options));
			if (_cache[method + '-' + cache_options] != null && [FRIENDS_GET_APP_USERS, USERS_GET_INFO, FRIENDS_GET].indexOf(method) > -1) {
				callback(_cache[method + '-' + cache_options]);
				return;
			}
			
        	var data:URLVariables = new URLVariables();
        	
        	data['method']  = method;
        	data['app_id']  = _config.app_id;
            data['uid']     = _config.vid;
            //data['session_key']  = _config.session_key;
        	data['secure']  = "0";
       		//data['ext'] = '1';
        	
			if (options) {
        		for (var i: String in options) {
          			data[i] = options[i];
        		}
      		}
      		
      		data['sig'] = _generateSignature(data);
			
        	var request:URLRequest = new URLRequest();
      		request.url    = Config.MM_API_URL;
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
				
				if (data.error) {
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

    	private static function _generateSignature(params:Object):String
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
      		
      		return MD5.hash(_config.vid + sig + Config.MM_API_SECRET);//Config.MM_API_PRIVATE);
    	}
    	
    	private static function defaultErrorEventHandler(event:Object):void
    	{
			/*if (event is Error) {
				Alert.message(I18n.main.mmError + event.toString());
				if (Config.STAGE == 'dev' && Config.DEBUG) trace(event.message);
			} else {
				Alert.message(I18n.main.mmError + event.toString());
			}*/
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
    }
}