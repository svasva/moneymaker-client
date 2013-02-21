package social.connector
{
	
	
	import flash.display.BitmapData;

	public interface IConnector
	{
		function getSettings(onComplete:Function, onError:Function):void;
		function getCurrentUser(onComplete:Function, onError:Function):void;
		function getFriends(userID:String, offset:uint, count:uint, onComplete:Function, onError:Function):void;
		function postToWall(userID:String, message:String, onComplete:Function, onError:Function):void;
		function showInvite(onComplete:Function, onError:Function, userID:String = null):void;
		function showSetting():void;
		function get viewerID():String		
	}
}