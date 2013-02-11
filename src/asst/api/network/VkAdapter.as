package asst.api.network
{
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	import com.adobe.serialization.json.JSON;
    import ru.fcl.sdd.tools.PrintJSON;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import asst.utils.net.MultipartURLLoader;
	
	public class VkAdapter extends AdapterAbstract implements IAdapter
	{
		
		public static const VK_ALLOW_USER:uint = 1;
		public static const VK_ALLOW_FRIENDS:uint = 2;
		public static const VK_ALLOW_PHOTOS:uint = 4;
		public static const VK_ALLOW_AUDIOS:uint = 8;
		public static const VK_ALLOW_VIDEOS:uint = 16;
		public static const VK_ALLOW_APPS:uint = 32;
		public static const VK_ALLOW_QUESTIONS:uint = 64;
		public static const VK_ALLOW_WIKI:uint = 128;
		public static const VK_ALLOW_FAVORITES:uint = 256;
		public static const VK_ALLOW_WALL:uint = 512;
		public static const VK_ALLOW_STATUS:uint = 1024;
		public static const VK_ALLOW_NOTES:uint = 2048;
		public static const VK_ALLOW_BASE:uint = VK_ALLOW_USER | VK_ALLOW_FRIENDS;
		
		private var _photoUploadStream:ByteArray;
		private var _photoUploadCallback:Function;
		
		private var _streamPublishMsg:String;
		private var _streamPublishToUid:String;
		private var _streamPublishImgUrl:String;
		private var _streamPublishImg:Bitmap;
		private var _streamPostId:String;
		
		public function VkAdapter()
		{}
		
		public function init(callback:Function):void
		{
			if (Config.STAGE == 'live') {
				Vk.init(Config.parameters);
                trace("PRINT JSON");
                PrintJSON.deepTrace(Config.parameters);
				callback();
			} else if (Config.STAGE == 'dev') {
				Vk.init({
					viewer_id: 	Config.VK_DUMMY_VIEWER_ID,
					api_url: 	Config.VK_API_URL,
					api_id:     Config.VK_API_ID
				});
				callback();
			} else {
				throw new Error('Unknown stage');
			}
		}
		
		public function clearCache(method:String):void
		{
			Vk.cacheClear(method);
		}
		
		public function userIsAppUser(callback:Function):void
		{
			Vk.request(Vk.USER_IS_APP_USER, function(data:Object):void {
				callback(parseInt(data.toString()) ? true : false);
			});
		}
		
		public function userGetSettings(callback:Function):void
		{
			Vk.request(Vk.USER_GET_SETTINGS, function(data:Object):void {
				callback(parseInt(data.toString()));
			});
		}
		
		public function userGetBalance(callback:Function):void
		{
			Vk.request(Vk.USER_GET_BALANCE, callback);
		}
		
		public function userGetFriends(callback:Function):void
		{
			Vk.request(Vk.USER_GET_FRIENDS, callback);
		}
		
		public function userGetAppFriends(callback:Function):void
		{
			Vk.request(Vk.USER_GET_APP_FRIENDS, callback);
		}
		
		public function userGetProfiles(callback:Function, uids:Array, cacheClear:Boolean = false):void
		{
			if (cacheClear) {
				Vk.cacheClear(Vk.USER_GET_PROFILES);
			}
			
			Vk.request(Vk.USER_GET_PROFILES, function(data:Object):void {
				if (cacheClear) {
					Vk.cacheClear(Vk.USER_GET_PROFILES);
				}
				callback(data);
			}, {
				fields: 'uid,first_name,last_name,photo,photo_medium,online',
				uids:   uids.join(',')
			});
		}
		
		public function photoGetAlbums(callback:Function):void
		{
			Vk.request(Vk.PHOTOS_GET_ALBUMS, callback);
		}
		
		public function photoCreateAlbum(callback:Function, name:String):void
		{
			Vk.request(Vk.PHOTOS_CREATE_ALBUM, callback, { title: name });
		}
		
		public function photoUpload(callback:Function, stream:ByteArray, aid:String):void
		{
			/*
			1. get upload server
			2. upload raw data
			3. save photo
			*/
			
			_photoUploadStream   = stream;
			_photoUploadCallback = callback;
			
			Vk.request(Vk.PHOTOS_GET_UPLOAD_SERVER, _photoUploadStep1, { aid: aid });
		}
		
		private function _photoUploadStep1(response:Object):void
		{
			var loader:MultipartURLLoader = new MultipartURLLoader();
			loader.addEventListener(Event.COMPLETE, _photoUploadStep2);			
			loader.addFile(_photoUploadStream, 'file.jpg', 'file1', 'image/jpg');
			loader.load(response.upload_url);
		}
		
		private function _photoUploadStep2(e:Event):void
		{
			var params:Object = JSON.decode(e.target.loader.data);
			
			Vk.request(Vk.PHOTOS_SAVE, _photoUploadCallback, {
				aid: 		 params.aid, 
				server: 	 params.server, 
				photos_list: params.photos_list, 
				hash: 		 params.hash
			});
		}
		
		public function dialogPayment(params:Object, callback:Function = null):void
		{
			//Vk.show('showPaymentBox', params.amount);
			Vk.show('showOrderBox', params);
		}
		
		public function dialogInvite():void
		{
			Vk.show('showInviteBox');
		}
		
		public function dialogInstall(callback:Function = null):void
		{
			Vk.show('showInstallBox');
			
			if (callback != null) {
				Vk.addEventListener("onApplicationAdded", callback);
			}
		}
		
		public function streamPublish(title:String, msg:String, imgUrl:String, toUid:String, params:Object = null):void
		{
			/*
			0. download photo
			1. get upload server 
			2. upload photo to server
			3. save post 
			*/
	
			// title param is not used in vk
			_streamPublishMsg    = msg;
			_streamPublishToUid  = toUid != '' ? toUid : Main.viewer_id;
			_streamPublishImgUrl = imgUrl;
			_streamPostId = '';
			if (params) _streamPostId = params.post_id;
			var loader:Loader = new Loader(); 
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _streamPublishStep1);
			loader.load(
				new URLRequest(imgUrl), 
				new LoaderContext(true)
			);
 		}
		
		private function _streamPublishStep1(e:Event):void
		{
			var loader:LoaderInfo = LoaderInfo(e.target);
			_streamPublishImg = Bitmap(loader.content);			
			Vk.request(Vk.WALL_GET_PHOTO_UPLOAD_SERVER, _streamPublishStep2);
		}
		
		private function _streamPublishStep2(response:Object):void
		{
			var loader:MultipartURLLoader = new MultipartURLLoader();
			loader.addEventListener(Event.COMPLETE, _streamPublishStep3);
			
			if (_streamPublishImgUrl.indexOf('.png') > 0) {
				loader.addFile(PNGEncoder.encode(_streamPublishImg.bitmapData), 'photo.png', 'photo');
			} else {
				var jpgEncoder:JPGEncoder = new JPGEncoder(100);
				loader.addFile(jpgEncoder.encode(_streamPublishImg.bitmapData), 'photo.jpg', 'photo');
			}
			
			loader.load(response.upload_url);
		}
		
		private function _streamPublishStep3(e:Event):void
		{
			var loader:MultipartURLLoader = MultipartURLLoader(e.target);
			var data:Object = JSON.decode(loader.loader.data);
			
			Vk.request(Vk.WALL_SAVE_POST, _streamPublishStep4, {
				wall_id: _streamPublishToUid,
				post_id:  _streamPostId,
				server:  data.server, 
				photo:   data.photo, 
				hash:    data.hash, 
				message: _streamPublishMsg
			});
		}
		
		private function _streamPublishStep4(response:Object):void
		{
			//_wrapper.external.saveWallPost(response.post_hash);
			Vk.show("saveWallPost", response.post_hash);
		}
		
		public function streamPublishRaw(title:String, msg:String, imgRaw:Bitmap, toUid:String):void
		{
			// title param is not used in vk
			_streamPublishMsg    = msg;
			_streamPublishToUid  = toUid != '' ? toUid : Main.viewer_id;
			_streamPublishImgUrl = '';
			_streamPublishImg    = imgRaw;
			Vk.request(Vk.PHOTOS_GET_WALL_UPLOAD_SERVER, _streamPublishRawStep2);
		}
		
		public function get envGetShare():String
		{
			return Main.instance.parent.loaderInfo.parameters.post_id;
		}
		
		private function _streamPublishRawStep2(response:Object):void
		{
			var loader:MultipartURLLoader = new MultipartURLLoader();
			var jpgEncoder:JPGEncoder = new JPGEncoder(100);
			
			loader.addEventListener(Event.COMPLETE, _streamPublishRawStep3);
			loader.addFile(jpgEncoder.encode(_streamPublishImg.bitmapData), 'photo.jpg', 'photo');
			loader.load(response.upload_url);
		}
		
		private function _streamPublishRawStep3(e:Event):void
		{
			var loader:MultipartURLLoader = MultipartURLLoader(e.target);
			var data:Object = JSON.decode(loader.loader.data);
			
			Vk.request(Vk.PHOTOS_SAVE_WALL_PHOTO, _streamPublishRawStep4, {
				server:  data.server, 
				photo:   data.photo, 
				hash:    data.hash,
				uid:     _streamPublishToUid
			});
		}
		
		private function _streamPublishRawStep4(response:Object):void
		{
			if (response is Array) {
				response = response[0];
			}
			
			Vk.request(Vk.WALL_POST, _streamPublishRawStep5, {
				owner_id: _streamPublishToUid,
				message:  _streamPublishMsg,
				attachment: response.id
			});
		}
		
		private function _streamPublishRawStep5(response:Object):void
		{
			dispatchEvent(new Event(EVENT_STREAM_PUBLISHED));
		}
		
		public function get envAuthKey():String
		{
			return Config.STAGE == 'live' ? 
				Config.parameters.auth_key :
				Config.parameters.auth_key;
		}
		
		public function get envViewerId():String
		{
			return Config.STAGE == 'live' ? 
				Config.parameters.viewer_id :
				Config.VK_DUMMY_VIEWER_ID.toString();
		}
		
		public function get envRefererId():String
		{
			return Config.STAGE == 'live' ? 
				Config.parameters.user_id :
				'';
		}
		
		public function startupCheck(callback:Function):void
		{
			callback();
		}
	}
}