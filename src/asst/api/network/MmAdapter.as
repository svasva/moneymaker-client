/* $Id: MmAdapter.as 739 2011-03-10 14:05:25Z alexsvn $ */
package asst.api.network
{
	import com.adobe.serialization.json.JSON;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import asst.api.SocialClient;
	import asst.api.mailru.MailruCall;
	import asst.api.mailru.MailruCallEvent;
	import asst.api.network.Mm;
	import asst.utils.net.MultipartURLLoader;

	public class MmAdapter extends AdapterAbstract implements IAdapter
	{
		private var _photoAlbumCreatedCallback:Function;
		private var _envGetShare:String;

		private var _arrProfiles:Array;
		private var _lenProfiles:int;
		
		public function MmAdapter()
		{}
		
		public function init(callback:Function):void
		{
			if (Config.STAGE == 'live') {
				Mm.init(Config.parameters);
				
				var timer:Timer = new Timer(3000, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(event:TimerEvent):void {
					SocialClient.forceInit = true;
					callback();
				});
				timer.start();
				
				// Первый параметр - это идентификатор DOM-элемента, вставляющего ваше flash-приложение на страницу.  
				// id и name этого DOM-элента должны совпадать.
				MailruCall.init('game', Config.MM_API_SECRET);
				MailruCall.addEventListener(Event.COMPLETE, function(event:Event):void {
					trace('Mail.ru API ready');
					timer.stop();
					MailruCall.addEventListener ( 'app.readHash', readHashHandler);
					MailruCall.exec ( 'mailru.app.utils.hash.read', null);
					callback();
				});
				
			} else if (Config.STAGE == 'dev') {
				Mm.init({
					vid:    Config.MM_DUMMY_VIEWER_ID,
					uid:    Config.MM_DUMMY_VIEWER_ID,
					app_id: Config.MM_API_ID
				}); 
				callback();
				
			} else {
				throw new Error('Unknown stage');
			}
		}
		
		private function readHashHandler( hash : Object ) : void 
		{
			try{
				if(hash.data!=null){
					var hd:Object=hash.data;
					_envGetShare = hd['post_id'];
				}
			}
			catch(e:Error)
			{
				//----
			}
		}
		
		public function clearCache(method:String):void
		{
			Mm.cacheClear(method);
		}
		
		public function userIsAppUser(callback:Function):void
		{
			Mm.request(Mm.USERS_IS_APP_USER, function(data:Object):void {
				callback(parseInt(data.isAppUser.toString()) ? true : false);
			});
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
			Mm.request(Mm.FRIENDS_GET, callback);
		}
		
		public function userGetAppFriends(callback:Function):void
		{
			Mm.request(Mm.FRIENDS_GET_APP_USERS, callback);
		}
		
		public function userGetProfiles(callback:Function, uids:Array, cacheClear:Boolean = false):void
		{
			if (cacheClear) {
				Mm.cacheClear(Mm.USERS_GET_INFO);
			}
			
			/*if (uids.length > 200) {
				uids = uids.slice(0, 200);
			}*/
			_arrProfiles = new Array();
			_lenProfiles = uids.length;
			var j:int = 0;
			var muid:Array = new Array();
			var k:int = 200;			
			while (uids.length>0)
			{				
				muid = uids.splice(0,k);						
				Mm.request(Mm.USERS_GET_INFO, function(data:Array):void {
					if (cacheClear) {
						Mm.cacheClear(Mm.USERS_GET_INFO);
					}
					
					if (data != null) {
						for (var i:uint = 0; i < data.length; i++) {
							data[i].photo = data[i].pic_small;
							_arrProfiles.push(data[i]);
						}
					}
					if (_arrProfiles.length == _lenProfiles)
						callback(_arrProfiles);
				}, {
					uids: muid.join(',')
				});
			}	
		}
		
		public function photoGetAlbums(callback:Function):void
		{
			Mm.request(Mm.PHOTOS_GET_ALBUMS, callback);			
		}
		
		public function photoCreateAlbum(callback:Function, name:String):void
		{
			MailruCall.exec('mailru.common.photos.createAlbum', callback, {name: name});
			_photoAlbumCreatedCallback=callback;
			MailruCall.addEventListener(MailruCallEvent.ALBUM_CREATED, _photoAlbumCreated);
		}
		
		private function _photoAlbumCreated(e:Object):void
		{
			_photoAlbumCreatedCallback(e.data);
			MailruCall.removeEventListener(MailruCallEvent.ALBUM_CREATED, _photoAlbumCreated);
		}
		
		public function photoUpload(callback:Function, stream:ByteArray, aid:String):void
		{
			var loader:MultipartURLLoader=new MultipartURLLoader();
			loader.addEventListener(Event.COMPLETE, _photoUploadStep2);
			loader.addVariable('aid', aid);
			loader.addFile(stream, 'photo1.jpg', 'photo', 'image/jpg');
			loader.load(Config.SERVER_DOMAIN+'mru_photo.php');
		}
		
		
		public function _photoUploadStep2(e:Event):void
		{
			var params:Object = JSON.decode(e.target.loader.data);
			MailruCall.exec('mailru.common.photos.upload', function(response:Object):void{}, {aid:params.aid, url:params.filename});
		}
		
		public function dialogPayment(params:Object, callback:Function = null):void
		{
		/*	MailruCall.exec('mailru.app.payments.showDialog', function(response:Object):void {}, {
				service_id:   params['code'], 
				service_name: params['bonus'] < 0? params['out'] : (params['out'] + params['bonus']) + ' ' + NumberCase.apply(params['out'] + params['bonus'], ['монету', 'монеты', 'монет']),
				mailiki_price: params['in']
			});*/
		}
		
		public function dialogInvite():void
		{
			MailruCall.exec('mailru.app.friends.invite', function(response:Object):void {});
		}
		
		public function dialogInstall(callback:Function = null):void
		{
			MailruCall.exec('mailru.app.users.requireInstallation', callback);
		}
		
		public function streamPublish(title:String, msg:String, imgUrl:String, toUid:String, params:Object = null):void
		{
			var links_text:String = 'default';
			var post_id:String = '';
			if (params){
				post_id = params.post_id;
				links_text = params.links_text;
			} 
			MailruCall.exec('mailru.common.stream.publish', function(response:Object):void {}, {
				title: 		    title,
				text: 	  		msg,
				img_url:  		imgUrl,
				
				action_links: 	[
					//{'text': 'заголовок ссылки 1', 'href': 'http://example.com/test1'},
					{'text': links_text, 'href': 'post_id='+post_id} 
				]
				
			});
		}
		
		
		public function get envGetShare():String
		{
			return _envGetShare;
		}
		
		public function streamPublishRaw(title:String, msg:String, imgRaw:Bitmap, toUid:String):void
		{
			
		}
		
		public function get envAuthKey():String
		{
			return Config.parameters.authentication_key;
		}
		
		public function get envViewerId():String
		{
			return Config.STAGE == 'live' ? 
				Config.parameters.vid :
				Config.MM_DUMMY_VIEWER_ID.toString();
		}
		
		public function get envRefererId():String
		{
			return Config.STAGE == 'live' ? 
				'' :
				''; 
		}
		
		public function startupCheck(callback:Function):void
		{
			if (Config.parameters.is_app_user == null) {
				dialogInstall(callback);
/*				
				if (SocialClient.forceInit) {
					Screens.showModalScreen(Screens.SCREEN_MESSAGE, { 
						message: 	     'Добавьте приложение себе и разрешите ему все действия',
						withoutControls: true
					});
				} else {
					callback();
				}
*/				
			} else {
				callback();
			}
		}
		
	}
}