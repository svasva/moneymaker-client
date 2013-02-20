package social.connector.impl
{
	import flash.events.Event;
	import social.connector.Connector;
	import social.connector.ConnectorType;
	import social.connector.IConnector;
	
	import social.vo.ErrorVO;
	import social.vo.PhotoVO;
	import social.vo.UserVO;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import vk.APIConnection;
	import classes.PNGEncoder;
	import flash.utils.setTimeout;

	public class VKConnector extends Connector implements IConnector
	{
		public static var testMode:Boolean = false;
		
		private var _apiConnector : APIConnection;
		private static const FRIENDS_LOAD_COUNT : int = 1000;
		private var _viewerID:String;
		
		private static const FIELDS:String = "uid,first_name,last_name,nickname,screen_name,sex,bdate,city,country," +
			"timezone,photo,photo_medium,photo_big,has_mobile,rate,contacts,education,online," +
			"counters,relation,can_post,activity,universities,schools,last_seen";
		private static const SHORT_FIELDS : String = "uid,first_name,last_name,photo_medium";
		
		public function VKConnector(flashvars:Object, onComplete : Function, onSetting:Function =null)
		{
			_viewerID = flashvars["viewer_id"];
			_apiConnector = new APIConnection(flashvars);
			setTimeout(onComplete, 1);
			_apiConnector.addEventListener("onSettingsChanged", onSetting);
		}
		
		private function apiConnector_onsettingschanged(e:Object):void 
		{
			trace("e.settings", e);
		}
		
		public function getSettings(onComplete:Function, onError:Function):void
		{
			trace("getUserSettings");	
			request("getUserSettings", { uids:_viewerID }, onError, onComplete);
			
		}
		
		public function getCurrentUser(onComplete:Function, onError:Function):void
		{
				request("users.get", {uids:_viewerID, fields:FIELDS}, onError,
				
				function (obj:Object):void
				{
					var users:Vector.<UserVO> = new Vector.<UserVO>();
							
							for (var i:int = 0; i < obj.length; i++) 
							{
								users.push(new UserVO(ConnectorType.CONNECTOR_VK, obj[i]));
							}
							
							onComplete(users);
				},
				true
			);
		}
		

		public function getShortUsers(userIDs:String, onComplete:Function, onError:Function):void
		{

		}
		public function showSetting():void
		{
			_apiConnector.callMethod("showSettingsBox", 771);
		}

		public function getUserBalance(onComplete:Function, onError:Function):void
		{

		}
		
		public function getFriends(userID:String, offset:uint, count:uint, onComplete:Function, onError:Function):void
		{
			request("friends.getAppUsers", null, onError,function (obj:Object):void
					{
						var ids:Array = new Array();
						
						for (var i:int = 0; i < obj.length; i++) 
						{
							ids.push(obj[i]);
						}
						friends(userID,offset,count,onComplete,onError,ids);
				},
				true
			);			
	
		}
		private function friends(userID:String, offset:uint, count:uint,onComplete:Function,onError:Function,isInstalled:Array):void
		{				
				if (userID == null || userID == "") userID = _viewerID;
				request("friends.get", {uid:userID, fields:FIELDS, count:count, offset:offset}, onError,
					function (obj:Object):void
					{
						var users:Vector.<UserVO> = new Vector.<UserVO>();
						
						for (var i:int = 0; i < obj.length; i++) 
						{
							
							for (var r:int = 0; r<isInstalled.length;r++)
							{
								if (int(obj[i].uid) == int(isInstalled[r]))
								{
									obj[i].installed = 1;
								}
							}
							if (obj[i].installed == null)
							{
								obj[i].installed = 0;
							}
							users.push(new UserVO(ConnectorType.CONNECTOR_VK, obj[i]));
						}						
						onComplete(users);
					},
					true
				);
		}
		
		public function getShortFriends(userID:String, onComplete:Function, onError:Function):void
		{			
			
		}
		
		public function getFriendsAppUsers(onComplete:Function, onError:Function):void
		{
			
		}
		
		public function getAlbums(userID:String, onComplete:Function, onError:Function):void
		{
		}
		
		public function getPhotos(userID:String, albumID:String, onComplete:Function, onError:Function):void
		{
			
		}
		
		public function createAlbum(title:String, onComplete:Function, onError:Function):void
		{

		}
		
		public function uploadPhotoToAlbum(albumID:String, photo:BitmapData, onComplete:Function, onError:Function):void
		{
			
		}
		
		public function uploadPhotoToWall(userID:String, message:String, photo:BitmapData, defaultAlbumName:String, onComplete:Function, onError:Function):void
		{

		}
		
		public function postToWall(userID:String, message:String, onComplete:Function, onError:Function):void
		{
			if (userID == null || userID == "") userID = _viewerID;
			
			request("wall.post", {owner_id:userID, message:message}, onError,
				function (obj:Object):void { onComplete(); });
		}
		
		public function postPhotoToWall(userID:String, message:String, photoID:String, onComplete:Function, onError:Function):void
		{
			
		}
		
		public function sendNotification(message:String, userIDs:Vector.<String>, onComplete:Function, onError:Function):void
		{
			throw new Error("Unsupported method");
		}
		
		public function showInvite(onComplete:Function, onError:Function,userID:String = null):void
		{
			_apiConnector.callMethod("showInviteBox");
		}
		
		public function buyCredits(value:int, onSuccess:Function, onCancel:Function, onError:Function):void
		{
			
		}
		
		public function buyItem(name:String, onSuccess:Function, onCancel:Function, onError:Function):void
		{
			
		}
		
		public function earnCredits(offerID:int, onSuccess:Function, onCancel:Function, onError:Function):void
		{
			
		}
		
		public function get viewerID():String
		{
			return _viewerID;
		}
		
		private function setOrderHandlers(onSuccess:Function, onCancel:Function, onError:Function):void
		{
			var onOrderSuccessFunc:Function;
			var onOrderCancelFunc:Function;
			var onOrderFailFunc:Function;
			
			onOrderSuccessFunc = 
				function (obj:Object):void
				{
					removeOrderHandlers(onOrderSuccessFunc, onOrderCancelFunc, onOrderFailFunc);
					
					onSuccess(obj);
				};
			
			onOrderCancelFunc = 
				function ():void
				{
					removeOrderHandlers(onOrderSuccessFunc, onOrderCancelFunc, onOrderFailFunc);
					
					onCancel();
				};
			
			onOrderFailFunc = 
				function (obj:Object):void
				{
					removeOrderHandlers(onOrderSuccessFunc, onOrderCancelFunc, onOrderFailFunc);
					
					onError(obj);
				};
			
			_apiConnector.addEventListener("onOrderSuccess", onOrderSuccessFunc);
			_apiConnector.addEventListener("onOrderCancel", onOrderCancelFunc);
			_apiConnector.addEventListener("onOrderFail", onOrderFailFunc);
		}
		
		private function removeOrderHandlers(onSuccess:Function, onCancel:Function, onError:Function):void
		{
			_apiConnector.removeEventListener("onOrderSuccess", onSuccess);
			_apiConnector.removeEventListener("onOrderCancel", onCancel);
			_apiConnector.removeEventListener("onOrderFail", onError);
		}

		
		private function request(method:String, params:Object, onError:Function, onComplete:Function, forceDirectApiAccess:Boolean=false):void
		{
			if (testMode)
			{
				if (params)
				{
					params.test_mode = true;
				}
				else
				{
					params = {test_mode:true};
				}
			}
			
			_apiConnector.forceDirectApiAccess(forceDirectApiAccess);
			trace("method", method);
			_apiConnector.api(method, params, onComplete, setErrorFunction(onError));
		}
		
		private function setErrorFunction(onError:Function):Function
		{
			return function (obj:Object):void
				{
				onError(new ErrorVO(ConnectorType.CONNECTOR_VK, obj));
				}
		}
	}
}