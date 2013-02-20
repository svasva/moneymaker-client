package social.connector.impl
{
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
	import flash.globalization.LastOperationStatus;
	import flash.sampler.NewObjectSample;
	import api.com.odnoklassniki.sdk.users.Users;

	public class FBConnector extends Connector implements IConnector
	{
		import com.facebook.graph.Facebook;
		import com.facebook.graph.data.FacebookAuthResponse;
		
		private const APP_ID : String = "441323579270957";
		private const APP_LINK : String ='https://apps.facebook.com/apps_apps_test_eqsof/';
		private const APP_NAME : String ='test';
		
		private const INVITE_MESSAGE : String = "Приглашение";
		
		private var _onComplete : Function;
		
		public var accessToken : String = "AAAGRYacsZAy0BAMTxkP9u67q03ZCt32LJ00FzPjzLxavbyZCOVUFyny8IBycFSajsOp5SqV6pjSdIq9PSmBKus43QXY6GXRJoxKP3h3ajgDdo3cC5da";
		
		private var loggedIn : Boolean = false;
		
		private const FQL_FRIENDS : String = "SELECT uid,online_presence,first_name,is_app_user,pic_square FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me())";
		
		public function FBConnector(onComplete : Function)
		{
			_onComplete = onComplete;
			init();
		}
		
		private function init() : void
		{
			Facebook.init(APP_ID, onInit, {appId: APP_ID}, accessToken);
		}
		
		public function login() : void
		{
			Facebook.login(onLogin, {perms: "read_stream,publish_stream,friends_online_presence"});
		}
	
		private function onLogin(result : Object, fail : Object) : void
		{
			if (checkAuthorization())
			{
				onReady();
			}
			else
			{
				onLoginError();
			}
		}
		public function getSettings(onComplete:Function, onError:Function):void
		{
			
		}
		public function showSetting():void
		{
			
		}
		
		private function checkAuthorization() : Boolean
		{
			loggedIn = false;
			var resp : FacebookAuthResponse = Facebook.getAuthResponse();
			if (resp == null)
			{
				return false;
			}
			else
			{
				if (resp.accessToken == null)
				{
					return false;
				}
				else
				{
					accessToken = resp.accessToken;
					loggedIn = true;
					return true;
				}
			}
		}
		
		private function onInit(result : Object, fail : Object) : void
		{
			if (!checkAuthorization())
			{
				login();
				return;
			}
			onReady();
		}
		
		protected function onReady() : void
		{
			_onComplete();
		}
		
		protected function onLoginError() : void
		{
			// Ошибка инифицлизации
		}
		
		public function getCurrentUser(onComplete:Function, onError:Function):void
		{
			Facebook.api("/me", function (result : Object, fail : Object) : void 
								{
									if (result == null)
									{
										onError(new ErrorVO(ConnectorType.CONNECTOR_FACEBOOK,fail));
									}
									else
									{
										var res : Vector.<UserVO> = new Vector.<UserVO>();
										res.push(new UserVO(ConnectorType.CONNECTOR_FACEBOOK, convertCurrentUser(result)));
										onComplete(res);
									}
								}
								, {fields:"id,first_name,picture.type(normal)"});
		}		
		
		private function convertCurrentUser(user : Object) : Object
		{
			return {uid : user.id, pic_square : user.picture.data.url, first_name : user.first_name, online_presence : "active", is_app_user : true};
		}
		
		private function convertUsers(friends : Object) : Vector.<UserVO>
		{
			var result : Vector.<UserVO> = new Vector.<UserVO>();
			var user : UserVO;
			for each (var o : Object in friends)
			{
				result.push(new UserVO(ConnectorType.CONNECTOR_FACEBOOK,o));
			}
			return result;
		}

		public function getFriends(userID:String, offset:uint, count:uint, onComplete:Function, onError:Function):void
		{
			Facebook.fqlQuery(FQL_FRIENDS, function (result : Object, fail : Object) : void 
								{
									if (result == null)
									{
										onError(new ErrorVO(ConnectorType.CONNECTOR_FACEBOOK,fail));
									}
									else
									{
										onComplete(convertUsers(result));
									}
								});
		}

		public function postToWall(userID:String, message:String, onComplete:Function, onError:Function):void
		{
			Facebook.ui("feed", {
									to: userID,
									link: APP_LINK,
									caption: APP_NAME,
									description: message
								});
		}
		
		public function showInvite(onComplete:Function, onError:Function,userID:String = null):void
		{
			var params : Object = {message : INVITE_MESSAGE};
			if (userID != null)
			{
				params.to = userID;
			}
			Facebook.ui("apprequests", params);
		}
		
		public function get viewerID():String
		{
			return "not supported";
		}
	}
}