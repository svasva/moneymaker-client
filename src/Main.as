package 
{
	import asst.api.SocialClient;
	
	import flash.display.*;
	import flash.events.*;
	import flash.events.ErrorEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Security;

	import head.FriendPanel;
	
	import legacy.ContentLoader;
	
	[SWF(width="760", height="760", frameRate="24", backgroundColor="#FFFFFF")]
	public class Main extends MovieClip
	{
		public var mainClass:Class = Main;
		
		private static var _instance:Main;
		
		public static var viewer_id:String = '';

	
		public static var friendPanel:FriendPanel;
		
		
		
		static public function get instance():Main
		{
			return _instance;
		}
		
		public function Main():void
		{
			_instance = this;
			
			Security.allowDomain("*");

			if (stage){
				init0();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init0);
			}
		}
		
		public function init0(e:Event = null):void
		{
			Config.init(Config.LOCAL);
			SocialClient.forceInit = true;
			SocialClient.init(tier2);
		}
		
		public function tier2():void
		{
			SocialClient.adapter.startupCheck(tier3);
		}
		
		public function tier3():void
		{
			init();
		}
		
		private function init(e:Event=null):void
		{
			
			
			Friends.init();
			
			//friendPanel = new FriendPanel();
			//friendPanel.y = 340;
			//addChild(friendPanel);
		}
	}
} 
