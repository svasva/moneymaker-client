package classes 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author 
	 */
	public class FriendBarItem extends Sprite 
	{
		private var _friendItemComp:CardProfile;		
		private var btnSend:MovieClip;
		private var btnGift:MovieClip;
		
		private var btnHome:MovieClip;
		private var btnVisit:MovieClip;
		public var btnInvite:MovieClip;
		private var iconOffLine:MovieClip;
		private var iconOnLine:MovieClip;
		
		private var iconScore:MovieClip;
		
		private var txtScore:TextField;
		private var txtName:TextField;
		
		private var body:MovieClip;
		private var tools:MovieClip;
		private var phPhoto:MovieClip;
		
		private var _userName:String;
		private var _imgUrl:String = "_";
		private var _ldr:Loader = new Loader();
		private var _masking:MovieClip;
		private var _isAppUser:Boolean;
		
		public function FriendBarItem() 
		{
			_friendItemComp = new CardProfile();
			_friendItemComp.body.stop();
			body = _friendItemComp.body;
			addChild(_friendItemComp);
			
			btnHome  = body.getChildByName("btnHome") as MovieClip;
			btnHome.visible = false;
			
			btnSend = body.getChildByName("btnSend") as MovieClip;
			btnSend.visible = false;
			btnGift = body.getChildByName("btnGift") as MovieClip;
			btnGift.visible = false;
			btnVisit = body.getChildByName("btnVisit") as MovieClip;
			btnVisit.visible = false;
			btnInvite = body.getChildByName("btnInvite") as MovieClip;
			btnInvite.visible = false;
			btnInvite.buttonMode = true;
			tools = body.getChildByName("tools") as MovieClip;
			iconOffLine = tools.getChildByName("iconOffLine") as MovieClip;
			iconOffLine.visible = false;
			iconOnLine = tools.getChildByName("iconOnLine") as MovieClip;
			iconOnLine.visible = false;
			
			txtScore = tools.getChildByName("txtScore") as TextField;
			txtScore.visible = false;
			txtName = tools.getChildByName("txtName") as TextField;
			
			iconScore  = tools.getChildByName("iconScore") as MovieClip;
			iconScore.visible = false;
			
			phPhoto =  tools.getChildByName("phPhoto") as MovieClip;
			_masking =  tools.getChildByName("masking") as MovieClip;
			phPhoto.mask = _masking;
			phPhoto.addChild(_ldr);
			phPhoto.y = 22;
			
		}
		public function clearItem():void
		{
			userName = "";
			_ldr.unload();
			iconOnLine.visible = false;
			btnInvite.visible = false;
		}
		
		public function get userName():String 
		{
			return _userName;
		}
		
		public function set userName(value:String):void 
		{
			_userName = value;
			txtName.text = value;
		}
		
		public function get imgUrl():String 
		{
			return _imgUrl;
		}
		
		public function set imgUrl(value:String):void 
		{
			_ldr.unload();
			_imgUrl = value;
			if(_imgUrl)
			_ldr.load(new URLRequest(_imgUrl))
		}
		
		public function get isAppUser():Boolean 
		{
			return _isAppUser;
		}
		
		public function set isAppUser(value:Boolean):void 
		{
			_isAppUser = value;
			if (_isAppUser)
			{
				iconOnLine.visible = true;
			}
			else
			{
				btnInvite.visible = true;
			}
		}
		
		
		
	}

}