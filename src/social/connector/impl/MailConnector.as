package social.connector.impl
{
	import social.connector.Connector;
	import social.connector.ConnectorType;
	import social.connector.IConnector;
	import social.vo.UserVO;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.system.Security;
	
	import mailru.MailruCall;
	import mailru.MailruCallEvent;	
	import flash.utils.setTimeout;
	
	public class MailConnector extends Connector implements IConnector
	{		
		private var _vid:String;
		
		public function MailConnector(flashvars:Object, onComplete : Function)
		{
			Security.allowDomain ( '*' );
			this._vid = flashvars['vid'];
			MailruCall.addEventListener(Event.COMPLETE, mailruReadyHandler);
			MailruCall.init("flash-app", flashvars['private_key']);
			setTimeout(onComplete,1); // Костылёк из за FB который запускается с задержкой
		}
		
		private function mailruReadyHandler(event : Event) : void
		{

		}
		public function showSetting():void
		{
			
		}
		public function getSettings(onComplete:Function, onError:Function):void
		{
			
		}
		
		public function getCurrentUser(onComplete:Function, onError:Function):void
		{
			var uids : Array = [_vid]
						MailruCall.exec('mailru.common.users.getInfo', 
							function(obj : Object) : void
							{
								var users:Vector.<UserVO> = new Vector.<UserVO>();
								for (var i:int = 0; i < obj.length; i++) 
								{
									users.push(new UserVO(ConnectorType.CONNECTOR_MAILRU,obj[i]));
								}
								
								if (onComplete != null)
								{
									onComplete(users);
								}
							},
							uids
						);
		}
		
		
		public function getFriends(userID:String, offset:uint, count:uint, onComplete:Function, onError:Function):void
		{
			MailruCall.exec('mailru.common.friends.getAppUsers', 
				function (obj : Object) : void
				{
					var ids:Array = new Array();
					
					for (var i:int = 0; i < obj.length; i++) 
					{
						ids.push(obj[i]);
					}
					
					friends(userID, offset, count, onComplete, onError,ids as Array);
				}
			);	
		}
		private function friends (userID:String, offset:uint, count:uint, onComplete:Function, onError:Function, isInstalled:Array):void
		{
			if (userID == null || userID == "") userID = _vid;
			MailruCall.exec('mailru.common.friends.getExtended', 
				function (obj : Object) : void
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
						users.push(new UserVO(ConnectorType.CONNECTOR_MAILRU, obj[i]));
					}
					
					if (onComplete != null)
					{
						onComplete(users);
					}
				},
				{uid:userID,offset:offset}
			);			
		}
		
	
		
		public function postToWall(userID:String, message:String, onComplete:Function, onError:Function):void
		{
			MailruCall.addEventListener(MailruCallEvent.GUESTBOOK_PUBLISH, 
				function (event : MailruCallEvent) : void
				{
					if (event.data != null)
					{
						if (event.data.status == "publishSuccess")
						{
							if (onComplete != null)
							{
								onComplete(event);
								return;
							}
						}
						if (event.data.status == "publishFail")
						{
							if (onError != null)
							{
								onError(event);
								return;
							}
						}
					}
				}
			);
			
			if (userID == null || userID == "") userID = _vid;
			MailruCall.exec('mailru.common.guestbook.post', 
				function (obj : Object) : void
				{
					if (onComplete != null)
					{
						onComplete(obj);
					}
				},
				{uid:userID,text:message}
			);
		}
		
			
		public function showInvite(onComplete:Function, onError:Function,userID:String = null):void
		{
			MailruCall.exec('mailru.app.friends.invite');
		}

		
		public function get viewerID():String
		{
			//TODO: implement function
			return null;
		}
	}
}