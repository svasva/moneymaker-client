package asst.api.network
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;

	
	public interface IAdapter extends IEventDispatcher
	{
		
		/**
		 * Initilazer
		 * 
		 * In this method performs configuration of class and setting all require environment for
		 * correct operation. In this method initialize all other libs for each network.
		 * 
		 * @see   asst.api.network.*;
		 * @param callback Function which will be called after successful initiliation of whole api client
		 */
		function init(callback:Function):void;
		
		/**
		 * Cache clearer
		 * 
		 * For some methods we using cache system to reduce amount of requets to remote
		 * api server and retrieve it from local cache. So this method is made up especially
		 * for cleaning cache by provided method.
		 * 
		 * @param method Method name for clearing cache 
		 */
		function clearCache(method:String):void;
		
		/**
		 * Proxy method - checks that user is application user
		 * Check is user installed application or do not.
		 * 
		 * @param callback Function which will be called after getting result from remote api
		 */
		function userIsAppUser(callback:Function):void;
		
		/**
		 * Proxy method - provide settings and permissions for current user
		 * 
		 * Please note that this method will return an exception for some 
		 * social networks becase they do not provide such information.
		 * 
		 * @param  callback Function which will be called after getting result from remote api
		 */
		function userGetSettings(callback:Function):void;
		
		/**
		 * Proxy method - get user balance
		 * Retrieve user balance in social network. 
		 * 
		 * Please note that this method will return an exception for some 
		 * social networks becase they do not provide such information.
		 *
		 * @param  callback Function which will be called after getting result from remote api
		 */
		function userGetBalance(callback:Function):void;
		
		/** 
		 * Proxy method - get friends within network
		 * Return an array with friends uids (friends who is installed same application)
		 * 
		 * @param callback Function which will be called after getting result from api server
		 */
		function userGetFriends(callback:Function):void;
		
		/** 
		 * Proxy method - get application friends 
		 * Return an array with friends uids (friends who is installed same application)
		 * 
		 * @param callback Function which will be called after getting result from api server
		 */  
		function userGetAppFriends(callback:Function):void;
		
		/**
		 * Proxy method - return users profiles
		 * 
		 * This method returns profile information by supplied uids
		 * 
		 * @param callback 		Function which will be called after getting profiles information
		 * @param uids     		Uids of required users
		 * @param cacheClear 	Clear local cache or do not
		 */ 
		function userGetProfiles(callback:Function, uids:Array, сacheClear:Boolean = false):void;
		
		
		/**
		 * Proxy method - return list of user albums
		 * 
		 * Please note that this method is not implemented for some
		 * social networs
		 * 
		 * @param callback Function which will be called after getting result from remote host
		 */ 
		function photoGetAlbums(callback:Function):void;
		
		/** 
		 * Proxy method - create album
		 * 
		 * Creates album with name and call back function with result
		 * 
		 * @param name 		Album name
		 * @param callback 	Function which will be called with result from remote api
		 */
		function photoCreateAlbum(callback:Function, name:String):void;
		
		/**
		 * Proxy method - upload photo to given album (album id)
		 * Uploads raw photo data to specified album
		 * 
		 * @param callback  Function which will be called with result from uploadin process
		 * @param stream	Raw photo data
		 * @param aid		Album Id
		 */ 
		function photoUpload(callback:Function, stream:ByteArray, aid:String):void;
		
		
		/**
		 * Proxy method - open payment dialog window
		 * Note: this method is not working in other than 'live' environment.
		 * 
		 * @param params Misc params which will be passed to native api. It's different for each social network 
		 */
		function dialogPayment(params:Object, callback:Function = null):void;
		
		/**
		 * Proxy method - show invite dialog window
		 * Show window with friends invintation functionality
		 */
		function dialogInvite():void;
		
		/**
		 * Proxy method - show application installation dialog window
		 * Note: the live environment require
		 * 
		 * @param callback Function which will be called after application installation
		 */
		function dialogInstall(callback:Function = null):void;
		
		/** 
		 * Proxy method - post message to users steam
		 * Note: this method is working with vkontakte.ru and my.mail.ru yet.
		 * 
		 * @param params Params with required information to perform this action
		 */
		function streamPublish(title:String, msg:String, imgUrl:String, toUid:String, params:Object = null):void;
		
		/** 
		 * Proxy method - post message to users steam
		 * Note: this method is working with vkontakte.ru and my.mail.ru yet.
		 * 
		 * @param params Params with required information to perform this action
		 */
		function streamPublishRaw(title:String, msg:String, imgRaw:Bitmap, toUid:String):void;
		
		/**
		 * Retrieve application auth key for backend checkings
		 */ 
		function get envAuthKey():String;
		
		/**
		 * Retrieve current viewer id
		 */ 
		function get envViewerId():String;
		
		/**
		 * Retrieve referer id for current user
		 */ 
		function get envRefererId():String;
		
		/**
		 * Retrieve application auth key for backend checkings
		 */ 
		function get envGetShare():String;
		
		/**
		 * Check prerequirements - such as installation, settings
		 */
		function startupCheck(callback:Function):void;
		
	}
}