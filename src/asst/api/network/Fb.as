/* $Id: Fb.as 680 2010-11-09 12:41:15Z micanec $ */
package asst.api.network
{
	
	
	import com.facebook.graph.Facebook;
	
	public class Fb
	{
		/**
		 * OpenGraph api probably..
		 */
		public static const STREAM_PUBLISH:String 			= 'stream.publish';
		
		/**
		 * Old rest api methods
		 * @see http://developers.facebook.com/docs/reference/rest
		 */
		public static const FRIENDS_GET:String 			 	= 'friends.get';
		public static const FRIENDS_GET_APP_USERS:String 	= 'friends.getAppUsers';
		public static const USERS_GET_STANDARD_INFO:String  = 'users.getStandardinfo';
		public static const USERS_IS_APP_USER:String        = 'users.isAppUser';
		
		public static const PHOTOS_GET_ALBUMS:String		= 'photos.getAlbums';
		public static const PHOTOS_CREATE_ALBUM:String		= 'photos.createAlbum';
		public static const PHOTOS_UPLOAD:String			= 'photos.upload';
		
		public function Fb()
		{}
		
		public static function init(appId:String, callback:Function):void
		{
			Facebook.init(appId, function(response:Object, fail:Object):void {
				if (fail != null) {
					throw new Error('There is not everything is good with facebook bridging');
				}
				callback();
			}, {frictionlessRequests: true});
			
		}
		
		public static function request(method:String, callback:Function = null, options:Object = null):void
		{
			
			var api:Function = method.substring(0, 1) == '/' ? Facebook.api : Facebook.callRestAPI;
			//			Facebook.callRestAPI(method, function(response:Object, error:Object):void {
			api(method, function(response:Object, error:Object):void {
				if (error != null) {
					_handleError(error);
				} 
				
				if (callback != null) {
					callback(response);
				}
			}, options, method.substring(0, 1) == '/' ? 'POST' : 'GET');
		}
		
		public static function ui(method:String, callback:Function = null, options:Object = null):void
		{
			if (!options) options = {};
			Facebook.ui(method, options, callback);
		}

		public static function fql(query:String, callback:Function = null):void
		{
			Facebook.fqlQuery(query, function(response:Object, error:Object):void {
				if (error != null) {
					_handleError(error);
				} 
				
				if (callback != null) {
					callback(response);
				}
			});
		}
		
		private static function _handleError(error:Object):void
		{
//			Log.debug(error);
			throw new Error('There is an error during communicating between us and facebook: '+error.toString());
		}
		
		
	}
}