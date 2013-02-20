package social.connector.impl
{
	import api.com.odnoklassniki.Odnoklassniki;
	import api.com.odnoklassniki.sdk.events.Events
	import api.com.odnoklassniki.events.ApiServerEvent;
	import api.com.odnoklassniki.events.ApiCallbackEvent;
	import api.com.odnoklassniki.sdk.friends.Friends;
	import api.com.odnoklassniki.sdk.photos.Photos;
	import api.com.odnoklassniki.sdk.stream.Stream;
	import api.com.odnoklassniki.sdk.users.Users;
	
	import social.connector.Connector;
	import social.connector.ConnectorType;
	import social.connector.IConnector;
	
	import social.vo.ErrorVO;
	import social.vo.UserVO;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import classes.PNGEncoder;
	import flash.utils.setTimeout;

	
	public class OKConnector extends Connector implements IConnector
	{
		private var _flashvars:Object;
		private var _user_id : String;
		private var _dataURL:String;
		
		private static const FIELDS:Array = ['uid', 'first_name', 'last_name', 'name', 'gender', 'birthday', 'age', 'locale', 'location',
			'current_status', 'online', 'pic_1', 'pic_2', 'pic_3', 'pic_4', 'url_profile'];
		
		public function OKConnector(flashvars:Object, onComplete : Function)
		{
			_flashvars = flashvars;
			
			_user_id = flashvars['logged_user_id'];			

			Odnoklassniki.addEventListener(ApiServerEvent.CONNECTED, onConnect);
			Odnoklassniki.addEventListener(ApiServerEvent.CONNECTION_ERROR, onErrorConnection);
			
			Odnoklassniki.initialize(_flashvars, _flashvars["ask"]);
			setTimeout(onComplete,1);// Костылёк из за FB который запускается с задержкой
		}
		
		private function onErrorConnection(event:ApiServerEvent):void 
		{

		}
		public function showSetting():void
		{
			
		}
		public function getSettings(onComplete:Function, onError:Function):void
		{
			
		}
		
		private function onConnect(event:ApiServerEvent):void 
		{

		}
		
		public function getCurrentUser(onComplete:Function, onError:Function):void
		{
			Users.getInfo([_user_id], FIELDS, 
					function (obj:Object):void
						{
							if (obj.error_code) onError(new ErrorVO(ConnectorType.CONNECTOR_OK,obj));
							
							var users:Vector.<UserVO> = new Vector.<UserVO>();
							
							for (var i:int = 0; i < obj.length; i++) 
							{
								users.push(new UserVO(ConnectorType.CONNECTOR_OK,obj[i]));
							}
							
							onComplete(users);
						}
					);
		}
		

		public function getFriends(userID:String, offset:uint, count:uint, onComplete:Function, onError:Function):void
		{
			Friends.getAppUsers(function (obj:Object):void
			{
				if (obj.error_code) 
				{
					onError(new ErrorVO(ConnectorType.CONNECTOR_OK,obj));
					return;
				}
				var ids:Array = new Array();
				for each (var t:String in obj.uids)
				{
					ids.push(t);
				}
				friends(userID, offset, count, onComplete, onError,ids as Array);
			}
			);
		}
		private function friends (userID:String, offset:uint, count:uint, onComplete:Function, onError:Function, isInstalled:Array):void
		{
			Friends.get(
				function (obj:Object):void
				{
					if (obj.error_code)
					{ 
						onError(new ErrorVO(ConnectorType.CONNECTOR_OK,obj));
						return;
					}
					
					Users.getInfo(obj as Array, FIELDS, 
						function (obj:Object):void
						{
							if (obj.error_code) onError(new ErrorVO(ConnectorType.CONNECTOR_OK,obj));
							
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
								users.push(new UserVO(ConnectorType.CONNECTOR_OK,obj[i]));
							}
							
							onComplete(users);
						}
					);
				},
				userID
			);
		}
		
				
		public function postToWall(userID:String, message:String, onComplete:Function, onError:Function):void
		{
			if (userID == null || userID == "") userID = _user_id;
	
				Stream.publish(
					"Вы действительно хотите опубликовать запись на стене?"
					, message
					,function(obj : Object) : void
					{
						if (obj.error_code) onError(new ErrorVO(ConnectorType.CONNECTOR_OK, obj));
						
						if (onComplete != null)
						{
							onComplete(obj);
						}
					}
					,userID
					,{caption:message}
				);
		}
		
		
		public function showInvite(onComplete:Function, onError:Function,userID:String = null):void
		{
			Odnoklassniki.showInvite("Hello word");
		}
		
		
		public function get viewerID():String { return null; }
		


	
	}
}