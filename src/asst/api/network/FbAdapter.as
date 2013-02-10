/* $Id: FbAdapter.as 680 2010-11-09 12:41:15Z micanec $ */
package asst.api.network
{
	import com.adobe.serialization.json.JSON;
	import com.facebook.graph.Facebook;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import asst.api.network.Fb;
	import asst.utils.net.MultipartURLLoader;

	public class FbAdapter extends AdapterAbstract implements IAdapter
	{
		public function FbAdapter()
		{
		}
		
		public function init(callback:Function):void
		{
			if (Config.STAGE == 'live') {
				Fb.init(Config.FB_API_ID, callback);
				
			} else if (Config.STAGE == 'dev') {
				throw new Error('Impossible to use this network in dev env');
			} else {
				throw new Error('Unknown stage');
			}
		}
		
		public function clearCache(method:String):void
		{
			// todo
			//Fb.cacheClear(method);
		}
		
		public function userIsAppUser(callback:Function):void
		{
			Fb.request(Fb.USERS_IS_APP_USER, function(response:Object):void {
				callback(response == true);
			}, { uid: Main.viewer_id });
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
			Fb.request(Fb.FRIENDS_GET, callback);
		}
		
		public function userGetAppFriends(callback:Function):void
		{
			Fb.request(Fb.FRIENDS_GET_APP_USERS, callback);
		}
		
		public function userGetProfiles(callback:Function, uids:Array, cacheClear:Boolean = false):void
		{
			Fb.fql(
				'SELECT uid, first_name, last_name, pic_square FROM user WHERE uid IN(' + uids.join(',') + ')',
				function(data:Array):void {
					if (data != null) {
						for (var i:uint = 0; i < data.length; i++) {
							data[i].photo = data[i].pic_square;
						}
					}
					callback(data);
				}
			);
		}
		
		public function photoGetAlbums(callback:Function):void
		{
			Fb.request(Fb.PHOTOS_GET_ALBUMS, function(obj:Object):void{
				var album:Object;
				for each(album in obj)
				{
					album.title=album.name;
				}
				callback(obj);
			}, {uid:Main.viewer_id});
		}
		
		public function photoCreateAlbum(callback:Function, name:String):void
		{
			Fb.request(Fb.PHOTOS_CREATE_ALBUM, callback, {name: name, visible: 'everyone'});
		}
		
		public function photoUpload(callback:Function, stream:ByteArray, aid:String):void
		{
			var loader:MultipartURLLoader=new MultipartURLLoader();
			loader.addFile(stream, 'file.jpg', 'file1', 'image/jpg');
			loader.addVariable('message', 'photo discription');
			loader.addEventListener(Event.COMPLETE, function(e:Event):void{
				var object:Object=JSON.decode(loader.loader.data);
				callback(object);
			});
			loader.load('https://graph.facebook.com/'+aid+'/photos?access_token='+Facebook.getAuthResponse().accessToken);
		}
		
		public function dialogPayment(params:Object, callback:Function = null):void
		{
			Fb.ui('pay', callback, {
				action: 'buy_item',
				order_info: {code:params['code']},
				dev_purchase_params: {'oscif': true}
			});
		}
		
		public function dialogInvite():void
		{
			Fb.ui('apprequests', null, {
				title: 'title',
				message: 'message'
			});
		}
		
		public function dialogInstall(callback:Function = null):void
		{
			
		}
		
		public function streamPublish(title:String, msg:String, imgUrl:String, toUid:String, params:Object = null):void
		{
			Fb.request('/'+toUid+'/feed', function(obj:Object):void{}, {caption:title, message:msg, picture:imgUrl});
		}
		
		public function get envAuthKey():String
		{
			return Main.instance.parent.loaderInfo.parameters.auth_key;
		}
		
		public function get envViewerId():String
		{
			return Main.instance.parent.loaderInfo.parameters.uid;
		}
		
		public function get envRefererId():String
		{
			return Config.STAGE == 'live' ? 
				'' :
				''; 
		}
		
		public function startupCheck(callback:Function):void
		{
			callback();
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