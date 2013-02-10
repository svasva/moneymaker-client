package asst.api {
	
	import asst.api.network.*;
	import asst.api.network.FbAdapter;
	import asst.api.network.IAdapter;
	
	import flash.utils.ByteArray;

	
	/**
	 * This class is universal data provider and acccessor for all social networks we
	 * use, such as vk.com, my.mail.ru, odnoklassniki.ru and future networks as well.
	 * 
	 * There is a "proxy" static methods for common api methods in each social network 
	 * so you do not need to carry about compability and similar things when you using it.
	 * 
	 * Please make sure that you have Config.as file with correct properties "NETWORK" and 
	 * "STAGE", otherwise functionality of this universal class may be fucked up.
	 */
	public class SocialClient 
	{
		/**
		 * Social network code - for vkontakte.ru
		 */ 
        public static var NETWORK_VK:String = 'vk';
		
		/**
		 * Social network code - for my.mail.ru
		 */ 
        public static var NETWORK_MM:String = 'mm';
		
		/** 
		 * Social network code - for odnoklassniki.ru
		 */ 
		public static var NETWORK_OK:String = 'ok';
		
		/**
		 * Social network code - for facebook.com
		 */ 
		public static var NETWORK_FB:String = 'fb';
		
		public static var adapters:Object = null;
		
		public static var adapter:IAdapter;
		
		/**
		 * This variable using in case with my.mail.ru network due to provide actual information
		 * about init status of native api lib
		 * 
		 * @see asst.api.mailru.*
		 */ 
		public static var forceInit:Boolean	= false;
		
		/**
		 * Class constructor
		 */ 
		public function SocialClient()
		{}
		
		/**
		 * Initilazer
		 * 
		 * In this method performs configuration of class and setting all require environment for
		 * correct operation. In this method initialize all other libs for each network.
		 * 
		 * @see   asst.api.network.*Adapter;
		 * @param callback Function which will be called after successful initiliation of whole api client
		 */
		public static function init(callback:Function):void
		{
			adapter = _currentAdapter();
			
			if (adapter == null) {
				throw new Error('Unknown network type'); 
			}
			
			adapter.init(function():void{
				Main.viewer_id = adapter.envViewerId;
				callback();
			});
			
			Main.viewer_id = adapter.envViewerId;
		}
		
		private static function _currentAdapter():* {
			if (Config.social == Config.LOCAL) 			return new VkAdapter();
			if (Config.social == Config.MAIL)  			return new MmAdapter();
			if (Config.social == Config.VKONTAKTE) 		return new VkAdapter();
			if (Config.social == Config.FACEBOOK) 		return new FbAdapter();
			if (Config.social == Config.ODNOKLASSNIKI)  return new OkAdapter();
			
			return null;
		}
  	}
	
}
