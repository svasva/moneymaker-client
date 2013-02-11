package
{
    import mx.core.FlexGlobals;
	
	public class Config
	{	
		public static const LOCAL:String = "local";
		public static const VKONTAKTE:String = "vkontakte";
		public static const MAIL:String = "mail";
		public static const FACEBOOK:String = "facebook";
		public static const ODNOKLASSNIKI:String = "odnoklassniki";
		
		
		public static var social:String = '';
		
		public static function get WIDTH():Number 	{
			return 760;
		}
		
		public static function get HEIGHT():Number	{
			return 760;
		}
		
		public static var VER:String				= '0.201';

		//--------------------------------------------------------------------------------
		
		public static var DEBUG:Boolean				= false;
		
		public static var VK_API_VERSION:String  	= "2.0";
		public static var VK_API_TEST_MODE:String  	= "1";
		public static var VK_API_FORMAT:String  	= "JSON";
		
		public static var FB_API_ID:String          = "???????????????";
		public static var FB_API_KEY:String         = "????????????????????????????????";
		
		//--------------------------------------------------------------------------------

		public static var STAGE:String				= ""; // dev / live
		public static var NETWORK:String            = ''; // vk / mm / ok
		
		public static var STATIC_URL:String 		= '';
		public static var STATIC_PATH:String 		= '';
		public static var STATIC_PATH_HASHED:String = '';
		public static var STATIC_HASHED:Boolean 	= false;
		
		public static var SERVER_DOMAIN:String      = '';
		public static var SERVER_URL:String         = '';
		
		public static var BACKEND_API_URL:String	= '';
		
		public static var VK_API_URL:String 		= "http://api.vkontakte.ru/api.php";
		public static var VK_API_ID:String  		= "3227016";
		
		//for facebook
		public static var APP_URL:String            = '';
		public static var APP_SUPPORT_URL:String    = '';
		
		//for ok
		public static var OK_API_URL:String 		= "";
		public static var OK_API_ID:String  		= "";
		public static var OK_API_KEY:String			= "";
		
		//for mm
		public static var MM_API_URL:String 		= "";
		public static var MM_API_ID:String  		= "";
		public static var MM_API_SECRET:String	= 	"";
		
		public static function init(_soc:String):void {
		
			social = _soc;
			
			if (social == LOCAL) {
				STAGE					= "dev"; // dev / live
				NETWORK           		= 'vk'; // vk / mm / ok

				STATIC_URL 				= 'http://www.test1.ru/';
				STATIC_PATH 			= STATIC_URL + 'assets/';
				STATIC_PATH_HASHED 		= STATIC_URL + 'hashed/';
				STATIC_HASHED 			= false;
			
				SERVER_DOMAIN      		= 'work2.local';
				SERVER_URL         		= 'api.php';
			
				BACKEND_API_URL			= 'http://work2.local/api.php';
			
				VK_API_URL 				= "http://www.test1.ru/social/vk.php";
				VK_API_ID  				= "???????";
			}
		
			if (social == VKONTAKTE) {
				STAGE				= "live"; // dev / live
				NETWORK           	= 'vk'; // vk / mm / ok
			
				STATIC_URL 			= 'http://mm.so14.org/';
				STATIC_PATH 		= STATIC_URL + 'assets/';
				STATIC_PATH_HASHED 	= STATIC_URL + 'hashed/';
				STATIC_HASHED 		= false;
			
				SERVER_DOMAIN       = 'http://api.vkontakte.ru';
				SERVER_URL          = 'api.php';
			
				BACKEND_API_URL		= 'url/api.php';
			
				VK_API_URL 			= "http://api.vkontakte.ru/api.php";
				VK_API_ID			= "3227016";
			}
		
			if (social == FACEBOOK) {
				STAGE				= "live"; // dev / live
				NETWORK             = 'fb'; // vk / mm / ok
			
				STATIC_URL 			= 'url';
				STATIC_PATH 		= STATIC_URL + 'assets/';
				STATIC_PATH_HASHED 	= STATIC_URL + 'hashed/';
				STATIC_HASHED 		= false;
			
				BACKEND_API_URL 	= "";
			
				SERVER_DOMAIN     	= '??.ru';
				SERVER_URL         	= 'api.php';
			
				APP_URL	          	= 'http://apps.facebook.com/work/';
				APP_SUPPORT_URL    	= 'http://apps.facebook.com/work/';
			}
		
			if (social == ODNOKLASSNIKI) {
				STAGE					= "live"; // dev / live
				NETWORK            		= 'ok'; // vk / mm / ok
			
				STATIC_URL 				= 'url';
				STATIC_PATH 			= STATIC_URL + 'assets/';
				STATIC_PATH_HASHED 		= STATIC_URL + 'hashed/';
				STATIC_HASHED		 	= false;
			
				SERVER_DOMAIN      		= '??.ru';
				SERVER_URL         		= 'api.php';
			
				OK_API_URL 				= "http://www.appsmail.ru/platform/api";
				OK_API_ID  				= "???????";
				OK_API_KEY				= "?????????????????";
			
			}
		
			if (social == MAIL) {
				STAGE					= "live";
				NETWORK         		= 'mm';
			
				STATIC_URL 				= 'url';
				STATIC_PATH 			= STATIC_URL + 'assets/';
				STATIC_PATH_HASHED 		= STATIC_URL + 'hashed/';
				STATIC_HASHED 			= false;
			
				BACKEND_API_URL 		= "??/api.php";
			
				SERVER_DOMAIN      		= '??.ru';
				SERVER_URL         		= 'api.php';
			
				MM_API_URL 				= "http://www.appsmail.ru/platform/api";
				MM_API_ID  				= "??????";
				MM_API_SECRET			= "????????????????????????????????";
			}
		}
		
		public static function get parameters():Object
		{
			if (social == LOCAL) 			return FlexGlobals.topLevelApplication.flashVars;
			//return FlexGlobals.topLevelApplication.flashVars
			return FlexGlobals.topLevelApplication.flashVars
		}
		
		public static const VK_DUMMY_VIEWER_ID:Number //= 180820330;	//= ???;
		public static const MM_DUMMY_VIEWER_ID:Number	//= ???;
	 	public static const OK_DUMMY_VIEWER_ID:Number	//= ???;
	}
}