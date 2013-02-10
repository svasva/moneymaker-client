package
{
	import com.adobe.serialization.json.JSON;
	import flash.utils.ByteArray;
	
	public class Settings 
	{
	
	/*	[Embed(source="../../server/settings/apiSecretSig", mimeType="application/octet-stream")]
		private static var _resSecretSig:Class;
		public static var secretSig:String = (new _resSecretSig as ByteArray).toString();
		
		[Embed(source="../../server/settings/apiSecretEnc", mimeType="application/octet-stream")]
		private static var _resSecretEnc:Class;
		public static var secretEnc:String = (new _resSecretEnc as ByteArray).toString();*/
		
		public function Settings()
		{}
		
		public static function init():void
		{
		}		
		
	}
}
