/* $Id: OkAdapter.as 680 2010-11-09 12:41:15Z micanec $ */
package asst.api.network
{
	import com.adobe.serialization.json.JSON;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.net.*;
	import flash.utils.ByteArray;
	
	import asst.api.forticom.ApiCallbackEvent;
	import asst.api.forticom.ForticomAPI;
	import asst.api.forticom.SignUtil;
	import asst.api.network.Ok;
	import asst.utils.net.MultipartURLLoader;


	public class OkAdapter extends AdapterAbstract implements IAdapter
	{
		
		private var _streamPublishParams:Object;
		
		public function OkAdapter()
		{
		}
		
		public function init(callback:Function):void
		{
			if (Config.STAGE == 'live') {
				Ok.init(Main.instance.parent.loaderInfo.parameters);
				ForticomAPI.connection = Main.instance.parent.loaderInfo.parameters['apiconnection'];
				callback();
				
			} else if (Config.STAGE == 'dev') {
				throw new Error('Impossible to use this network in dev env');
			} else {
				throw new Error('Unknown stage');
			}
		}
		
		public function clearCache(method:String):void
		{
			Ok.cacheClear(method);
		}
		
		public function userIsAppUser(callback:Function):void
		{
			callback(Main.instance.parent.loaderInfo.parameters.authorized == '1');
		}
		
		public function userGetSettings(callback:Function):void
		{
			// not implemented yet
			callback(false);
		}
		
		public function userGetBalance(callback:Function):void
		{
			// not implemented yet
			callback(false);
		}
		
		public function userGetFriends(callback:Function):void
		{
			Ok.request(Ok.FRIENDS_GET, function(response:Object):void {
				callback(response);
			});
		}
		
		public function userGetAppFriends(callback:Function):void
		{
			Ok.request(Ok.FRIENDS_GET_APP_USERS, function(response:Object):void {
				callback(response.uids);
			});
		}
		
		public function userGetProfiles(callback:Function, uids:Array, cacheClear:Boolean = false):void
		{
			if (cacheClear) {
				Ok.cacheClear(Ok.USERS_GET_INFO);
			}
			
			//http://dev.odnoklassniki.ru/wiki/display/ok/FAQ+%28In+Russian%29
			Ok.request(Ok.USERS_GET_INFO, function(data:Array):void {
				if (cacheClear) {
					Ok.cacheClear(Ok.USERS_GET_INFO);
				}
				
				if (data != null) {
					for (var i:uint = 0; i < data.length; i++) {
						data[i].photo = data[i].pic_2;
						data[i].photo_big = data[i].pic_4;
					}
				}
				callback(data);
			}, {
				fields: 'uid,first_name,last_name,pic_2,pic_4',
				uids:   uids.join(',')
			});
		}
		
		public function photoGetAlbums(callback:Function):void
		{
			Ok.request(Ok.PHOTO_GET_ALBUMS, function(obj:Object):void{
				callback(obj.albums)}, {count:100});
		}
		
		public function photoCreateAlbum(callback:Function, name:String):void
		{
			Ok.request(Ok.PHOTO_CREATE_ALBUM, function(obj:Object):void{
				var object:Object=new Object();
				object.aid=obj;
				callback(object);
			}, {title: name, type:'public'});
		}
		
		public function photoUpload(callback:Function, stream:ByteArray, aid:String):void
		{
			var loader:MultipartURLLoader=new MultipartURLLoader();
			loader.addFile(stream, 'photo_1.jpg', 'file_1');
			
			var item:Object=new Object();
			item["method"]="photos.upload";
			item["application_key"]=Config.OK_API_KEY;
			item["session_key"]=Ok._config.session_key;
			item["photos"]="["+JSON.encode({})+"]";
			item["aid"]=aid;
			item["Filename"]="photo_1.jpg";
			item["Upload"]="Submit Query";
			SignUtil.applicationKey=Config.OK_API_KEY;
			SignUtil.sessionKey=Ok._config.session_key;
			SignUtil.secretSessionKey=Ok._config.session_secret_key;

			item=SignUtil.signRequest(item);

			delete item["Upload"];
			delete item["Filename"];
			loader.addEventListener(Event.COMPLETE, function (e:Event):void{
				var data:Object=JSON.decode(loader.loader.data);
				callback(data);
			});
			loader.load(Ok._config.api_server + 'fb.do?method=photos.upload&format=JSON&application_key='+Config.OK_API_KEY+'&sig='+item['sig']+'&session_key='+Ok._config.session_key+'&photos='+item['photos']+'&aid='+aid);
		}
		
		public function dialogPayment(params:Object, callback:Function = null):void
		{
			ForticomAPI.showPayment(
				params.name, 
				params.description, 
				params.code,
				params.price,
				null,
				null,
				'ok',
				'true'
				//params.options
			);
			/*
			ForticomAPI.showPayment(
				params.name, 
				params.description, 
				params.code,
				params.price
				//params.options
			);
			*/
		}
		
		public function dialogInvite():void
		{
			ForticomAPI.showInvite();
		}
		
		public function dialogInstall(callback:Function = null):void
		{
//			ForticomAPI.showInstall();
		}
		
		public function streamPublish(title:String, msg:String, imgUrl:String, toUid:String, params:Object = null):void
		{
			ForticomAPI.addEventListener(ApiCallbackEvent.CALL_BACK, _waitForResig);
			
			var links_text:String = 'default';
			var post_id:String = '';
			if (params){
				post_id = params.post_id;
				links_text = params.links_text;
			} 
			
			if (imgUrl.indexOf(Config.STATIC_URL) != -1) {
				imgUrl = imgUrl.split(Config.STATIC_URL)[1];
			}
			_streamPublishParams = {
				method : "stream.publish",
				message: msg,
				format: 'JSON',
				application_key: Config.OK_API_KEY,
				session_key: Ok._config.session_key,
				call_id: Ok.sequence++,
				attachment: JSON.encode({"caption":title,
					"media":[
						{"href":"link","src":imgUrl,"type":"image"}
					]
				}),
				action_links: JSON.encode([
				//	{"text":msg,"href":"param1=value1"},
					{'text': links_text, 'href': post_id}
				])
			};
			_streamPublishParams.sig = Ok.generateSignature(_streamPublishParams);
			
			ForticomAPI.showConfirmation("stream.publish", msg, _streamPublishParams.sig);
		}
		
		private function _waitForResig(event:ApiCallbackEvent):void
		{			
			if (event.result == "ok") {
				_streamPublishParams.resig = event.data;
				Ok.request(Ok.STREAM_PUBLISH, function(data:*):void {
					// welldone
				}, _streamPublishParams, false);
			}
			
			_streamPublishParams = null;
			ForticomAPI.removeEventListener(ApiCallbackEvent.CALL_BACK, _waitForResig);
		}
		
		public function get envAuthKey():String
		{
			var user:String = Config.parameters.logged_user_id;
			var session_key:String = Config.parameters.session_key;
			
			return Config.parameters.auth_sig + '::' + user + session_key;
		}
		
		public function get envViewerId():String
		{
			return Config.STAGE == 'live' ? 
				Main.instance.parent.loaderInfo.parameters.logged_user_id : 
				Config.OK_DUMMY_VIEWER_ID.toString();
		}
		
		public function get envRefererId():String
		{
			return Config.STAGE == 'live' ? 
				Main.instance.parent.loaderInfo.parameters.referer :
				''; 
		}
		
		public function startupCheck(callback:Function):void
		{
			if (Config.STAGE == 'dev') callback();
			
			if (Main.instance.parent.loaderInfo.parameters.authorized != '1') {
				dialogInstall();
			} else {
				callback();
			}
		}
		
		public function get envGetShare():String
		{
			return Main.instance.parent.loaderInfo.parameters.custom_args;
		}
		
		public function streamPublishRaw(title:String, msg:String, imgRaw:Bitmap, toUid:String):void
		{
			
		}
		
	}
}